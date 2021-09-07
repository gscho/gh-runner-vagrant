#!/bin/bash

function fatal()
{
   echo "error: $1" >&2
   exit 1
}

base_api_url="https://api.github.com"
if [ -n "${GHE_HOSTNAME}" ]; then
    base_api_url="https://${ghe_hostname}/api/v3"
fi

# if the scope has a slash, it's a repo runner
orgs_or_repos="orgs"
if [[ "$SCOPE" == *\/* ]]; then
    orgs_or_repos="repos"
fi

export RUNNER_TOKEN=$(curl -s -X POST ${base_api_url}/${orgs_or_repos}/${SCOPE}/actions/runners/remove-token -H "accept: application/vnd.github.everest-preview+json" -H "authorization: token ${RUNNER_CFG_PAT}" | jq -r '.token')

if [ "null" == "$RUNNER_TOKEN" -o -z "$RUNNER_TOKEN" ]; then fatal "Failed to get a token"; fi

cd ./runner
sudo ./svc.sh uninstall
./config.sh remove --token $RUNNER_TOKEN