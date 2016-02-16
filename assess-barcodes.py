#!/usr/bin/env python
from __future__ import print_function
from collections import Counter
import screed
import json
import sys
from os import path
try:
    from itertools import zip
except ImportError:
    pass



def assess_file(filename):
    fq = screed.open(filename)

    ctr = Counter()
    for read_pair in zip(fq, fq):
        r1, r2 = read_pair

        data = json.loads(r1.name.split('\t')[1])
        ctr[data['id']] += 1
    return ctr

if __name__ == "__main__":
    table = {}
    for fn in sys.argv[1:]:
        samp = path.basename(fn).strip().strip('_').split('_')[0]
        ctr = assess_file(fn)
        table[samp] = ctr

    samples = list(table.keys())

    print('\t' + '\t'.join(samples))
    for r in samples:
        print(r, end='')
        for c in samples:
            print('\t{}'.format(table[r][c]), end='')
        print()