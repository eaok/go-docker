FROM  golang:latest as build-env
LABEL MAINTAINER="kcoewoys"

ENV GOPROXY=https://goproxy.cn,direct

WORKDIR /home/docker
COPY . .
RUN make

FROM alpine:latest
EXPOSE 8888
COPY --from=build-env /home/docker/dogo /home/docker/dogo
CMD ["/home/docker/dogo"]

#docker build -f multiBuild.Dockerfile -t dogo:multi .
#docker run --rm -p 8888:8888 dogo:multi