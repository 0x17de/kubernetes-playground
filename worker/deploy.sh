#!/bin/bash

kubectl create clusterrolebinding kubelet-bootstrap \
  --clusterrole=system:node-bootstrapper \
  --user=kubelet-bootstrap

ssh node1 mkdir -p /var/lib/{kubelet,kube-proxy,kubernetes}
ssh node1 mkdir -p /var/run/kubernetes
scp kubelet kube-proxy node1:/etc/kubernetes/

. ../config

#ssh node1 "sed -r '
#/DOCKER_OPTS/ {
#/--bip/ {
#  s|--bip=[^ ]+([\" ])|--bip=${SERVICE_SUBNET}\1|
#}
#/--bip/! {
#  s|([\" ])(\"\s*)$|\1--bip=${SERVICE_SUBNET}\2|
#}
#}' /etc/sysconfig/docker"

#echo 'see /etc/sysconfig/docker:'
#echo -e '\e[35mTODO: DOCKER_OPTS="--iptables=false --ip-masq=false --host=unix:///var/run/docker.sock --log-level=error --storage-driver=overlay"\e[0m'

# cni modules
ssh node1 'test -f /opt/cni/bin/flannel' ||
ssh node1 '
mkdir -p /opt/cni
wget -nv https://storage.googleapis.com/kubernetes-release/network-plugins/cni-amd64-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz -O cni.tar.gz
tar -xf cni.tar.gz -C /opt/cni
rm cni.tar.gz
'

#ssh node1 mkdir -p /etc/kubernetes/cni/net.d/
#scp docker_opts_cni.env node1:/etc/kubernetes/cni/
#scp systemd-flannel.conf node1:/etc/systemd/system/docker.service.d/40-flannel.conf
#scp cni-flannel.conf node1:/etc/kubernetes/cni/net.d/10-flannel.conf

ssh node1 systemctl enable docker
ssh node1 systemctl restart docker && echo "== docker started" || echo "== docker failed"
ssh node1 systemctl status docker --no-pager

ssh node1 systemctl enable kubelet
ssh node1 systemctl restart kubelet && echo "== kubelet started" || echo "== kubelet failed"
ssh node1 systemctl status kubelet --no-pager

ssh node1 systemctl enable kube-proxy
ssh node1 systemctl restart kube-proxy && echo "== kube-proxy started" || echo "== kube-proxy failed"
ssh node1 systemctl status kube-proxy --no-pager

