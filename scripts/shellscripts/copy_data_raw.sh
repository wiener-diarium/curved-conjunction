#bin/bash

# remove public/editions
rm -r ./editions/raw
# create public/editions
mkdir ./editions/raw
# Copy data to public folder
cp -r ./data/editions/legacy/*.xml ./editions/raw/
cp -r ./data/editions/present/*.xml ./editions/raw/
