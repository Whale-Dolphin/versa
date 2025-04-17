#!/bin/bash
#SBATCH -p GPU-shared
#SBATCH --gpus=v100-32:1
#SBATCH -J Test_VERSA
#SBATCH -t 48:00:00
#SBATCH -o output/logs/Test_VERSA_%j.out
#SBATCH -e output/logs/Test_VERSA_%j.err

# Record start time in seconds
start_time=$(date +%s)

source /ocean/projects/cis210027p/ycheng9/miniconda3/bin/activate versa_test

cd /ocean/projects/cis210027p/ycheng9/versa/

./GPU.sh

python -W ignore versa/bin/scorer.py \
  --score_config egs/universa_prepare/universa_prepare.yaml \
  --gt "/ocean/projects/cis210027p/ycheng9/uni-versa/versa/test/test_samples/test1.scp" \
  --pred "/ocean/projects/cis210027p/ycheng9/uni-versa/versa/test/test_samples/test2.scp" \
  --output_file "output/test/test.result" \
  --io kaldi

# Optional: Add error handling
if [ $? -ne 0 ]; then
  echo "Execution failed with exit code: $?"
  exit 1
fi

echo "Task completed!"

# Record end time in seconds
end_time=$(date +%s)

# Calculate execution time in seconds
execution_time=$((end_time - start_time))

# Write execution time to total.time file
echo "$execution_time" > total.time

# Also print execution time to console
echo "Total execution time: $execution_time seconds"
