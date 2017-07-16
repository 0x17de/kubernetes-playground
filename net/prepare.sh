#!/bin/bash

rpm -q flannel >/dev/null || zypper -n in flannel
ssh node1 'rpm -q flannel >/dev/null || zypper -n in flannel'
