# local-k3d
Local K8s Environment using K3d

# How to configure access?

in `grafana.yaml` change the configMap `password` and `user` to your choice

# Using make
run `make` in bash and you are good

# How to run maually
1. You need to build the kustomize from `apps` folder
2. Then build the kustomize from root and apply it
```bash
k3d cluster create --api-port 6550 -p "8081:80@loadbalancer" --agents 1;
kustomize build . | k apply -f -
```

This should create the cluster and all provision all stuff for grafana
You can access grafana via `http//grafana.localhost:8081`
