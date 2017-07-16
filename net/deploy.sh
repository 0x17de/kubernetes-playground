#!/bin/bash
TS=$(date +%Y%m%d%H%M%S)

[ -f /etc/sysconfig/flanneld ] && cp /etc/sysconfig/flanneld ../backups/flanneld-$TS
cp flanneld /etc/sysconfig/flanneld
scp flanneld node1:/etc/sysconfig/flanneld

ETCD_CERT_ARGS="--cert-file /etc/etcd/kubernetes.pem --key-file /etc/etcd/kubernetes-key.pem --ca-file /etc/etcd/ca.pem --endpoints https://192.168.1.50:2379"
. ../config

(set +e; etcdctl $ETCD_CERT_ARGS ls /kube-suse/network || etcdctl $ETCD_CERT_ARGS mkdir /kube-suse/network)
etcdctl $ETCD_CERT_ARGS set /kube-suse/network/config "{ \"Network\": \"${POD_SUBNET}\", \"SubnetLen\": 24, \"Backend\": { \"Type\": \"vxlan\" } }"

systemctl enable flanneld
systemctl restart flanneld
systemctl status flanneld --no-pager

ssh node1 systemctl enable flanneld
ssh node1 systemctl restart flanneld
ssh node1 systemctl status flanneld --no-pager


