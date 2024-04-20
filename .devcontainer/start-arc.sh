#!/bin/bash

until docker info;

do sleep 1;

done;

minikube start

helm install arc \
    --namespace "${CONTROLLER_NAMESPACE}" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

helm install "${RUNNER_INSTALLATION_NAME}" \
    --namespace "${RUNNER_NAMESPACE}" \
    --create-namespace \
    --set githubConfigUrl="${ARC_CONFIG_URL}" \
    --set githubConfigSecret.github_token="${FAST_ARC_TOKEN}" \
    --set maxRunners="2" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set
