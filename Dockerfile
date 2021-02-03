FROM alpine as builder
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-background-cpuminer
RUN		apk add make gcc g++ git automake autoconf curl-dev
RUN 		git clone https://github.com/CoreTex/docker-background-cpuminer .
RUN		./autogen.sh
RUN		./configure CFLAGS="-O3 -march=x86-64"
RUN 		make

FROM alpine
MAINTAINER	Eric Dorr <githubcode@mail.ericdorr.de>

WORKDIR /docker-background-cpuminer
COPY --from=builder /docker-background-cpuminer .
RUN		apk add curl
RUN 		ls -lah
ENTRYPOINT	["./minerd"]
