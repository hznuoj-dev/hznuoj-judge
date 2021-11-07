FROM ubuntu:20.04

USER root
WORKDIR /root/

COPY ./ ./hznuoj-judge

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
  && bash /root/hznuoj-judge/install_compiler.sh \
  && bash /root/hznuoj-judge/install_judge.sh \
  && cp /root/hznuoj-judge/docker/docker-entrypoint.sh /root/docker-entrypoint.sh \
  && rm -rf /root/hznuoj-judge

VOLUME [ "/home/judge/data" ]

ENTRYPOINT ["/root/docker-entrypoint.sh"]

CMD ["/bin/bash"]
