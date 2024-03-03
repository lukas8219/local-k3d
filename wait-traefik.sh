#! /bin/bash
function fetch_stats(){
  $(curl "http://localhost:8001/api/v1/namespaces/kube-system/pods?fieldSelector=status.phase%3DCompleted&limit=500" | jq '.items[].metadata.name | select(. | contains("svclb-traefik"))')
}


result=fetch_stats

if [ "${result}" ]; then
  echo "Traefik is running - we can apply changes";
  exit 0
fi

while [ -z "${result}" ]
do
  echo "Waiting 10 seconds to fetch svclb-traefik stats. We can only apply k8s changes after Traefik is running"
  sleep 10
  result=fetch_stats;
done

echo "Traefik is running - we can apply changes"
