FROM alpine:latest AS builder

RUN apk -U add build-base git

WORKDIR /opt

RUN git clone https://github.com/google/jsonnet.git

RUN cd jsonnet && make

FROM alpine:latest

RUN apk add --no-cache libstdc++

COPY --from=builder /opt/jsonnet/jsonnet /usr/local/bin

ENTRYPOINT ["/bin/sh"]
