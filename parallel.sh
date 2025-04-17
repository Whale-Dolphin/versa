#!/bin/bash

# Check if input file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file=$1
task_name=${2:-test}
ntask=${3:-8}
output_dir=${4:-output}

cd /ocean/projects/cis210027p/ycheng9/uni-versa/versa

mkdir -p "$output_dir/$task_name"

# Get the number of lines in the input file
line_count=$(wc -l < "$input_file")
input_file_name=$(basename "$input_file")
counter=1
n_file_per_task=$(( (line_count + ntask - 1) / ntask ))

if [ "$line_count" -gt ${n_file_per_task} ]; then
    # Split the file into chunks and rename them
    echo "Command: split -l ${n_file_per_task} $input_file temp_split_"
    split -l ${n_file_per_task} "$input_file" temp_split_
    mkdir -p "$output_dir/$task_name/scp_split"
    # Loop through the split files and rename them
    for file in temp_split_*; do
        mv "$file" "$output_dir/$task_name/scp_split/${input_file_name}.$counter"
        ((counter++))
    done
    echo "File has been split into ${input_file_name}.* format"
    echo "Total split $((counter-1)) files created"
else
    # If file has less than or equal to 100 lines, just copy it to Session.scp.1
    cp "$input_file" "$output_dir/$task_name/scp_split/${input_file_name}.scp.1"
    echo "File has less than or equal to ${n_file_per_task} lines, copied to ${input_file_name}.1"
fi

echo "Total lines in input file: $line_count"

mkdir -p "$output_dir/$task_name/logs"
mkdir -p "$output_dir/$task_name/result"
for ((i=1; i<=counter; i++)); do
    # Submit the job using sbatch
    # touch "$output_dir/$task_name/result/${input_file_name}.$i.result"
    # head -n 10 "$output_dir/$task_name/scp_split/${input_file_name}.$i" > "$output_dir/$task_name/result/${input_file_name}.$i.result"
    echo "Submitting job for ${input_file_name}.$i"
    echo "Command: sbatch -J ${task_name}_${i} -o $output_dir/$task_name/logs/${task_name}_%j.out -e $output_dir/$task_name/logs/${task_name}_%j.err run.sh $output_dir/$task_name/scp_split/${input_file_name}.$i $output_dir/$task_name/result/${input_file_name}.$i.result"
    # Submit the job
    # sbatch -J "${task_name}_${i}" \
    #        -o "$output_dir/$task_name/logs/${task_name}_%j.out" \
    #        -e "$output_dir/$task_name/logs/${task_name}_%j.err" \
    #        run.sh "$output_dir/$task_name/scp_split/${input_file_name}.scp.$i" "$output_dir/$task_name/result/${input_file_name}.scp.$i.result" \
    #        2>&1 > "$output_dir/$task_name/logs/sbatch_${i}.log"
    # echo "Job for ${input_file_name}.$i submitted"
    ./run.sh "$output_dir/$task_name/scp_split/${input_file_name}.scp.$i" "$output_dir/$task_name/result/${input_file_name}.scp.$i.result" \
        > "$output_dir/$task_name/logs/sbatch_${i}.log" 2>&1
done

echo "All jobs submitted!"