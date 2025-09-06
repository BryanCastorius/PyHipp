#!/bin/bash

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l


echo ""
echo "#==========================================================="
echo "Start Times"
head -n 1 -v rplpl-slurm*.out
echo ""
head -n 1 -v rs*.out

echo "End Times"
tail -n 2 -v  rplpl-slurm*.out
for f in rs*slurm*.out; do
    echo "==> $f <=="
    last=$(grep -n "time.struct_time" "$f" | tail -n1 | cut -d: -f1)
    if [ -n "$last" ]; then
        sed -n "${last},$((last+2))p" "$f"
    fi
done
echo "#==========================================================="

