ENV=${ENV:-dev}
CERT=${CERT:-stage}
DOMAIN=${DOMAIN:-loopback.services}
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dependency build "$SCRIPT_DIR/../charts/core/argo-cd"

kind delete cluster
kind create cluster --config "$SCRIPT_DIR/../kind-config.yaml"
"$SCRIPT_DIR/update-secrets.sh"
helm install \
  --set env=$ENV \
  --set domain=$DOMAIN \
  --set issuer=letsencrypt-$CERT \
  --wait argo-cd "$SCRIPT_DIR/../charts/core/argo-cd"
helm template "$SCRIPT_DIR/../apps" \
  --set env=$ENV \
  --set issuer=letsencrypt-$CERT \
  --set domain=$DOMAIN \
    | kubectl apply -f -
