run `./install.sh` on 2 separate machines or vms. One will be the data cluster backing up to aws the other will be the restore cluster which pulls to test the restore process.

on the data node 
```
./install.sh --data
```
on the recovery node, where 0001 is the an id used to increment each recovery, +1 from the last restore. Recovery means an entirely new cluster, whether on the same node or a different node. Standing up a new cluster with backing disks and cutting over ingress first before tearing down the old one.
```
./install.sh --recover 0001
```

a blank node, no data used for other things if needed
```
./install.sh
```
on both create a secret and give the serviceaccount access to aws-creds secret
```
kubectl create secret generic aws-creds -n db --from-literal=ACCESS_KEY_ID=yolo --from-literal=ACCESS_SECRET_KEY=yolo
```
helper commands
```
sudo kubectl get cluster -n db
sudo kubectl get backup -n db
sudo kubectl get scheduledbackup -n db
sudo kubectl cnpg status cluster-with-metrics -n db
sudo kubectl exec -i -n db cluster-with-metrics-1 -c postgres -- /bin/bash\n
sudo --preserve-env=PATH kubectl cnpg status cluster-with-metrics -n db
sudo k get secrets -n db
kubectl delete cluster cluster-with-metrics -n db

```
