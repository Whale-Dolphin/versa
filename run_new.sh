#!/bin/bash
#SBATCH -p GPU-shared           # Partition name
#SBATCH --gpus=v100-32:1        # Request 1 H100-80GB GPU
#SBATCH -t 48:00:00             # Time limit: 20 hours (1200 minutes)
#SBATCH -o logs/IEMOCAP_VERSA_%j.out   # Standard output file
#SBATCH -e logs/IEMOCAP_VERSA_%j.err   # Standard error file

# Record start time in seconds
start_time=$(date +%s)

source /ocean/projects/cis210027p/ycheng9/miniconda3/bin/activate versa_test

cd /ocean/projects/cis210027p/ycheng9/versa/

./GPU.sh

python -W ignore versa/bin/scorer.py \
  --score_config egs/universa_prepare/universa_prepare.yaml \
  --gt "$1" \
  --pred "$1" \
  --output_file "$2" \
  --io kaldi

# Optional: Add error handling
if [ $? -ne 0 ]; then
  echo "Execution failed with exit code: $?"
  exit 1
fi

echo "Calculation completed!"

# Record end time in seconds
end_time=$(date +%s)

# Calculate execution time in seconds
execution_time=$((end_time - start_time))

# Write execution time to total.time file
echo "$execution_time" > total.time

# Also print execution time to console
echo "Total execution time: $execution_time seconds"
