SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

kind delete cluster
kind create cluster --config "$SCRIPT_DIR/../kind-config.yaml"
"$SCRIPT_DIR/update-secrets.sh"
helm install --wait argo-cd "$SCRIPT_DIR/../charts/argo-cd"
helm template "$SCRIPT_DIR/../root" | kubectl apply -f -
