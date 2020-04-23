#Adicione dados do ConfigMap a um caminho específico no Volume

#1) Create ConfigMap
kubectl apply -f configmap-multikeys.yaml 
#configmap/configmap-special-config created
kubectl get configmaps
# NAME                       DATA   AGE
# configmap-special-config   2      29m

#2)Preencher um volume com dados armazenados em um ConfigMap:
    # ConfigMap --> Volume do Pod

kubectl apply -f 01-pod-configmap-volume.yaml 
#pod/pod-configmap-volume created


kubectl get pods
#CrashLoopBackOff

kubectl describe pod pod-configmap-volume
#Warning  BackOff    2m34s (x10 over 4m24s)  kubelet, minikube  Back-off restarting failed container


kubectl logs  pod-configmap-volume
# SPECIAL_LEVEL
# SPECIAL_TYPE

