#!/usr/bin/env bash

# Directory containing the WAV files
wav_directory="./downloads/bahnar/MGL1"

# Output filenames
train_list="./local/lists/train_list.txt"
dev_list="./local/lists/dev_list.txt"
eval_list="./local/lists/eval_list.txt"

# List all WAV files in the directory and shuffle the list
wav_files=$(find "$wav_directory" -type f -name "*.wav" | shuf)

# Downsample to 150 files
wav_files=$(echo "$wav_files" | head -n 150)

# Calculate the number of files for each set
total_files=$(echo "$wav_files" | wc -l)
train_count=$((total_files * 80 / 100))
dev_count=$((total_files * 10 / 100))
eval_count=$((total_files - train_count - dev_count))

# Extract the file names for each set
train_files=$(echo "$wav_files" | head -n $train_count | xargs -I {} basename {} .wav)
dev_files=$(echo "$wav_files" | tail -n +$((train_count + 1)) | head -n $dev_count | xargs -I {} basename {} .wav)
eval_files=$(echo "$wav_files" | tail -n $eval_count | xargs -I {} basename {} .wav)

# Write the file names to their respective output files
echo "$train_files" >"$train_list"
echo "$dev_files" >"$dev_list"
echo "$eval_files" >"$eval_list"

echo "Splitting files complete."
