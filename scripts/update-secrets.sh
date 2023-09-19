SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

CMD="helm template $SCRIPT_DIR/../charts/secrets"
CMD=$CMD' --set github.username=$GITHUB_USERNAME'
CMD=$CMD' --set github.pat=$GITHUB_PAT'
CMD=$CMD' --set cloudflare.token=$CLOUDFLARE_API_TOKEN'
op run --env-file "$SCRIPT_DIR/../charts/secrets/env.op" -- bash -c "$CMD | kubectl apply -f -"
