#!/bin/bash

# first argument is the reference branch to, default is submitted
branch_reference=${1:-submitted}

echo "Comparing to $branch_to_compare"

for file in chapters/0*.tex; do
    # run latexdiff-vc on the file
    latexdiff-vc -r $branch_reference $file
done
