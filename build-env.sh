#set -x

env_name=$1

echo "creating environment $1"

pushd "infra/live/$1/compute"

terragrunt apply -auto-approve

popd

kubectl config use-context "minikube-$1"
minikube profile "minikube-$1"

kubectl apply -f ./kube

echo ""
echo "environment build complete"
#echo "minikube ip: $(minikube ip)"