### OLD
# FROM debian:stable-slim
# COPY _output/local/bin/linux/amd64/kubelet /kubelet
### sleep go program that allows to instantiate a container to use `docker cp` for coping the binaries out of it

FROM golang:1.15 AS golang

RUN echo "package main\nimport \"time\"\nfunc main() { time.Sleep(time.Hour) }" > sleep.go && \
    GOOS=linux go build -o /sleep sleep.go

### actual container

FROM scratch

ADD _output/local/bin/linux/amd64/kubelet /kubelet
ADD _output/local/bin/linux/amd64/kubectl /kubectl
COPY --from=golang /sleep .

ENTRYPOINT ["/sleep"]