#!/bin/bash

echo "02-certs"

cd ssl
./gen.sh
./deploy.sh
