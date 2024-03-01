#!/bin/bash
component=$1
action=$2

cd $1

case $action in
    clean)
        rm -rf dist
        ;;
    release)
        ver=$(cat Chart.yaml | yq .version)
        helm package . -d dist
        helm push dist/${component}-${ver}.tgz oci://registry.0x42.in/genesis-avalon/helm
        ;;
    *)
        echo "Unknown action"
        ;;
esac
