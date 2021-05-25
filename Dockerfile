FROM hashicorp/terraform:0.12

RUN apk add make

WORKDIR /tmp
COPY . /tmp

ENTRYPOINT [ "/usr/bin/make" ]
