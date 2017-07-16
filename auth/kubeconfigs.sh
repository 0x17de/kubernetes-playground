echo "== Bootstrap config"

function filter() {
	grep -v duplicate\ proto
}

. ../envs/ip.env
. ../envs/token.env
KUBERNETES_PUBLIC_ADDRESS="${INTERNAL_IP}"

#if [ ! -f bootstrap.kubeconfig ]; then
kubectl config set-cluster default-cluster \
  --certificate-authority=../ssl/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
  --kubeconfig=bootstrap.kubeconfig |& filter

kubectl config set-credentials kubelet-bootstrap \
  --token=${BOOTSTRAP_TOKEN} \
  --kubeconfig=bootstrap.kubeconfig |& filter

kubectl config set-context default \
  --cluster=default-cluster \
  --user=kubelet-bootstrap \
  --kubeconfig=bootstrap.kubeconfig |& filter

kubectl config use-context default --kubeconfig=bootstrap.kubeconfig |& filter
#fi

echo "== Kube Proxy config"

#if [ ! -f kube-proxy.kubeconfig ]; then
kubectl config set-cluster default-cluster \
  --certificate-authority=../ssl/ca.pem \
  --embed-certs=true \
  --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
  --kubeconfig=kube-proxy.kubeconfig |& filter

kubectl config set-credentials kube-proxy \
  --client-certificate=../ssl/kube-proxy.pem \
  --client-key=../ssl/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig |& filter

kubectl config set-context default \
  --cluster=default-cluster \
  --user=kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig |& filter

kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig |& filter
#fi



