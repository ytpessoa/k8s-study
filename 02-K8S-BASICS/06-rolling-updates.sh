
#1-Update the version of the app:

kubectl get deployments
# NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
# kubernetes-bootcamp   2/2     2            2           6h37m
kubectl get pods
# NAME                                   READY   STATUS    RESTARTS   AGE
# kubernetes-bootcamp-6f6656d949-bc8kx   1/1     Running   3          6h37m
# kubernetes-bootcamp-6f6656d949-gmpl8   1/1     Running   0          37m

#Current image version of the app,
kubectl describe pods
    #Image:  gcr.io/google-samples/kubernetes-bootcamp:v1

# Update the image of the application to version 2:
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
    #deployment.apps/kubernetes-bootcamp image updated
kubectl get pods
    # NAME                                   READY   STATUS        RESTARTS   AGE
    # kubernetes-bootcamp-6f6656d949-bc8kx   1/1     Terminating   3          6h41m
    # kubernetes-bootcamp-6f6656d949-gmpl8   1/1     Terminating   0          41m
    # kubernetes-bootcamp-86656bc875-764qx   1/1     Running       0          26s
    # kubernetes-bootcamp-86656bc875-9kcdw   1/1     Running       0          20s



# 2-Verify an update:
kubectl describe services/kubernetes-bootcamp
# ...
# NodePort:                 <unset>  32095/TCP
minikube ip
# 192.168.99.106

curl 192.168.99.106:32095
# Hello Kubernetes bootcamp! | Running on: kubernetes-bootcamp-86656bc875-9kcdw | "v=2"!!!

 # Update can be confirmed:
kubectl rollout status deployment/kubernetes-bootcamp
# deployment "kubernetes-bootcamp" successfully rolled out
kubectl describe pods
#Image:  jocatalin/kubernetes-bootcamp:"v2"!!!



# 3- Rollback(reversão) an update:
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=gcr.io/google-samples/kubernetes-bootcamp:v10
#deployment.apps/kubernetes-bootcamp image updated
kubectl get deployments
# NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
# kubernetes-bootcamp   2/2     1            2           6h50m
# !!!Wrong: We do not have the desired number of Pods available.

kubectl get pods
# NAME                                   READY   STATUS             RESTARTS   AGE
# kubernetes-bootcamp-64468f5bc5-9pcpv   0/1     ImagePullBackOff   0          25s
# kubernetes-bootcamp-86656bc875-764qx   1/1     Running            0          9m11s
# kubernetes-bootcamp-86656bc875-9kcdw   1/1     Running            0          9m5s

# There is no image called v10 in the repository:
kubectl rollout undo deployments/kubernetes-bootcamp
#deployment.apps/kubernetes-bootcamp rolled back

# Reverted the deployment to the previous known state (v2 of the image):
kubectl describe deployments
#Image:        jocatalin/kubernetes-bootcamp:v2
