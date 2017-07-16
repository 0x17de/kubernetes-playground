#!/bin/bash

set -e
for i in $(ls -w1 *.sh | grep -v -e $(basename $0) -e 99-clean.sh | sort); do ./$i; done
echo "Everything went fine!"
