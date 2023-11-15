kubectl get event -A -o json | jq '.items[] | select(.reason == "Pulled")|.message' | grep -v "already present on machine" | sort -u
