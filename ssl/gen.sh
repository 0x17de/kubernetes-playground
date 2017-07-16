[ ! -f ca-key.pem ] &&
cfssl gencert -initca config/ca-csr.json | cfssljson -bare ca

echo "== ADMIN"
[ ! -f admin-key.pem ] &&
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=config/ca-config.json \
  -profile=kubernetes \
  config/admin-csr.json | cfssljson -bare admin

echo "== KUBE PROXY"
[ ! -f kube-proxy-key.pem ] &&
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=config/ca-config.json \
  -profile=kubernetes \
  config/kube-proxy-csr.json | cfssljson -bare kube-proxy

echo "== KUBERNETES"
[ ! -f kubernetes-key.pem ] &&
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=config/ca-config.json \
  -profile=kubernetes \
  config/kubernetes-csr.json | cfssljson -bare kubernetes

