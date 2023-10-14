kind create cluster --name=management
docker build -t nginx_draft:latest .
docker tag nginx_draft thuong99/nginx_draft:latest
docker push thuong99/nginx_draft:latest


# Kube run
kubectl apply -f nginx.yaml
kubectl get pod
kubectl port-forward pod/nginx 8080:80

# delete kube
kubectl delete pod nginx
kubectl delete -f nginx.yaml


kubectl api-resources

# execute
kubectl exec -it pod/pod_name -c main-container -- sh
kubectl exec -it pod_name -- sh
netstat -tulpn | grep 80