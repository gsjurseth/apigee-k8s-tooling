#!/bin/bash

kubectl create namespace apigee

helm install apigee-k8s-controller \
oci://us-docker.pkg.dev/apigee-release/apigee-k8s-tooling-helm-charts/apigee-k8s-controller-milestone1-public-preview \
--version 1.3 --set project_id=${PROJECT_ID}


echo now run the following and verify the service account is setup. Once done run setup-2.sh
echo kubectl describe serviceaccounts preview-ksa -n apigee


