#create secret for your database
kubectl create secret generic mysql-root-pass --from-literal=password=Abc123Abc123
kubectl create secret generic mysql-user-pass --from-literal=username=dbadmin --from-literal=password=Xyz123Xyz123
kubectl create secret generic mysql-db-url --from-literal=database=flaskproject01

#deploy mysql database latest version
kubectl apply -f mysql-nfs-dev.yaml --validate=false