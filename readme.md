 k create ns db
 k get po -n db
 k get cluster -n db
 k get clusters -n db
 kubectl get clusters -n db
 kubectl cnpg status cluster-with-metrics -n db
 kubectl exec -i -n db cluster-with-metrics-1 -c postgres -- /bin/bash\n
 kubectl cnpg psql cluster-with-metrics -n db
 k get secrets -n db

```
kubectl create secret generic aws-creds -n db --from-literal=ACCESS_KEY_ID=yolo --from-literal=ACCESS_SECRET_KEY=yolo
```
cloudnativepg backup and restore quickstart
create cluster
give serviceaccount access to aws-creds secret
