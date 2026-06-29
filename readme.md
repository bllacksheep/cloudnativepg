```
sudo kubectl get cluster -n db
sudo kubectl get backup -n db
sudo kubectl get scheduledbackup -n db
sudo kubectl cnpg status cluster-with-metrics -n db
sudo kubectl exec -i -n db cluster-with-metrics-1 -c postgres -- /bin/bash\n
sudo --preserve-env=PATH kubectl cnpg status cluster-with-metrics -n db
sudo k get secrets -n db
```
```
kubectl create secret generic aws-creds -n db --from-literal=ACCESS_KEY_ID=yolo --from-literal=ACCESS_SECRET_KEY=yolo
```
cloudnativepg backup and restore quickstart
create cluster
give serviceaccount access to aws-creds secret
