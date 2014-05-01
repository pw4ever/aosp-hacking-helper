#!/bin/bash - 
perl -wnl -e 'our @a; push @a, split /,/, $1 if /groups="([^"]+)"/; END {print join "\n", @a}' .repo/manifest.xml | sort | uniq
