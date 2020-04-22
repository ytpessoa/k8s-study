#1-Create Cluster:

minikube version
minikube start
kubectl version
# Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.0"
# Server Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.0"
kubectl cluster-info
# Kubernetes master is running at https://192.168.99.106:8443
# KubeDNS is running at https://192.168.99.106:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
kubectl get nodes
# NAME       STATUS   ROLES    AGE     VERSION
# minikube   Ready    master   2m18s   v1.18.0
