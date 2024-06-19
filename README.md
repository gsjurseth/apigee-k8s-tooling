# apigee-k8s-tooling
This repo aims to make it easy to get up and running with a sample application with Apigee's kubernetes tooling.

## Initial setup: cluster and services
To make this simple I've added two scripts. This does *most* of what's required, but makes some assumptions. Firstly, it does all work in us-west1 and makes a clsuter called: `k8s-tooling`. Secondly, it assumes that you will be relying on the default subnet.

To that end, in addition to all other work you'll need to add a proxy subnet to your default vpc.

Then you sipmly

```bash
./setup-1.sh
```

When that completes run the insalltion of the envoy-adapter remote service. You only need the remote-service cli. Generate the `config.yaml` and apply it to your GKE cluster created during the first part.

Next run:

```bash
./setup-2.sh
```

At this point you should be setup. What's left is to build and deploy the service for foo and bar respectively. If you've got $PROJECT_ID set you should be able to just

```bash
cd src
./buildit.sh
```
That will build the service. Now you can create a gateway by:

```bash
kubectl apply -f gateway.yaml
```

Wait for that to complete, and once done you can go into foo and bar respectively and execute (again assuming that you have $PROJECT_ID set):

```bash
cat service.yaml | sed -i -e "s/\$PROJECT_ID/$PROJECT_ID/" | kubectl apply -f -
kubectl apply -f route.yaml
```

## Applying some apigee bits
For the `apigee-adapter` to work we need to work we'll need to update `apigee-adapter-service`
in the apigee-adapter directory with the org and environment that's relevant for your use case. It will the be same org/env combination you used when setting up the envoy-adapter remove service.

Get that updated and then you can `kubectl apply` that whole directory.

## Running a demo
Now copy the gateway ip that you got when your gateway config completed:

```bash
kubectl get gateway
```

Now run a curl pod by:

```bash
kubectl run -it --image=curlimages/curl curl -- sh
```

From here you should be able to:

```bash
curl -H "host: k8s-demo.apigeeks.net" http://<gateway_ip>/foo
```

You should see some output. So far no apigee here.

Now lets add an apim extension:

```bash
cd foo-service
kubectal apply -f 1-apimextension.yaml
```

Now when we execute our curl command like so:

```bash
curl -H "host: k8s-demo.apigeeks.net" http://<gateway_ip>/foo
```

We get 401 errors...

Now add the procuct and product operation yamls for foo. Create a developer and app in the UI, grab the key and execute your curl again like so:

```bash
curl -H "host: k8s-demo.apigeeks.net" http://<gateway_ip>/foo -H "x-api-key: <your_key>"
```

Now it should work again, but with additional headers. Furthermore, the quota should work as well.


