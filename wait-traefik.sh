#! /bin/bash
set -e

kubectl proxy --port=8001 &

echo "Waiting kubectl proxy to be running...5 seconds"
sleep 5

function fetch_stats(){
  curl -s "http://localhost:8001/api/v1/namespaces/kube-system/pods?fieldSelector=status.phase%3DRunning&limit=500" | jq '.items[].metadata.name | select(. | contains("svclb-traefik"))'
}

echo "Waiting fetching current state for traefik deployment"
result=$(fetch_stats)

if [ "${result}" ]; then
  echo "$result"
  echo "Traefik is running - we can apply changes";
  exit 0
fi

while [ -z "${result}" ]
do
  echo "Waiting 10 seconds to fetch svclb-traefik stats. We can only apply k8s changes after Traefik is running"
  sleep 10
  result=$(fetch_stats);
done


echo "Finishing kubectl proxy"
pgrep kubectl proxy | xargs -n 1 kill -9

echo "Traefik is running - we can apply changes"
