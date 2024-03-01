#!/bin/bash
argocd app create genesis-avalon-ui-dev \
    --project genesis-avalon \
    --repo registry.0x42.in/genesis-avalon/helm \
    --helm-chart genesis-avalon-ui \
    --revision $(git describe --abbrev --tags) \
    --dest-server "https://kubernetes.default.svc" \
    --dest-namespace genesis-avalon-dev