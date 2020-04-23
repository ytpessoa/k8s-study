
# Objectives:
# 1-Deploy a hello world application to Minikube
# 2- Run the application
# 3- View application logs

# 1-Before you begin
server.js
sudo docker build -t im-hello-minikube .
sudo docker images
sudo docker run --rm -p 8080:8080 im-hello-minikube
sudo docker ps

sudo docker tag im-hello-minikube ytpessoa/hello-minikube:1.0.1
sudo docker push  ytpessoa/hello-minikube:1.0.1
sudo docker run --rm -p 8080:8080 ytpessoa/hello-minikube:1.0.1


minikube dashboard


#2-Create a Deployment

kubectl create deployment  hello-minikube  --image=ytpessoa/hello-minikube:1.0.1
kubectl get deployments
    # NAME             READY   UP-TO-DATE   AVAILABLE   AGE
    # hello-minikube   0/1     1            0           91s
kubectl get pods --watch
    # NAME                              READY   STATUS              RESTARTS   AGE
    # hello-minikube-5f5bcd7fb7-75sjm   0/1     ContainerCreating   0          33s
    # after
    # hello-minikube-5f5bcd7fb7-75sjm   1/1     Running             0          2m29s
kubectl get events
    # LAST SEEN   TYPE     REASON              OBJECT                                 MESSAGE
    # 3m46s       Normal   Scheduled           pod/hello-minikube-5f5bcd7fb7-75sjm    Successfully assigned default/hello-minikube-5f5bcd7fb7-75sjm to minikube
    # 3m45s       Normal   Pulling             pod/hello-minikube-5f5bcd7fb7-75sjm    Pulling image "ytpessoa/hello-minikube:1.0.1"
    # 78s         Normal   Pulled              pod/hello-minikube-5f5bcd7fb7-75sjm    Successfully pulled image "ytpessoa/hello-minikube:1.0.1"
    # 78s         Normal   Created             pod/hello-minikube-5f5bcd7fb7-75sjm    Created container hello-minikube
    # 77s         Normal   Started             pod/hello-minikube-5f5bcd7fb7-75sjm    Started container hello-minikube
    # 3m46s       Normal   SuccessfulCreate    replicaset/hello-minikube-5f5bcd7fb7   Created pod: hello-minikube-5f5bcd7fb7-75sjm
    # 3m46s       Normal   ScalingReplicaSet   deployment/hello-minikube              Scaled up replica set hello-minikube-5f5bcd7fb7 to 1

kubectl config view # the kubectl configuration
# apiVersion: v1

# clusters:
# - cluster:
#     certificate-authority-data: DATA+OMITTED
#     server: https://34.71.138.174
#   name: gke_all-timing-management-254_us-central1_gke-management-1

# - cluster:
#     certificate-authority: /home/ytallo/.minikube/ca.crt
#     server: https://192.168.99.105:8443
#   name: minikube

# contexts:
# - context:
#     cluster: gke_all-timing-management-254_us-central1_gke-management-1
#     user: gke_all-timing-management-254_us-central1_gke-management-1
#   name: gke_all-timing-management-254_us-central1_gke-management-1

# - context:
#     cluster: minikube
#     user: minikube
#   name: minikube

# current-context: minikube

# kind: Config
# preferences: {}

# users:

# - name: gke_all-timing-management-254_us-central1_gke-management-1
#   user:
#     auth-provider:
#       config:
#         access-token: ya29.a0Ae4lvC1ujNATgX_yV8w3H4rOgYLExoG9QfRCwCxv9nCdPf9mm3GymLj1t2FGTRdKr_eiXbV6esackWcx2y3u8okURIFoNBjbpvZ0OfZKz3JOu-QbUCLgt9M-0H_9dY-MLBsXe8P8kThu-IRwcOn0W__xx4z_B05ko2MiHRcWRfwZ
#         cmd-args: config config-helper --format=json
#         cmd-path: /home/ytallo/Downloads/google-cloud-sdk/bin/gcloud
#         expiry: "2020-04-13T01:24:10Z"
#         expiry-key: '{.credential.token_expiry}'
#         token-key: '{.credential.access_token}'
#       name: gcp

# - name: minikube
#   user:
#     client-certificate: /home/ytallo/.minikube/profiles/minikube/client.crt
#     client-key: /home/ytallo/.minikube/profiles/minikube/client.key


# 3-Create a Service: expose the Pod "hello-node"
kubectl get deployments
    #hello-minikube  
kubectl expose deployment hello-minikube  --type=LoadBalancer --port=8080
    #service/hello-minikube exposed
#The --type=LoadBalancer flag indicates that you want to expose your Service outside of the cluster.

kubectl get services
    # NAME             TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
    # hello-minikube   LoadBalancer   10.101.247.203   <pending>     8080:32223/TCP   71s
    # kubernetes       ClusterIP      10.96.0.1        <none>        443/TCP          76m

# EXTERNAL-IP:
#     - On "cloud providers" that support load balancers, an external IP address would be provisioned to access the Service. 
#     - On "minikube" the LoadBalancer type makes the Service accessible through the --> $ minikube service 

minikube service hello-minikube
# |-----------|----------------|-------------|-----------------------------|
# | NAMESPACE |      NAME      | TARGET PORT |             URL             |
# |-----------|----------------|-------------|-----------------------------|
# | default   | hello-minikube |             | http://192.168.99.105:32223 |
# |-----------|----------------|-------------|-----------------------------|
# 🎉  Opening service default/hello-minikube in default browser...

# Hello World!


# 4-Enable addons (Ativar complementos)
# Minikube has a set of built-in(integrados) addons(complementos) that can be enabled, disabled and opened in the local Kubernetes environment.
minikube addons list
    # |-----------------------------|----------|--------------|
    # |         ADDON NAME          | PROFILE  |    STATUS    |
    # |-----------------------------|----------|--------------|
    # | dashboard                   | minikube | enabled ✅   |
    # | default-storageclass        | minikube | enabled ✅   |
    # | efk                         | minikube | disabled     |
    # | freshpod                    | minikube | disabled     |
    # | gvisor                      | minikube | disabled     |
    # | helm-tiller                 | minikube | disabled     |
    # | ingress                     | minikube | disabled     |
    # | ingress-dns                 | minikube | disabled     |
    # | istio                       | minikube | disabled     |
    # | istio-provisioner           | minikube | disabled     |
    # | logviewer                   | minikube | disabled     |
    # | metrics-server              | minikube | disabled     |
    # | nvidia-driver-installer     | minikube | disabled     |
    # | nvidia-gpu-device-plugin    | minikube | disabled     |
    # | registry                    | minikube | disabled     |
    # | registry-aliases            | minikube | disabled     |
    # | registry-creds              | minikube | disabled     |
    # | storage-provisioner         | minikube | enabled ✅   |
    # | storage-provisioner-gluster | minikube | disabled     |
    # |-----------------------------|----------|--------------|

minikube addons enable metrics-server
    # 🌟  The 'metrics-server' addon is enabled
kubectl get pod,svc -n kube-system
    # NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
    # service/kube-dns         ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   85m
    # service/metrics-server   ClusterIP   10.108.111.119   <none>        443/TCP                  47s

minikube addons disable metrics-server
# 🌑  "The 'metrics-server' addon is disabled


# 5 Clean up
kubectl delete service hello-minikube
kubectl delete deployment hello-minikube
minikube stop
minikube delete