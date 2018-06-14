# Google Kubernetes Engine for Everest June 2018

This is an accompanying repository for the GKE Everest Session in June 2018.

This is not an official Google product or tutorial.

## Requirements

1. GCP Project
2. gcloud SDK ([Google Cloud Shell](https://cloud.google.com/shell/) is a free x64 Linux env with this isntalled.)
3. GCP Billing Account
4. Basic Kubernetes and GCP Knowledge

See [here](https://cloud.google.com/pricing/list) for pricing on relevant technologies (GKE, Storage, Networking).

## Creating a GKE Cluster

[This](/infrastructure/gke.sh) script will use gcloud to create a GKE cluster with several of the GCP and GKE constructs discussed during the session. 

Clone the repo and make the scripts executable.

```
git clone https://github.com/agmsb/gke-everest-june-2018 && chmod +x create.sh && chmod +x delete.sh
```

Populate parameters in [options.sh](/infrastructure/options.sh) if need be and then execute create.sh.

## Cleanup

Execute [delete.sh](/infrastructure/delete.sh) to clean up anything you created with [create.sh](/infrastructure/create.sh).

## Demos

### Global Ingress with HTTP/S Load Balancer & Kubemci

[This](https://cloud.google.com/kubernetes-engine/docs/how-to/multi-cluster-ingress) tutorial will walk you through configuring a Global Ingress using Google's HTTP/S Load Balancer in front of multiple GKE clusters in different regions. Kubemci will be the tool to perform the configuration.

### Limiting Connections with Network Policy 

[This](https://cloud.google.com/kubernetes-engine/docs/tutorials/network-policy) tutorial will walk you through restricting incoming traffic to Pods and restricting outgoing traffic from Pods using Network Policy on GKE.

### High Availability for Stateful Workloads with Regional Persistent Disks

[This](https://cloud.google.com/solutions/using-kubernetes-engine-to-deploy-apps-with-regional-persistent-disks) solution will walk you through creating a Wordpress Blog backed by MariaDB on Regional Persistent Disks. It will simulate zone failure to demonstrate the regional HA provided by GKE and Regional PDs.


### Setting up Clusters with Shared VPC
[This](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc#pinging_between_nodes) tutorial will show you how to set up two GKE clusters in the same shared VPC.

## Additional Resources

1. [Exploring Container Security: Isolation at different layers of the Kubernetes stack](https://cloudplatform.googleblog.com/2018/05/Exploring-container-security-Isolation-at-different-layers-of-the-Kubernetes-stack.html)

2. [Exploring Container Security: Running a Tight Ship with GKE 1.10](https://cloudplatform.googleblog.com/2018/04/Exploring-container-security-Running-a-tight-ship-with-Kubernetes-Engine-1-10.html)

3. [Preparing a Kubernetes Engine Environment for Production](https://cloud.google.com/solutions/prep-kubernetes-engine-for-prod)
