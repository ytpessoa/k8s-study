
# 1) Definir variáveis ​​de ambiente do contêiner usando dados do ConfigMap:

# 1.1) Defina uma variável de ambiente do contêiner com dados de um único ConfigMap:
kubectl create configmap special-config --from-literal=special.how=very
#configmap/special-config created

kubectl apply -f pod-single-configmap-env-variable.yaml 
#pod/dapi-test-prod created
kubectl get pods --watch
# NAME             READY   STATUS              RESTARTS   AGE
# dapi-test-prod   0/1     ContainerCreating   0          9s
# dapi-test-prod   0/1     Completed           0          10s