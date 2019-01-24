docker build -t ryanbozarth/multi-client:latest -t ryanbozarth/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ryanbozarth/multi-server:latest -t ryanbozarth/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ryanbozarth/multi-worker:latest -t ryanbozarth/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ryanbozarth/multi-client:latest
docker push ryanbozarth/multi-server:latest
docker push ryanbozarth/multi-worker:latest

docker push ryanbozarth/multi-client:$SHA
docker push ryanbozarth/multi-server:$SHA
docker push ryanbozarth/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ryanbozarth/multi-server:$SHA
kubectl set image deployments/client-deployment client=ryanbozarth/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ryanbozarth/multi-worker:$SHA