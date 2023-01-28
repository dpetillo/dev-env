#set -x

env_name=$1

echo "destroying environment $1"

cd infra
terraform init
terraform workspace new $1 || true
terraform workspace select $1
terraform destroy
