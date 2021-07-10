docker build -t hoanlezuhlke/multi-d1-client:latest -t hoanlezuhlke/multi-d1-client:$SHA -f ./client/Dockerfile ./client
docker build -t hoanlezuhlke/multi-d1-server:latest -t hoanlezuhlke/multi-d1-server:$SHA -f ./server/Dockerfile ./server
docker build -t hoanlezuhlke/multi-d1-worker:latest -t hoanlezuhlke/multi-d1-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hoanlezuhlke/multi-d1-client:latest
docker push hoanlezuhlke/multi-d1-client:$SHA

docker push hoanlezuhlke/multi-d1-server:latest
docker push hoanlezuhlke/multi-d1-server:$SHA

docker push hoanlezuhlke/multi-d1-worker:latest
docker push hoanlezuhlke/multi-d1-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=hoanlezuhlke/multi-d1-server:$SHA
kubectl set image deployments/client-deployment server=hoanlezuhlke/multi-d1-client:$SHA
kubectl set image deployments/worker-deployment server=hoanlezuhlke/multi-d1-worker:$SHA
