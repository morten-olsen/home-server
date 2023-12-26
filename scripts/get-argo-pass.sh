kubectl --namespace="system" get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | wl-copy
