#!/bin/bash

echo -e "\e[31mWARNING! This will remove stuff on your machine and remotes.\e[0m"
echo -e "\e[33mEnter 'yes' in all CAPS to continue.\e[0m"
read answer
if [ "$answer" != "YES" ]; then
	echo -e "\e[32mNothing happened.\e[0m"
	exit 1
fi
echo -e "\e[32mScrubbing the decks.\e[0m"

for i in kube-{scheduler,controller-manager,apiserver} flanneld etcd; do
	systemctl stop $i
	systemctl disable $i
done

for i in kube{-proxy,let} flanneld; do
	ssh node1 systemctl stop $i
	ssh node1 systemctl disable $i
done

rm -f envs/*
rm -f ssl/*.pem
rm -f ssl/*.csr
rm -f auth/token.csv
rm -f auth/*.kubeconfig
rm -f etcd/etcd
rm -f controller/apiserver
rm -f controller/controller-manager
rm -f controller/scheduler
rm -f worker/kubelet
rm -f worker/kube-proxy

rm -rf /var/lib/kubernetes
rm -rf /etc/kubernetes/*
rm -rf ~/.kube/

ssh node1 rm -rf /var/lib/kubernetes/
ssh node1 rm -rf /var/lib/kube-proxy/*
ssh node1 rm -rf /var/lib/kubelet/*
ssh node1 rm -rf /etc/kubernetes/*
ssh node1 rm -rf /etc/etcd/*
ssh node1 rm -rf ~/.kube/

echo -e "\e[32mDONE.\e[0m"
