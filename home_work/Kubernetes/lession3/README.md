kubectl apply -f DaemonSet.yaml
kubectl label nodes management-control-plane disk=ssd
kubectl delete -f DaemonSet.yaml


----
k apply -f StatefulSet.yaml
k get pod
k delete pod name-stateful-set-0
k delete -f StatefulSet.yaml


---

k apply -f node_service.yaml
---


6,8, SERVICE IP CLUSTER, SERVICE NODE PORT, JOB