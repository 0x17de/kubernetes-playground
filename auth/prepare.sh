#!/bin/bash

[ ! -f ../envs/ip.env ] && echo -e "INTERNAL_IP=$(hostname -i)\nINTERNAL_IP_DASH=$(hostname -i | tr '.' '-')" > ../envs/ip.env
./token.sh
./kubeconfigs.sh
