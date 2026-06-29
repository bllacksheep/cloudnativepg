run `./install.sh` on 2 separate machines or vms. One will be the data cluster backing up to aws the other will be the restore cluster which pulls to test the restore process.

on the data node 
```
./install.sh --data
```

on the restore node
```
./install.sh
```

on both create a secret and give the serviceaccount access to aws-creds secret
```
kubectl create secret generic aws-creds -n db --from-literal=ACCESS_KEY_ID=yolo --from-literal=ACCESS_SECRET_KEY=yolo
```

### restoring to a different cluster
### restoring to the same cluster


helper commands
```
sudo kubectl get cluster -n db
sudo kubectl get backup -n db
sudo kubectl get scheduledbackup -n db
sudo kubectl cnpg status cluster-with-metrics -n db
sudo kubectl exec -i -n db cluster-with-metrics-1 -c postgres -- /bin/bash\n
sudo --preserve-env=PATH kubectl cnpg status cluster-with-metrics -n db
sudo k get secrets -n db
```
