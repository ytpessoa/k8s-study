
# 1 - Running Multiple Instances of Your App:

kubectl get deployments
# NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
# kubernetes-bootcamp   1/1     1            1           5h53m

# NAME:          lists the names of the Deployments in the cluster.
# READY:         shows the ratio of CURRENT/DESIRED replicas
# UP-TO-DATE:    displays the number of replicas that have been updated to achieve(alcançar) the desired state.
# AVAILABLE:     displays how many replicas of the application are available to your users.
# AGE:           displays the amount of time that the application has been running.

kubectl get replicaset
# NAME                             DESIRED   CURRENT   READY   AGE
# kubernetes-bootcamp-6f6656d949     1         1         1       5h56m
#[DEPLOYMENT-NAME]-[RANDOM-STRING]
    # RANDOM-STRINGThe random string is randomly generated and uses the pod-template-hash as a seed.

# DESIRED displays the desired number of replicas of the application, which you define when you create the Deployment. This is the desired state.
# CURRENT displays how many replicas are currently running.

#Scaling:
kubectl scale deployment/kubernetes-bootcamp --replicas=4
#deployment.apps/kubernetes-bootcamp scaled
kubectl get deployments
# NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
# kubernetes-bootcamp   4/4     4            4           6h1m
kubectl get rs
# NAME                             DESIRED   CURRENT   READY   AGE
# kubernetes-bootcamp-6f6656d949   4         4         4       6h

# 4 instances(4 Pods) of the application available:
kubectl get pods -o wide
# NAME                                   READY   STATUS    RESTARTS   AGE    IP           NODE       NOMINATED NODE   READINESS GATES
# kubernetes-bootcamp-6f6656d949-47xbw   1/1     Running   0          89s    172.17.0.7   minikube   <none>           <none>
# kubernetes-bootcamp-6f6656d949-bc8kx   1/1     Running   3          6h1m   172.17.0.4   minikube   <none>           <none>
# kubernetes-bootcamp-6f6656d949-gmpl8   1/1     Running   0          89s    172.17.0.5   minikube   <none>           <none>
# kubernetes-bootcamp-6f6656d949-n5q45   1/1     Running   0          89s    172.17.0.6   minikube   <none>           <none>

kubectl describe deployments/kubernetes-bootcamp
# Name:                   kubernetes-bootcamp
# Labels:                 app=kubernetes-bootcamp
# Selector:               app=kubernetes-bootcamp
# Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
# NewReplicaSet:   kubernetes-bootcamp-6f6656d949 (4/4 replicas created)
# Events:
#   Type    Reason             Age    From                   Message
#   ----    ------             ----   ----                   -------
#   Normal  ScalingReplicaSet  3m18s  deployment-controller  Scaled up replica set kubernetes-bootcamp-6f6656d949 to 4


# 2 Load Balancing:

kubectl describe services/kubernetes-bootcamp
# Name:                     kubernetes-bootcamp
# Labels:                   app=kubernetes-bootcamp
# Selector:                 app=kubernetes-bootcamp
# Type:                     NodePort
# IP:                       10.110.239.111
# Port:                     <unset>  8080/TCP
# TargetPort:               8080/TCP
# NodePort:                 <unset>  32095/TCP !!!
# Endpoints:                172.17.0.4:8080,172.17.0.5:8080,172.17.0.6:8080 + 1 more...
# External Traffic Policy:  Cluster


export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo $NODE_PORT
# 32095
export NODE_IP=$(minikube ip)
echo $NODE_IP
#192.168.99.106

# A different Pod with every request:  load-balancing is working!
curl $NODE_IP:$NODE_PORT
# Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6f6656d949-47xbw | v=1
curl $NODE_IP:$NODE_PORT
# Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6f6656d949-gmpl8 | v=1
curl $NODE_IP:$NODE_PORT
# Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6f6656d949-bc8kx | v=1


# 3-Scale Down:
kubectl scale deployment/kubernetes-bootcamp --replicas=2
#deployment.apps/kubernetes-bootcamp scaled
kubectl get deployments
# NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
# kubernetes-bootcamp   2/2     2            2           6h17m
kubectl get pods -o wide
# NAME                                   READY   STATUS    RESTARTS   AGE     IP           NODE       NOMINATED NODE   READINESS GATES
# kubernetes-bootcamp-6f6656d949-bc8kx   1/1     Running   3          6h18m   172.17.0.4   minikube   <none>           <none>
# kubernetes-bootcamp-6f6656d949-gmpl8   1/1     Running   0          17m     172.17.0.5   minikube   <none>           <none>

