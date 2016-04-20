# etcd-to-env-config

Generates(and updates automatically when run as a docker daemon) dot-env files based on etcdctl key-values. The following etcd structure `/config/APP_NAME/KEY` will generate a env-file with APP_NAME.env containing KEY=VALUE
 
`docker run --net=host -t quay.io/sgulseth/etcd-to-env-config`
