#!/bin/bash
argocd app create genesis \
    --project genesis-avalon \
    --repo registry.0x42.in/genesis-avalon/helm \
    --helm-chart puppeteer \
    --revision 0.1.1 \
    --dest-server "https://kubernetes.default.svc" \
    --dest-namespace genesis-avalon-dev