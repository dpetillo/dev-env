#set -x

env_name=$1

echo "destroying environment $1"

pushd "infra/live/$1/compute"

terragrunt destroy