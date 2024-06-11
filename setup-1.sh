#!/bin/bash

if [ -z $PROJECT_ID ]
then
    echo "You must set PROJECT_ID before executing" >&2
    exit 1
fi

gcloud services enable container.googleapis.com
gcloud services enable networkservices.googleapis.com

if [ $? -eq 0 ]
then
    echo "Now waiting for 60 seconds before continuing"
    sleep 60
else
    echo "Failed enabling gke..." >&2
    exit 1
fi


if [ $? -eq 0 ]
then
    echo "creating autopilot cluster"
    gcloud container clusters create-auto k8s-tooling --region us-west1
else
    echo "Failed creating gke autopilot cluster..." >&2
    exit 1
fi


if [ $? -eq 0 ]
then
    echo "fetching credentials for autopilot cluster"
    gcloud container clusters get-credentials k8s-tooling --region us-west1
else
    echo "Failed fetching credentials for autopilot cluster..." >&2
    exit 1
fi

if [ $? -eq 0 ]
then
    echo "creating namespace apigee in our cluster"
    kubectl create namespace apigee
else
    echo "Failed creating namespace `apigee` in cluster..." >&2
    exit 1
fi

if [ $? -eq 0 ]
then
    echo "Installing controller"
    helm install apigee-k8s-controller \
    oci://us-docker.pkg.dev/apigee-release/apigee-k8s-tooling-helm-charts/apigee-k8s-controller-milestone1-public-preview \
    --version 1.3 --set project_id=${PROJECT_ID}
else
    echo "Failed to `helm install` apigee controller..." >&2
    exit 1
fi


echo now run the following and verify the service account is setup
echo kubectl describe serviceaccounts preview-ksa -n apigee

echo "Once that's done go ahead and complete the installation of the remote service before executing setup-2.sh"
