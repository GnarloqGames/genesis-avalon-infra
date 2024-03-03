#!/bin/bash
argocd app create genesis \
    --project genesis-avalon \
    --repo git@github.com:GnarloqGames/genesis-avalon-infra.git \
    --path helm/puppeteer \
    --revision main \
    --dest-server "https://kubernetes.default.svc" \
    --dest-namespace genesis-avalon-dev