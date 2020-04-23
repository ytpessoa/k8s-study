
# 3- Service to expose your App
kubectl get services
# NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
# kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   4h1m
kubectl get deployments
#kubernetes-bootcamp  
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
#service/kubernetes-bootcamp exposed
kubectl get services
# NAME                  TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
# kubernetes            ClusterIP   10.96.0.1     <none>        443/TCP          4h4m
# kubernetes-bootcamp   NodePort    10.105.9.96   <none>        8080:30155/TCP   18s
kubectl describe services/kubernetes-bootcamp 
# Name:                     kubernetes-bootcamp
# Namespace:                default
# Labels:                   app=kubernetes-bootcamp
# Annotations:              <none>
# Selector:                 app=kubernetes-bootcamp
# Type:                     NodePort
# IP:                       10.105.9.96
# Port:                     <unset>  8080/TCP
# TargetPort:               8080/TCP

# NodePort:                 <unset>  30155/TCP  !!!!

# Endpoints:                172.17.0.4:8080
# Session Affinity:         None
# External Traffic Policy:  Cluster
# Events:                   <none>

export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
#NODE_PORT=30155

#Test if the app is exposed outside of the cluster:
minikube ip
#192.168.99.106
export NODE_IP=$(minikube ip)
curl $NODE_IP:$NODE_PORT
#Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6f6656d949-bc8kx | v=1
#OR
Web Browser: http://192.168.99.106:30155
#Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6f6656d949-bc8kx | v=1


