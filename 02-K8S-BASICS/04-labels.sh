# 4- Using labels

kubectl get deployments
#kubernetes-bootcamp   
kubectl describe deployment kubernetes-bootcamp   
#Labels:   app=kubernetes-bootcamp
kubectl get pods -l app=kubernetes-bootcamp
#kubernetes-bootcamp-6f6656d949-bc8kx   
kubectl get services -l app=kubernetes-bootcamp
# NAME                  TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
# kubernetes-bootcamp   NodePort   10.105.9.96   <none>        8080:30155/TCP   96m
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo $POD_NAME
# kubernetes-bootcamp-6f6656d949-bc8kx

#Apply a new label we use the label:
kubectl label pod $POD_NAME app1=v1 
#pod/kubernetes-bootcamp-6f6656d949-bc8kx labeled
kubectl describe pods $POD_NAME
# Labels:  app=kubernetes-bootcamp
#          app1=v1
#          pod-template-hash=6f6656d949
kubectl get pods -l app1=v1
# kubernetes-bootcamp-6f6656d949-bc8kx 


kubectl get service -l app=kubernetes-bootcamp
#kubernetes-bootcamp   NodePort 
kubectl label service kubernetes-bootcamp app1=v1
#service/kubernetes-bootcamp labeled

# Deleting a Service:
kubectl delete service -l app1=v1
curl $(minikube ip):$NODE_PORT
#Connection refused

#The application is up
kubectl exec -ti $POD_NAME bash
curl localhost:8080
#Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-6f6656d949-bc8kx | v=1



