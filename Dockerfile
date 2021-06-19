FROM r.j3ss.co/img

USER root

RUN apk add --no-cache curl

USER user

RUN mkdir -p /home/user/.docker \
    /home/user/work \
    /home/user/.local/bin

COPY ./buildy /home/user/.local/bin

WORKDIR /home/user/work

ENV PATH "/home/user/.local/bin:$PATH"

ENTRYPOINT ["buildy"]

CMD ["--help"]
