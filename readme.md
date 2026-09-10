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
sudo kubectl cnpg status cluster-0001 -n db
sudo kubectl exec -i -n db cluster-0001-1 -c postgres -- /bin/bash\n
sudo --preserve-env=PATH kubectl cnpg status cluster-0001 -n db
sudo k get secrets -n db
kubectl delete cluster cluster-0001 -n db
```
testing cluster swap when changing backend storage class
```
kubectl port-forward svc/pooler-rw 5432:5432 -n db
kubectl get secret -n db cluster-0001-app -o yaml -o jsonpath='{.data.password}' |base64 -d
kubectl get secret -n db cluster-0002-app -o yaml -o jsonpath='{.data.password}' |base64 -d
psql -h 127.0.0.1 -p 5432 -U app
```
