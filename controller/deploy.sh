#!/bin/bash

cp {,/etc/kubernetes/}apiserver
cp {,/etc/kubernetes/}controller-manager
cp {,/etc/kubernetes/}scheduler

systemctl enable kube-apiserver
systemctl restart kube-apiserver
systemctl status kube-apiserver --no-pager

systemctl enable kube-controller-manager
systemctl restart kube-controller-manager
systemctl status kube-controller-manager --no-pager

systemctl enable kube-scheduler
systemctl restart kube-scheduler
systemctl status kube-scheduler --no-pager

