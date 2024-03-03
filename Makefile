run:
	sh wait-traefik.sh
	kustomize build apps > apps/build.yaml
	kustomize build . | kubectl apply -f -

cluster:
	k3d cluster create --api-port 6550 -p "8081:80@loadbalancer" --agents 1
