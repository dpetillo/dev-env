#set -x

env_name=$1

echo "creating environment $1"

cd infra
terraform init
terraform workspace new $1 || true
terraform workspace select $1

terraform apply -auto-approve -var-file "config/$1.tfvars"

cd ..

kubectl config use-context "minikube-$1"
minikube profile "minikube-$1"

kubectl apply -f ./kube

echo ""
echo "environment build complete"
echo "minikube ip: $(minikube ip)"