docker build -t service:1.0.3 .
docker tag service:1.0.3 gcr.io/$PROJECT_ID/service:1.0.3
docker push gcr.io/$PROJECT_ID/service:1.0.3
