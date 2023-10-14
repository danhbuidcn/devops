kubectl apply -f nginx_draft.yaml
kubectl get pod --show-labels
kubectl get pod -L environment
kubectl get pod -l environment=production
curl localhost:80

# expose port
kubectl get pod
kubectl port-forward nginx-production 8080:80

# delete resource
kubectl delete -f nginx_draft.yaml