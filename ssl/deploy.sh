#!/bin/bash

# controller
mkdir -p /var/lib/kubernetes
cp {ca.pem,ca-key.pem,kubernetes-key.pem,kubernetes.pem} /var/lib/kubernetes
chown -R kube /var/lib/kubernetes

# etcd
mkdir -p /etc/etcd
cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/
chown -R etcd /etc/etcd

ssh node1 mkdir -p /etc/etcd
scp ca.pem kubernetes-key.pem kubernetes.pem node1:/etc/etcd/


# nodes
ssh node1 mkdir -p /var/lib/kubernetes
scp ca.pem node1:/var/lib/kubernetes

