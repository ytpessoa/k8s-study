


#1-ConfigMap com base em um diretório:

# Create the local directory:
mkdir -p configure-pod-container/configmap/
#Download the sample files into `configure-pod-container/configmap/`
wget https://kubernetes.io/examples/configmap/game.properties -O configure-pod-container/configmap/game.properties
wget https://kubernetes.io/examples/configmap/ui.properties -O configure-pod-container/configmap/ui.properties
# game.properties  ui.properties

# Create the configmap:
kubectl create configmap <map-name> <data-source>
kubectl create configmap game-config --from-file=configure-pod-container/configmap/
# configmap/game-config created
kubectl describe configmaps game-config
# Name:         game-config
# Namespace:    default
# Labels:       <none>
# Annotations:  <none>

# Data
# ====
# ui.properties:
# ----
# color.good=purple
# color.bad=yellow
# allow.textmode=true
# how.nice.to.look=fairlyNice

# game.properties:
# ----
# enemies=aliens
# lives=3
# enemies.cheat=true
# enemies.cheat.level=noGoodRotten
# secret.code.passphrase=UUDDLRLRBABAS
# secret.code.allowed=true
# secret.code.lives=30
# Events:  <none>

kubectl get configmaps game-config -o yaml
# apiVersion: v1
# data:
#   game.properties: |-
#     enemies=aliens
#     lives=3
#     enemies.cheat=true
#     enemies.cheat.level=noGoodRotten
#     secret.code.passphrase=UUDDLRLRBABAS
#     secret.code.allowed=true
#     secret.code.lives=30
#   ui.properties: |
#     color.good=purple
#     color.bad=yellow
#     allow.textmode=true
#     how.nice.to.look=fairlyNice
# kind: ConfigMap
# metadata:
#   creationTimestamp: "2020-04-22T14:50:10Z"
#   managedFields:
#   - apiVersion: v1
#     fieldsType: FieldsV1
#     fieldsV1:
#       f:data:
#         .: {}
#         f:game.properties: {}
#         f:ui.properties: {}
#     manager: kubectl
#     operation: Update
#     time: "2020-04-22T14:50:10Z"
#   name: game-config
#   namespace: default
#   resourceVersion: "1256"
#   selfLink: /api/v1/namespaces/default/configmaps/game-config
#   uid: 243cd37e-44ac-43cb-901b-780a0e0ce976




#2- Criar ConfigMaps a partir de um arquivo individual ou de vários arquivos:
kubectl create configmap game-config-2 --from-file=configure-pod-container/configmap/game.properties
kubectl describe configmaps game-config-2
# Name:         game-config-2
# Namespace:    default
# Labels:       <none>
# Annotations:  <none>

# Data
# ====
# game.properties:
# ----
# enemies=aliens
# lives=3
# enemies.cheat=true
# enemies.cheat.level=noGoodRotten
# secret.code.passphrase=UUDDLRLRBABAS
# secret.code.allowed=true
# secret.code.lives=30

kubectl create configmap game-config-2 --from-file=configure-pod-container/configmap/game.properties --from-file=configure-pod-container/configmap/ui.properties
kubectl describe configmaps game-config-2
# Name:         game-config-2
# Namespace:    default
# Labels:       <none>
# Annotations:  <none>

# Data
# ====
# game.properties:
# ----
# enemies=aliens
# lives=3
# enemies.cheat=true
# enemies.cheat.level=noGoodRotten
# secret.code.passphrase=UUDDLRLRBABAS
# secret.code.allowed=true
# secret.code.lives=30
# ui.properties:
# ----
# color.good=purple
# color.bad=yellow
# allow.textmode=true
# how.nice.to.look=fairlyNice


# 3 - Criar um ConfigMap a partir de um arquivo env, por exemplo:

# Env-files contain a list of environment variables.
# These syntax rules apply:
#   Each line in an env file has to be in VAR=VAL format.
#   Lines beginning with # (i.e. comments) are ignored.
#   Blank lines are ignored.
#   There is no special handling of quotation marks (i.e. they will be part of the ConfigMap value)).

# Download the sample files into `configure-pod-container/configmap/` directory
wget https://kubernetes.io/examples/configmap/game-env-file.properties -O configure-pod-container/configmap/game-env-file.properties

# The env-file `game-env-file.properties` looks like below
cat configure-pod-container/configmap/game-env-file.properties
# enemies=aliens
# lives=3
# allowed="true"

# This comment and the empty line above it are ignored

kubectl create configmap game-config-env-file \
       --from-env-file=configure-pod-container/configmap/game-env-file.properties
#configmap/game-config-env-file created
kubectl get configmap game-config-env-file -o yaml
# apiVersion: v1
# kind: ConfigMap
# metadata:
#   creationTimestamp: 2017-12-27T18:36:28Z
#   name: game-config-env-file
#   namespace: default
#   resourceVersion: "809965"
#   uid: d9d1ca5b-eb34-11e7-887b-42010a8002b8
# data:
#   allowed: '"true"'
#   enemies: aliens
#   lives: "3"

#Ao passar --from-env-file várias vezes para criar um ConfigMap a partir de várias fontes de dados, apenas o último arquivo env é usado.