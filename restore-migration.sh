#!/bin/bash

# Restore e migration:

helm repo add rancher-charts https://charts.rancher.io
helm repo update

helm install rancher-backup-crd rancher-charts/rancher-backup-crd -n cattle-resources-system --create-namespace 
helm install rancher-backup rancher-charts/rancher-backup -n cattle-resources-system 

# crie o secret com as credenciais do S3
kubectl create secret generic s3-creds -n cattle-resources-system --from-literal=accessKey=$ACCESS_KEY --from-literal=secretKey=$SECRET_KEY

# aplique o restore
kubectl apply -f restore.yaml -n cattle-resources-system