run:
	kustomize build apps > apps/build.yaml
	kustomize build . | kubectl apply -f -
