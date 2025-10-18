#!/bin/bash

# Contêm os comandos para instalação do Rancher em um cluster Kubernetes usando Helm.
#Não aplique como um script, execute linha a linha para melhor entendimento.

# Criar namespaces caso não existam
kubectl create namespace ingress-nginx || true
kubectl create namespace cattle-system || true


# Install Nginx caso não exista
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install \
  ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.service.type=LoadBalancer \
  --version 4.0.18 \
  --create-namespace


# Criar secret tls para DNS do Rancher
kubectl create secret tls -n cattle-system konzelmann-wild-tls --cert=/home/adenilson/devopsLab/lab-tls/cert/live/konzelmann.com.br/fullchain.pem --key=/home/adenilson/devopsLab/lab-tls/cert/live/konzelmann.com.br/privkey.pem

# Criar secret CA - usada para comunicação entre Upstream e Downstream
kubectl -n cattle-system create secret generic tls-ca --from-file=/home/adenilson/devopsLab/lab-tls/cert/live/konzelmann.com.br/cacerts.pem


### Install Rancher own CA certs
### Follow command allow to you create a rancher deploy with own CA certs.
helm upgrade --install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.konzelmann.com.br \
  --set bootstrapPassword=admin \
  --set ingress.tls.source=secret \
  --set ingress.ingressClassName=nginx \
  --set ingress.tls.secretName=konzelmann-wild-tls \
  --set privateCA=true

# Pegar bootstrap password
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{ "\n" }}'


