#!/bin/bash

objdump -d 'fuzz/crl.o' | grep -Eo '\$0x[0-9a-f]+' | cut -c 2- | sort -u | while read const; do echo $const | python -c 'import sys, struct; sys.stdout.write("".join(struct.pack("<I" if len(l) <= 11 else "<Q", int(l,0)) for l in sys.stdin.readlines()))' > testcases_ssl/$const; done
i=0; strings 'fuzz/crl.o'| while read line; do echo -n "$line" > testcases_ssl/string_${i} ; i=$[ $i + 1 ] ; done
