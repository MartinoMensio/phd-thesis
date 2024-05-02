#!/bin/bash

# first argument is the reference branch to, default is submitted
branch_reference=${1:-submitted}

echo "Comparing to $branch_to_compare"

# remove all files matching chapters/0*-diff*.tex
rm chapters/*-diff*.tex

for file in chapters/0*.tex; do
    # run latexdiff-vc on the file
    latexdiff-vc -r $branch_reference $file
done


python -c "
import os
import glob

to_remove = [
'''\DIFaddbegin \leftskip\DIFadd{=3em
}\parindent\DIFadd{=-3em
}''',
'''\DIFaddbegin \leftskip\DIFadd{=0em
}\parindent \DIFadd{1.5em
}'''
]

for file in glob.glob('chapters/0*-diff*.tex'):
    with open(file, 'r') as f:
        content = f.read()
    for r in to_remove:
        content = content.replace(r, '')
    with open(file, 'w') as f:
        f.write(content)
"
