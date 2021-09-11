docker build -t joshnavru/multi-client:latest -t joshnavru/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t joshnavru/multi-server:latest -t joshnavru/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t joshnavru/multi-worker:latest -t joshnavru/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push joshnavru/multi-client:latest
docker push joshnavru/multi-server:latest
docker push joshnavru/multi-worker:latest

docker push joshnavru/multi-client:$SHA
docker push joshnavru/multi-server:$SHA
docker push joshnavru/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=joshnavru/multi-client:$SHA
kubectl set image deployments/server-deployment server=joshnavru/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=joshnavru/multi-worker:$SHA