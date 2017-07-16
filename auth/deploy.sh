#!/bin/bash

cp token.csv /etc/kubernetes/token.csv

ssh node1 mkdir -p /var/lib/{kubelet,kube-proxy}
#mkdir -p ~/.kube/
#cp bootstrap.kubeconfig ~/.kube/config
scp bootstrap.kubeconfig node1:/var/lib/kubelet
scp kube-proxy.kubeconfig node1:/var/lib/kube-proxy

