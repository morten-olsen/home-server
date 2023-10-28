ENV=${1:-dev}
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

kind delete cluster
kind create cluster --config "$SCRIPT_DIR/../kind-config.yaml"
"$SCRIPT_DIR/update-secrets.sh"
helm install \
  --set env=$ENV \
  --set hostname=argocd.loopback.services \
  --wait argo-cd "$SCRIPT_DIR/../charts/core/argo-cd"
helm template "$SCRIPT_DIR/../apps" \
  --set env=$ENV \
  --set issuer=letsencrypt-prod \
  --set domain=loopback.services \
    | kubectl apply -f -
