#Configurar um cache Redis usando dados armazenados em um ConfigMap:
# Files:
# ├── kustomization.yaml
# ├── pod-redis.yaml
# ├── redis-config

#Apply the kustomization directory to create both the ConfigMap and Pod objects:
kubectl apply -k .

kubectl get -k .
# NAME                                          DATA   AGE
# configmap/configmap-redis-config-dm5gkk5bfb   1      4m42s

# NAME        READY   STATUS    RESTARTS   AGE
# pod/redis   1/1     Running   0          4m42s

kubectl get pods
# NAME    READY   STATUS    RESTARTS   AGE
# redis   1/1     Running   0          5m44s

kubectl exec -ti redis bash
#root@redis:/data# 
redis-cli
#127.0.0.1:6379> 
CONFIG GET maxmemory
# 1) "maxmemory"
# 2) "2097152"
CONFIG GET maxmemory-policy
# 1) "maxmemory-policy"
# 2) "allkeys-lru"

# "maxmemory" and  "maxmemory-policy" have been configured in the file "redis-config"

exit
exit

#Clean up
kubectl delete pods --all
kubectl delete configmaps --all