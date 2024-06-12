#bin/bash

# remove public/editions
rm -r ./public/editions
# create public/editions
mkdir ./public/editions
# Copy data to public folder
cp -r ./editions/raw/*.xml ./public/editions/
cp -r ./editions/raw/*.xml ./public/editions/
