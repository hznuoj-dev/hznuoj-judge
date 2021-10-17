FROM ubuntu:20.04

USER root
WORKDIR /root/

COPY ./ ./hznuoj-judge

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
  && apt-get clean \
  && bash ./hznuoj-judge/install.sh

VOLUME [ "/home/judge/data" ]

ENTRYPOINT ["/root/hznuoj-judge/docker/docker-entrypoint.sh"]

CMD ["/bin/bash"]
