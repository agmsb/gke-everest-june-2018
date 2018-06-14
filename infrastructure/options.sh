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

# Set GCP Project
PROJECT_ID=$(gcloud config list project --format=flattened | awk 'FNR == 1 {print $2}')

# Set GCP Region
REGION=us-west1

# Set VPC
VPC_NAME=example-vpc
SUBNET_NAME=example-vpc-k8s-cluster

# Set GKE
CLUSTER_NAME=example-gke-cluster
CLUSTER_VERSION=$(gcloud beta container get-server-config --region us-west1 --format='value(validMasterVersions[0])')
MACHINE_TYPE=n1-standard-1

