docker build -t sinhblue/multi-client:latest -t sinhblue/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sinhblue/multi-server:latest -t sinhblue/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sinhblue/multi-worker:latest -t sinhblue/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sinhblue/multi-client:latest
docker push sinhblue/multi-server:latest
docker push sinhblue/multi-worker:latest

docker push sinhblue/multi-client:$SHA
docker push sinhblue/multi-server:$SHA
docker push sinhblue/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sinhblue/multi-server:$SHA
kubectl set image deployments/client-deployment client=sinhblue/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sinhblue/multi-worker:$SHA
