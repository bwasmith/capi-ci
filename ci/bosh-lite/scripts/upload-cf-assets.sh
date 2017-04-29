#!/bin/bash

set -eu

# INPUTS
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
workspace_dir="$( cd "${script_dir}/../../../../" && pwd )"
cf_deployment_repo="${workspace_dir}/cf-deployment"
env_info="${workspace_dir}/bosh-lite-env-info"

source "${env_info}/metadata"

echo "Uploading stemcell..."
stemcell_version=$(bosh interpolate --path /stemcells/alias=default/version "${cf_deployment_repo}/cf-deployment.yml")
bosh -n upload-stemcell \
  "https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent?v=${stemcell_version}"

echo "Uploading cloud-config..."
bosh -n update-cloud-config "${cf_deployment_repo}/bosh-lite/cloud-config.yml"

echo "Done."
