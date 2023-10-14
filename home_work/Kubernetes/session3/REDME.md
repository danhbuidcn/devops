kubectl get ns # get all namespace
kubectl create ns testing-lession3 # create namespace
kubectl apply -f lession3_nginx.yaml # create pod for namespace testing
kubectl delete pod nginx -n testing-lession3 # delete pod in namespace
kubectl delete ns testing-lession3 # delete namespace