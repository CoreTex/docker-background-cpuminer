FROM golang:1.11-alpine3.7 AS builder
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-background-cpuminer
RUN 		git clone https://github.com/CoreTex/docker-background-cpuminer .
RUN		./autogen.sh
RUN		./configure CFLAGS="-O3"
RUN 		make

FROM scratch
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-background-cpuminer
COPY --from=builder /docker-background-cpuminer .

ENTRYPOINT	["./m-minerd"]
