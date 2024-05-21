docker build -t service:1.0.4 .
docker tag service:1.0.4 gcr.io/$PROJECT_ID/service:1.0.4
docker push gcr.io/$PROJECT_ID/service:1.0.4
