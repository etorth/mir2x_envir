#!/bin/bash

for f in `find . -name "*.txt"`
do
    python guess_enc.py $f
done
