SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

kind delete cluster
kind create cluster --config "$SCRIPT_DIR/../kind-config.yaml"
"$SCRIPT_DIR/update-secrets.sh"
helm install --wait argo-cd "$SCRIPT_DIR/../charts/core/argo-cd"
helm template "$SCRIPT_DIR/../apps" --set domain=foo.loopback.services | kubectl apply -f -
