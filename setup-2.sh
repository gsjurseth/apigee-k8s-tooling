#!/bin/bash

echo "Adding iam policy binding for workloadIdentity" >&2
gcloud iam service-accounts add-iam-policy-binding \
preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com \
--role roles/iam.workloadIdentityUser \
--member "serviceAccount:${PROJECT_ID}.svc.id.goog[apigee/preview-ksa]"

if [ $? -eq 0 ]
then
    echo "Adding policy binding for Apigee admin role" >&2
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/apigee.apiAdminV1"
else
    echo "Failed creating policy binding for workload identity" >&2
    exit 1
fi

if [ $? -eq 0 ]
then
    echo "Adding policy binding for Apigee admin role" >&2
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/apigee.analyticsAgent"
else
    echo "Failed adding policy binding for Apigee Admin Role" >&2
    exit 1
fi

if [ $? -eq 0 ]
then
    echo "Adding policy binding for service extension creation" >&2
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/networkservices.serviceExtensionsAdmin"
else
    echo "Failed adding policy binding for Apigee Analytics agent" >&2
    exit 1
fi

if [ $? -eq 0 ]
then
    echo "Adding policy binding for network plumbing" >&2
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member "serviceAccount:preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com" \
    --role "roles/compute.networkAdmin"
else
    echo "Failed adding policy binding for service extension creation" >&2
    exit 1
fi

if [ $? -ne 0 ]
then
    echo "Failed creating policy binding for network plumbing" >&2
fi
