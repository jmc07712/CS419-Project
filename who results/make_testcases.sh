#!/bin/bash

objdump -d 'who/coreutils-8.24-lava-safe/src/who.o' | grep -Eo '\$0x[0-9a-f]+' | cut -c 2- | sort -u | while read const; do echo $const | python -c 'import sys, struct; sys.stdout.write("".join(struct.pack("<I" if len(l) <= 11 else "<Q", int(l,0)) for l in sys.stdin.readlines()))' > testcases_who/$const; done
i=0; strings 'who/coreutils-8.24-lava-safe/src/who.o'| while read line; do echo -n "$line" > testcases_who/string_${i} ; i=$[ $i + 1 ] ; done
