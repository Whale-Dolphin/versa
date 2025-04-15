#!/bin/bash
#SBATCH -p GPU-shared
#SBATCH --gpus=v100-32:1
#SBATCH -t 96:00:00

source /ocean/projects/cis210027p/ycheng9/miniconda3/bin/activate versa_test

cd /ocean/projects/cis210027p/ycheng9/versa/

# ./GPU.sh

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

echo "Task completed!"
