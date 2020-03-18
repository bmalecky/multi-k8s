docker build -t bmaleckysandbox/multi-client:latest -t bmaleckysandbox/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bmaleckysandbox/multi-server:latest -t bmaleckysandbox/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bmlaeckysandbox/multi-worker:latest -t bmaleckysandbox/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bmaleckysandbox/multi-client:latest
docker push bmaleckysandbox/multi-server:latest
docker push bmaleckysandbox/multi-worker:latest

docker push bmaleckysandbox/multi-client:$SHA
docker push bmaleckysandbox/multi-server:$SHA
docker push bmaleckysandbox/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=bmaleckysandbox/multi-client:$SHA
kubectl set image deployments/server-deployment server=bmaleckysandbox/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bmaleckysandbox/multi-worker:$SHA
