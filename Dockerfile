FROM openjdk:8u212-jre-alpine

ARG kafka_version=2.2.1
ARG scala_version=2.11
ARG glibc_version=2.31-r0
ARG build_date=2020-10-08

LABEL org.label-schema.name="kafka" \
      org.label-schema.description="Apache Kafka" \
      org.label-schema.build-date="${build_date}" \
      org.label-schema.version="${scala_version}_${kafka_version}" \
      org.label-schema.schema-version="1.0" \
      maintainer="gallop"

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka \
    GLIBC_VERSION=$glibc_version

ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY start-kafka.sh broker-list.sh create-topics.sh versions.sh glibc-2.31-r0.apk kafka.tgz /tmp/
# ADD kafka.tgz /opt

# 更换国内源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache bash curl jq docker \
 && chmod a+x /tmp/*.sh \
 && mv /tmp/start-kafka.sh /tmp/broker-list.sh /tmp/create-topics.sh /tmp/versions.sh /usr/bin \
 && mkdir /opt/kafka \
 && tar xfz /tmp/kafka.tgz -C /opt/kafka --strip-components 1 \
 && rm /tmp/kafka.tgz \
 # && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
 # && apk add --no-cache --allow-untrusted glibc-${GLIBC_VERSION}.apk \
 && apk add --no-cache --allow-untrusted /tmp/glibc-2.31-r0.apk \
 && rm /tmp/glibc-2.31-r0.apk
 # && rm glibc-${GLIBC_VERSION}.apk

COPY overrides /opt/overrides

VOLUME ["/kafka"]

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["start-kafka.sh"]
