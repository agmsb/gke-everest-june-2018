# Copyright 2018, Google, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#!/bin/bash

source ../infrastructure/options.sh

printf "\n Validate GCP Project \n"

gcloud config set project $PROJECT_ID

printf "\n Get credentials for GKE Cluster $CLUSTER_NAME \n"

cat << EOM

Currently running:

gcloud container clusters get-credentials $CLUSTER_NAME

EOM

gcloud container clusters get-credentials $CLUSTER_NAME

sleep 2

printf "\n The good stuff now. Good ol' kubectl. Verify it works."

cat << EOM

Currently running:

kubectl cluster-info

EOM

kubectl cluster-info

sleep 2

printf "\n Grant yourself permission to manage roles"

cat << EOM

Currently running:

kubectl create clusterrolebinding cluster-admin-binding
   --clusterrole cluster-admin --user $PRIMARY_ACCOUNT

EOM

kubectl create clusterrolebinding cluster-admin-binding \
   --clusterrole cluster-admin --user $PRIMARY_ACCOUNT

sleep 2

printf "\n Create an IAM service account for the user “gke-pod-reader”, which
we will allow to read pods \n"

cat << EOM

Currently running:

gcloud iam service-accounts create gke-pod-reader
    --display-name "GKE Pod Reader"
    USER_EMAIL=gke-pod-reader@$PROJECT_ID.iam.gserviceaccount.com

EOM

gcloud iam service-accounts create gke-pod-reader \
    --display-name "GKE Pod Reader" \
    USER_EMAIL=gke-pod-reader@$PROJECT_ID.iam.gserviceaccount.com

sleep 2

printf "\n Look at the Pod-Reader ClusterRole \n"

cat clusterrole/pod-reader-clusterrole.yaml

sleep 10

printf "\n Create the Pod-Reader ClusterRole \n"

cat << EOM

Currently running:

kubectl apply -f clusterrole/pod-reader-clusterrole.yaml

EOM

kubectl apply -f clusterrole/pod-reader-clusterrole.yaml

printf "\n Look at the Pod-Reader ClusterRoleBinding for $USER_EMAIL"

cat clusterrolebinding/pod-reader-clusterrolebinding.yaml

sleep 10

printf "\n Create the Pod-Reader ClusterRoleBinding for $USER_EMAIL"

cat << EOM

Currently running:

kubectl apply -f clusterrolebinding/pod-reader-clusterrolebinding.yaml

EOM

kubectl apply -f clusterrolebinding/pod-reader-clusterrolebinding.yaml

printf "\n Checking the permissions of the Pod-Reader"

gcloud iam service-accounts keys create \
   --iam-account $USER_EMAIL pod-reader-key.json

gcloud container clusters get-credentials $CLUSTER_NAME

gcloud auth activate-service-account $USER_EMAIL \
   --key-file=pod-reader-key.json

sleep 10

printf "\n Watch the Pod-Reader get/list all pods in the cluster \n"

cat << EOM

Currently running:

kubectl get pods --all-namespaces

EOM

kubectl get pods --all-namespaces

sleep 2

printf "\n Watch the Pod-Reader have their deployment denied"

cat << EOM

Currently running:

kubectl run failed-deployment --image=nginx --replicas=1

EOM

kubectl run failed-deployment --image=nginx --replicas=1

sleep 1

printf "\n Resetting gcloud and kubectl to your main user account."

gcloud config set account $PRIMARY_ACCOUNT
gcloud container clusters get-credentials $CLUSTER









