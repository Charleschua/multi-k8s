docker build -t charles19/multi-client:latest -t charles19/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t charles19/multi-server:latest -t charles19/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t charles19/multi-worker:latest -t charles19/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push charles19/multi-client:latest
docker push charles19/multi-server:latest
docker push charles19/multi-worker:latest

docker push charles19/multi-client:$SHA
docker push charles19/multi-server:$SHA
docker push charles19/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=charles19/multi-server:$SHA
kubectl set image deployments/client-deployment client=charles19/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=charles19/multi-worker:$SHA