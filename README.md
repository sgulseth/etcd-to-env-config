# etcd-to-env-config

Generates(and updates automatically when run as a docker daemon) dot-env files based on etcdctl key-values. The following etcd structure `etcdctl set /config/foo/bar baz` will generate a env-file in the current directory called foo.env containing `bar=baz`

To run and update configuration automatically use docker with `docker run -v /etc/app-envs:/etc/app-envs --net=host -t quay.io/sgulseth/etcd-to-env-config`
