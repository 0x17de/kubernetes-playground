#!/bin/bash

rpm -q flannel >/dev/null || zypper -n in flannel
