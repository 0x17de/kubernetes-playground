#!/bin/bash

for i in docker kubernetes-{client,node,node-cni,kubelet}; do
	ssh node1 "rpm -q $i >/dev/null || zypper -n in $i"
done

set -a
. ../config
export API_SERVERS=$(ssh node1 cat /var/lib/kubelet/bootstrap.kubeconfig | grep server | cut -d ':' -f2,3,4 | tr -d '[:space:]')

echo "KUBELET_ARGS=\"$(cat kubelet.args | grep -ve '^(|#.*)$' | envsubst | xargs echo)\"" > kubelet
echo "KUBE_PROXY_ARGS=\"$(cat kube-proxy.args | grep -ve '^(|#.*)$' | envsubst | xargs echo)\"" > kube-proxy

