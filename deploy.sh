docker build -t sachinathu/multi-client:latest sachinathu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sachinathu/multi-server:latest sachinathu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sachinathu/multi-worker:latest sachinathu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sachinathu/multi-client:latest
docker push sachinathu/multi-client:$SHA
docker push sachinathu/multi-server:latest
docker push sachinathu/multi-server:$SHA
docker push sachinathu/multi-worker:latest
docker push sachinathu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sachinathu/multi-client:$SHA
kubectl set image deployments/server-deployment server=sachinathu/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sachinathu/multi-worker:$SHA


