# Home server

My home server setup - Kubernetes, Ingress, Let's Encrypt and GitOps

## Variables

* `root/values.yaml`
* `charts/secrets/env.op`

## Run

```
nix develop --impure
./scripts/recreate.sh
```

## Update

Make changes and push to git - argo should auto deploy the changes
