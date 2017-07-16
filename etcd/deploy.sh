#!/bin/bash

[ -f /usr/lib/systemd/system/etcd.service ] && cp /usr/lib/systemd/system/etcd.service ../backups/etcd.service.$TS
[ -f /etc/sysconfig/etcd ] && cp /etc/sysconfig/etcd ../backups/etcd.$TS

cp etcd.service /usr/lib/systemd/system/etcd.service
cp etcd /etc/sysconfig/etcd
chown etcd /etc/sysconfig/etcd

systemctl daemon-reload
systemctl enable etcd
systemctl restart etcd && echo "== etcd is running" || echo "FAILED TO START ETCD"
systemctl status etcd --no-pager
