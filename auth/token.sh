#!/bin/bash

[ ! -f ../envs/token.env ] && echo BOOTSTRAP_TOKEN=$(head -c 16 /dev/urandom | od -An -t x | tr -d ' ') > ../envs/token.env

. ../envs/token.env
cat > token.csv <<EOF
${BOOTSTRAP_TOKEN},kubelet-bootstrap,10001,"system:kubelet-bootstrap"
EOF
