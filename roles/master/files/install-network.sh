# Rasperri Pi 2 and 3 = arm
# See: http://kubernetes.io/docs/getting-started-guides/kubeadm/#kubeadm-is-multi-platform
export ARCH=arm
curl -sSL "https://github.com/coreos/flannel/blob/master/Documentation/kube-flannel.yml?raw=true" | sed "s/amd64/${ARCH}/g" | kubectl create -f -