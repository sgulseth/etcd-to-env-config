FROM gliderlabs/alpine:3.3

RUN apk add --update bash && rm -rf /var/cache/apk/*

ADD https://github.com/coreos/etcd/releases/download/v0.4.6/etcd-v0.4.6-linux-amd64.tar.gz /tmp/etcd.tar.gz

WORKDIR /tmp
RUN tar zxvf etcd.tar.gz
RUN mv ./etcd-v0.4.6-linux-amd64/etcdctl /usr/bin/etcdctl

RUN mkdir -p /etc/app-envs/

ADD ./generate-config.sh /usr/bin/generate-config

CMD etcdctl exec-watch --recursive /config -- sh -c './generate-config.sh $(echo $ETCD_WATCH_KEY | cut -d "/" -f 3)'
