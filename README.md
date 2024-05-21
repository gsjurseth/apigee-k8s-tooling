# apigee-k8s-tooling
This repo aims to make it easy to get up and running with a sample application with Apigee's kubernetes tooling.

## A cluster
You're going to need a cluster and we're going to be using workload identity. By far the easiest way to do this is to simply deploy an autopilot cluster like so:

```bash
gcloud container clusters create-auto k8s-tooling-test \
    --region=us-west1 
```
And then fetch the credentials
```bash
gcloud container clusters get-credentials k8s-tooling --region us-west1
    --region=us-west1 
```

