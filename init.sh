cd terraform/cluster
terraform apply -auto-approve
cd  ../namespace
terraform workspace select prod
terraform apply -auto-approve
terraform workspace select dev
terraform apply -auto-approve
terraform workspace select qa
terraform apply -auto-approve
cd  ../monitoring
terraform apply -auto-approve
cd  ../neo4j
terraform workspace select prod
terraform apply -auto-approve
terraform workspace select dev
terraform apply -auto-approve
cd  ../rabbitmq-operator
terraform apply -auto-approve
cd  ../ingress-nginx
terraform apply -auto-approve

cd ../../kubernetes
kubectl apply -k prod
kubectl apply -k dev
kubectl apply -k qa
