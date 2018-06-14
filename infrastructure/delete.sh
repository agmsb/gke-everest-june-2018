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

printf "\n Validating GCP Project"

gcloud config set project $PROJECT_ID

printf "\n Deleting GKE Cluster $CLUSTER_NAME \n"

cat << EOM

Currently running:

gcloud container clusters delete $CLUSTER_NAME --region=$REGION

EOM

gcloud container clusters delete $CLUSTER_NAME --region=$REGION

printf "\n Deleting Cluster Subnet $SUBNET_NAME \n"

cat << EOM

Currently running:

gcloud container networks subnets delete $SUBNET_NAME --region=$REGION

EOM

gcloud container networks subnets delete $SUBNET_NAME --region=$REGION

printf "\n Deleting VPC $VPC_NAME \n"

cat << EOM

Currently running:

gcloud container networks delete $VPC_NAME

EOM

printf "\n We should be all done here. Thanks for trying this demo out! \n"


