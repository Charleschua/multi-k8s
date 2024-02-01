docker build -t charles19/multi-client-k8s:latest -t charles19/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t charles19/multi-server-k8s:latest -t charles19/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t charles19/multi-worker-k8s:latest -t charles19/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push charles19/multi-client-k8s:latest
docker push charles19/multi-server-k8s:latest
docker push charles19/multi-worker-k8s:latest

docker push charles19/multi-client-k8s:$SHA
docker push charles19/multi-server-k8s:$SHA
docker push charles19/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=charles19/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=charles19/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=charles19/multi-worker-k8s:$SHA