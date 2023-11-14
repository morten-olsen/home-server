SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

kind delete cluster
kind create cluster --config "$SCRIPT_DIR/../kind-config.yaml"
