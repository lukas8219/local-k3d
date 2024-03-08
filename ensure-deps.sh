function ensure(){
  CMD=$(which $1 | grep -v "not found")
  if [ -z "$CMD" ]; then
    echo "$1 is missing. Please install it";
    exit 1
  fi
}

ensure "kustomize"
ensure "jq"
ensure "kubectl"
ensure "k3d"
