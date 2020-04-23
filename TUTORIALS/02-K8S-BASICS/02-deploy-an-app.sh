# 2-Create a Deployment:
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
kubectl get pods --watch
    # NAME                                   READY   STATUS              RESTARTS   AGE
    # kubernetes-bootcamp-6f6656d949-bc8kx   0/1     ContainerCreating   0          27s
    # kubernetes-bootcamp-6f6656d949-bc8kx   1/1     Running             0          63s
kubectl get deployments
    # NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
    # kubernetes-bootcamp   1/1     1            1           104s


# Proxy: um forma de acessar a rede interna privada do cluster(outra forma é usando Service)
kubectl proxy
#Starting to serve on 127.0.0.1:8001
curl http://localhost:8001/version
# {
#   "major": "1",
#   "minor": "18",
#   "gitVersion": "v1.18.0",
#   "gitCommit": "9e991415386e4cf155a24b1da15becaa390438d8",
#   "gitTreeState": "clean",
#   "buildDate": "2020-03-25T14:50:46Z",
#   "goVersion": "go1.13.8",
#   "compiler": "gc",
#   "platform": "linux/amd64"
# }

# O servidor da API criará automaticamente um endpoint para cada pod, 
# com base no nome do pod, que também pode ser acessado por meio do proxy.

# Obter o nome do Pod e armazenar na variável de ambiente POD_NAME
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
# Name of the Pod: kubernetes-bootcamp-6f6656d949-bc8kx

kubectl get - list resources
kubectl describe - show detailed information about a resource
kubectl logs - print the logs from a container in a pod
kubectl exec - execute a command on a container in a pod

kubectl get pods
# NAME                                   READY   STATUS    RESTARTS   AGE
# kubernetes-bootcamp-6f6656d949-bc8kx   1/1     Running   1          80m

kubectl describe pods kubernetes-bootcamp-6f6656d949-bc8kx 
# Name:         kubernetes-bootcamp-6f6656d949-bc8kx
# Namespace:    default
# Priority:     0
# Node:         minikube/192.168.99.106
# Start Time:   Tue, 21 Apr 2020 15:37:54 -0300
# Labels:       app=kubernetes-bootcamp
#               pod-template-hash=6f6656d949
# Annotations:  <none>
# Status:       Running

# IP:           172.17.0.2

# IPs:
#   IP:           172.17.0.2
# Controlled By:  ReplicaSet/kubernetes-bootcamp-6f6656d949

# Containers:
#   kubernetes-bootcamp:
#     Container ID:   docker://5c24ec1f4f1026347112d826cfd2a45265f174edff7d879b325f14ad4111e654
#     Image:          gcr.io/google-samples/kubernetes-bootcamp:v1
#     Image ID:       docker-pullable://gcr.io/google-samples/kubernetes-bootcamp@sha256:0d6b8ee63bb57c5f5b6156f446b3bc3b3c143d233037f3a2f00e279c8fcc64af
#     Port:           <none>
#     Host Port:      <none>
#     State:          Running
#       Started:      Tue, 21 Apr 2020 16:57:54 -0300
#     Last State:     Terminated
#       Reason:       Error
#       Exit Code:    137
#       Started:      Tue, 21 Apr 2020 15:38:57 -0300
#       Finished:     Tue, 21 Apr 2020 16:56:49 -0300
#     Ready:          True
#     Restart Count:  1
#     Environment:    <none>
#     Mounts:
#       /var/run/secrets/kubernetes.io/serviceaccount from default-token-d6vxf (ro)


# Conditions:
#   Type              Status
#   Initialized       True 
#   Ready             True 
#   ContainersReady   True 
#   PodScheduled      True 
# Volumes:
#   default-token-d6vxf:
#     Type:        Secret (a volume populated by a Secret)
#     SecretName:  default-token-d6vxf
#     Optional:    false
# QoS Class:       BestEffort
# Node-Selectors:  <none>
# Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
#                  node.kubernetes.io/unreachable:NoExecute for 300s
# Events:
#   Type    Reason          Age   From               Message
#   ----    ------          ----  ----               -------
#   Normal  SandboxChanged  35s   kubelet, minikube  Pod sandbox changed, it will be killed and re-created.
#   Normal  Pulled          34s   kubelet, minikube  Container image "gcr.io/google-samples/kubernetes-bootcamp:v1" already present on machine
#   Normal  Created         34s   kubelet, minikube  Created container kubernetes-bootcamp
#   Normal  Started         33s   kubelet, minikube  Started container kubernetes-bootcamp

#Interagir com o proxy:
kubectl proxy
#Starting to serve on 127.0.0.1:8001

export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

# To see the output of our application, run a curl request:
curl http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME/proxy/
# O URL é a rota para a API do Pod.

# Tudo o que o aplicativo normalmente envia para STDOUT se torna logs para o contêiner no Pod.
# Podemos recuperar esses logs usando o comando kubectl logs:
kubectl logs $POD_NAME
# Kubernetes Bootcamp App Started At: 2020-04-21T19:57:54.541Z | Running On:  kubernetes-bootcamp-6f6656d949-bc8kx 

# Executing command on the container
kubectl exec $POD_NAME env
# Start a bash session in the Pod’s container:
kubectl exec -ti $POD_NAME bash
ls
#bin  home  lib  root  run....  "server.js" .... tmp  usr  var
curl localhost:8080 #localhost because inside the NodeJS Pod. 
# Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6f6656d949-bc8kx | v=1
exit

