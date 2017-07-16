#!/bin/bash
TS=$(date +%Y%m%d%H%M%S)

set -a

mkdir -p /etc/etcd
rpm -q etcd >/dev/null || zypper -n in etcd
rpm -q etcdctl >/dev/null || zypper -n in etcdctl

. ../envs/ip.env
[ ! -f ../envs/etcd.env ] && echo "ETCD_NAME=controller-${INTERNAL_IP_DASH}" > ../envs/etcd.env
. ../envs/etcd.env

#[ ! -f etcd ] &&
echo "ETCD_ARGS=\"$(cat etcd.args | grep -vE '^(|#.*)$' | envsubst | xargs echo)\"" > etcd

echo "== Service file"
#[ ! -f etcd.service ] &&
sed -r '
/ExecStart/ {
  /ETCD_ARGS/! {
    s|(/usr/sbin/etcd ).*("?)\s*$|\1\${ETCD_ARGS}\2"|
  }
}' /usr/lib/systemd/system/etcd.service > etcd.service

