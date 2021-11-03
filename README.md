## Fractional Test Task

## Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [helm3](https://helm.sh/docs/intro/install/)
- AWS credentials ( ACCESS_ID and SECRET_KEY ) for EKS access

## Overview
Containerization of node application
Orchestration( Deployent in Kubernetes cluster)
Github workflow for CI/CD

### Dockerfile
Some of the security practices I have followed:

- I have used base image SHA as a peice of evidence.

- I have use mutli stage DockerFile, In base stage it install production dependencies in seperate folder which in used the in the next stage(avoided dev dependencies).

- Used User `node` which is available in the  base image.

- Removed package manager from the image.

- Used to run the server with `dumb-init`.

### Kubernetes Manifest

Kubernets service is available in `k8s` directory.

### Deploy Mongo cluster

```sh
      kubectl create ns mongo
      helm repo add bitnami https://charts.bitnami.com/bitnami
      helm upgrade --install mongo bitnami/mongodb --version 9.3.1 -f k8s/mongo/values.yaml -n mongo --wait
```
Run deploy.yml pipiline 

Things I have added in manifets of `todo-app`.

- Used Resource request and limits.
- Used readiness and liveness Probe.
- Used SecurityContext of readonly.
- Created service for accessing the service inside the cluster.
- Deployed Horizontal Pod Autoscaler which will spawn new pod if average load increases of all the pods.

<br>

### Deploy Ingress

`Note`: Replace DNS_TO_REPLACE with DNS Domain and INGRESS_CLASS_TO_REPLACE with ingress controller Class.
<br>
For Deploying [Ingress-controller](https://www.nginx.com/blog/deploying-nginx-ingress-controller-on-amazon-eks-how-we-tested/)
```sh
      kubectl apply -f k8s/todo-app/todo-app-ingress.yaml
```

To access the todo-app locally :

```sh
      kubectl port-forward svc/todo-app 8081:8080
```

Open http://localhost:8081/

### CI/CD

Created Github Workflow which contain a common job for,

- Building the image
- Push the image to ECR
- Deploy the application with the new image.
- Rollout all pods.

### Future Improvements

- Configure the mongo cluster to use TLS only.
- User seperate user  and database for each service(todo-app) in mongo cluster.
- Can use hashicorp vault for dynamic secret generation.

