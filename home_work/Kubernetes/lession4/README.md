kubectl apply -f lession4.yaml # assignee pod for namespace
kubectl get pod -o wide
k net deployment
kubectl get service --all-namespaces
kubectl exec -it pod/pod_name -c main-container -- sh
wget 10.96.175.191:port # ip nodeport

# node port (mở trên tất cả các container) + node ip : thì có thể gọi đến từ tất cả các container

kubectl delete -f lession4.yaml

# kubeadm