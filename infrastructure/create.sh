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

source ./options.sh

printf "\n Welcome to the GKE Everest Demo!"

printf "\n Creating Google VPC \n"

sleep 3

cat << EOM

Currently Running:

gcloud compute networks create $VPC_NAME
    --project=$PROJECT_ID
    --subnet-mode=custom

EOM

gcloud compute networks create $VPC_NAME \
    --project=$PROJECT_ID \
    --subnet-mode=custom

printf "\n Creating Cluster Subnet with Pod and Service Secondary Ranges \n"

sleep 3

cat << EOM

Currently Running:

gcloud compute networks subnets create $SUBNET_NAME
    --project=$PROJECT_ID
    --region=$REGION
    --network=$VPC_NAME
    --range=10.4.0.0/22
    --secondary-range=pod-net=10.0.0.0/14,svc-net=10.4.4.0/22

EOM

gcloud compute networks subnets create $SUBNET_NAME \
    --project=$PROJECT_ID \
    --region=$REGION \
    --network=$VPC_NAME \
    --range=10.4.0.0/22 \
    --secondary-range=pod-net=10.0.0.0/14,svc-net=10.4.4.0/22

printf "\n Creating GKE Cluster in $REGION \n"

sleep 3

cat << EOM

Currently Running:

gcloud container clusters create $CLUSTER_NAME
    --project=$PROJECT_ID
    --cluster-version=$CLUSTER_VERSION
    --network=$VPC_NAME
    --subnet=$SUBNET_NAME
    --cluster-secondary-range-name=pod-net
    --services-secondary-range-name=svc-net
    --region=$REGION
    --num-nodes=1
    --machine-type=$MACHINE_TYPE
    --enable-network-policy
    --enable-cluster-autoscaling
    --min-nodes=1
    --max-nodes=3
    --enable-autorepair
    --enable-autoupgrade

This will create a GKE Cluster with the following properties:
    Regional Cluster that spans 3 zones in the region $REGION. 
    The Kubernetes Control Plane will be replicated across 3 zones.
    IP Aliases are enabled.
    Cluster Autoscaling is enabled.
    Nodes are $MACHINE_TYPE.
    Network Policy is enabled.
    Node Auto Repair is enabled.
    Node Auto Upgrade is enabled.
    
EOM

gcloud container clusters create $CLUSTER_NAME \
    --project=$PROJECT_ID \
    --cluster-version=$CLUSTER_VERSION \
    --enable-ip-alias \
    --network=$VPC_NAME \
    --subnetwork=$SUBNET_NAME \
    --cluster-secondary-range-name=pod-net \
    --services-secondary-range-name=svc-net \
    --region=$REGION \
    --num-nodes=1 \
    --machine-type=$MACHINE_TYPE \
    --enable-network-policy \
    --enable-autoscaling \
    --min-nodes=1 \
    --max-nodes=3 \
    --enable-autorepair \
    --enable-autoupgrade 

printf "\n We should be done here. See the README to test out some stuff on your brand new cluster. TTFN \n"






