# kafka-docker-image
构建kafka docker镜像的脚本项目。
>因为从官方网站下载kafka很慢，所以我这里下载下来，直接放构建镜像的目录里。

使用步骤：

直接在本目录中执行：

```
# 注意最后有个点号
docker build -t kafka:2.11_2.2.1 .

```

日志如下：

```
[root@hadoop02 kafka-image]# docker build -t kafka:2.11_2.2.1 .
Sending build context to Docker daemon  68.49MB
Step 1/15 : FROM openjdk:8u212-jre-alpine
 ---> f7a292bbb70c
Step 2/15 : ARG kafka_version=2.2.1
 ---> Using cache
 ---> b8864f1f2748
Step 3/15 : ARG scala_version=2.11
 ---> Using cache
 ---> af1c7a0b0466
Step 4/15 : ARG glibc_version=2.31-r0
 ---> Using cache
 ---> d52269583293
Step 5/15 : ARG build_date=2020-10-08
 ---> Using cache
 ---> b41c6344a063
Step 6/15 : LABEL org.label-schema.name="kafka"       org.label-schema.description="Apache Kafka"       org.label-schema.build-date="${build_date}"       org.label-schema.version="${scala_version}_${kafka_version}"       org.label-schema.schema-version="1.0"       maintainer="gallop"
 ---> Using cache
 ---> 13bb23359a13
Step 7/15 : ENV KAFKA_VERSION=$kafka_version     SCALA_VERSION=$scala_version     KAFKA_HOME=/opt/kafka     GLIBC_VERSION=$glibc_version
 ---> Using cache
 ---> ed6a5e85014d
Step 8/15 : ENV PATH=${PATH}:${KAFKA_HOME}/bin
 ---> Using cache
 ---> 070e1d7efc55
Step 9/15 : COPY start-kafka.sh broker-list.sh create-topics.sh versions.sh glibc-2.31-r0.apk /tmp/
 ---> afe48c4c8416
Step 10/15 : ADD kafka.tgz /opt
 ---> a1717330eb51
Step 11/15 : RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
 ---> Running in 2bb0e02603bd
Removing intermediate container 2bb0e02603bd
 ---> b27bc428400d
Step 12/15 : RUN apk add --no-cache bash curl jq docker  && chmod a+x /tmp/*.sh  && mv /tmp/start-kafka.sh /tmp/broker-list.sh /tmp/create-topics.sh /tmp/versions.sh /usr/bin  && apk add --no-cache --allow-untrusted /tmp/glibc-2.31-r0.apk  && rm /tmp/glibc-2.31-r0.apk
 ---> Running in 40f6dbb67752
fetch http://mirrors.aliyun.com/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://mirrors.aliyun.com/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
(1/21) Installing ncurses-terminfo-base (6.1_p20190105-r0)
(2/21) Installing ncurses-terminfo (6.1_p20190105-r0)
(3/21) Installing ncurses-libs (6.1_p20190105-r0)
(4/21) Installing readline (7.0.003-r1)
(5/21) Installing bash (4.4.19-r1)
Executing bash-4.4.19-r1.post-install
(6/21) Installing nghttp2-libs (1.35.1-r2)
(7/21) Installing libssh2 (1.9.0-r1)
(8/21) Installing libcurl (7.64.0-r4)
(9/21) Installing curl (7.64.0-r4)
(10/21) Installing libseccomp (2.4.2-r2)
(11/21) Installing runc (1.0.0_rc8-r0)
(12/21) Installing containerd (1.2.7-r0)
(13/21) Installing libmnl (1.0.4-r0)
(14/21) Installing jansson (2.11-r0)
(15/21) Installing libnftnl-libs (1.1.1-r0)
(16/21) Installing iptables (1.6.2-r1)
(17/21) Installing tini-static (0.18.0-r0)
(18/21) Installing device-mapper-libs (2.02.182-r0)
(19/21) Installing docker (18.09.8-r0)
Executing docker-18.09.8-r0.pre-install
(20/21) Installing oniguruma (6.9.4-r0)
(21/21) Installing jq (1.6-r0)
Executing busybox-1.29.3-r10.trigger
OK: 349 MiB in 74 packages
fetch http://mirrors.aliyun.com/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://mirrors.aliyun.com/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
(1/1) Installing glibc (2.31-r0)
OK: 358 MiB in 75 packages
Removing intermediate container 40f6dbb67752
 ---> 7089f89088a2
Step 13/15 : COPY overrides /opt/overrides
 ---> 0cccc94fb7af
Step 14/15 : VOLUME ["/kafka"]
 ---> Running in 4ad576135250
Removing intermediate container 4ad576135250
 ---> 890e329f187d
Step 15/15 : CMD ["start-kafka.sh"]
 ---> Running in 8e600c49c119
Removing intermediate container 8e600c49c119
 ---> 0ce1682c5106
Successfully built 0ce1682c5106
Successfully tagged kafka:2.11_2.2.1

```
