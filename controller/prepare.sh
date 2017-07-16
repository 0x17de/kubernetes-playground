#!/bin/bash

set -a
. ../config
. ../envs/ip.env

echo "KUBE_API_ARGS=\"$(cat apiserver.args | grep -vE '^(|#.*)$' | envsubst | xargs echo)\"" > apiserver
echo "KUBE_CONTROLLER_MANAGER_ARGS=\"$(cat controller-manager.args | grep -vE '^(|#.*)$' | envsubst | xargs echo)\"" > controller-manager
echo "KUBE_SCHEDULER_ARGS=\"$(cat scheduler.args | grep -vE '^(|#.*)$' | envsubst | xargs echo)\"" > scheduler

