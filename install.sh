#!/bin/bash

#Adicionar GKE
gcloud container clusters get-credentials argo-dev-0 --region us-central1 --project develop-464014


# Criar namespaces
kubectl create namespace ingress-nginx || true
kubectl create namespace cattle-system || true


# Install Nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install \
  ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.service.type=LoadBalancer \
  --version 4.0.18 \
  --create-namespace


## Com tls manual - sem cert-manager

# Criar secret tls
kubectl create secret tls -n cattle-system konzelmann-wild-tls --cert=/home/adenilson/devopsLab/lab-tls/cert/live/konzelmann.com.br/fullchain.pem --key=/home/adenilson/devopsLab/lab-tls/cert/live/konzelmann.com.br/privkey.pem

helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.konzelmann.com.br \
  --set bootstrapPassword=admin \
  --set ingress.tls.source=konzelmann-wild-tls

# # Install with cert-manager
# # Add the Jetstack Helm repository
# helm repo add jetstack https://charts.jetstack.io

# # Update your local Helm chart repository cache
# helm repo update

# # Create the cert-manager namespace if it doesn't exist
# kubectl create namespace cert-manager || true

# # Install the cert-manager Helm chart
# helm install cert-manager jetstack/cert-manager \
#   --namespace cert-manager \
#   --create-namespace \
#   --set crds.enabled=true

# # Install Rancher stable version usin helm
# helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
# kubectl create namespace cattle-system || true

# helm install rancher rancher-stable/rancher \
#   --namespace cattle-system \
#   --set hostname=rancher.konzelmann.com.br \
#   --set bootstrapPassword=admin

# Pegar bootstrap password
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{ "\n" }}'

