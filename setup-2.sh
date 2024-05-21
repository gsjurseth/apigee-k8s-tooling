#!/bin/bash

gcloud iam service-accounts create preview-gsa

gcloud iam service-accounts add-iam-policy-binding \
preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com \
--role roles/iam.workloadIdentityUser \
--member "serviceAccount:${PROJECT_ID}.svc.id.goog[apigee/preview-ksa]"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
--member "serviceAccount:preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com" \
--role "roles/apigee.apiAdminV1"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
--member "serviceAccount:preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com" \
--role "roles/apigee.analyticsAgent"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
--member "serviceAccount:preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com" \
--role "roles/networkservices.serviceExtensionsAdmin"

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
--member "serviceAccount:preview-gsa@${PROJECT_ID}.iam.gserviceaccount.com" \
--role "roles/compute.networkAdmin"