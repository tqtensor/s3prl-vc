#!/usr/bin/env bash

db_root=$1
spk=$2
lists_dir=$3

# directory containing the WAV files
wav_directory="${db_root}/${spk}"

# output filenames
train_list="${lists_dir}/train_list.txt"
dev_list="${lists_dir}/dev_list.txt"
eval_list="${lists_dir}/eval_list.txt"

# list all WAV files in the directory and shuffle the list
wav_files=$(find "$wav_directory" -type f -name "*.wav" | shuf)

# downsample to 150 files
wav_files=$(echo "$wav_files" | head -n 150)

# calculate the number of files for each set
total_files=$(echo "$wav_files" | wc -l)
train_count=$((total_files * 80 / 100))
dev_count=$((total_files * 10 / 100))
eval_count=$((total_files - train_count - dev_count))

# extract the file names for each set
train_files=$(echo "$wav_files" | head -n $train_count | xargs -I {} basename {} .wav)
dev_files=$(echo "$wav_files" | tail -n +$((train_count + 1)) | head -n $dev_count | xargs -I {} basename {} .wav)
eval_files=$(echo "$wav_files" | tail -n $eval_count | xargs -I {} basename {} .wav)

# write the file names to their respective output files
echo "$train_files" >"$train_list"
echo "$dev_files" >"$dev_list"
echo "$eval_files" >"$eval_list"

echo "Splitting files complete."
