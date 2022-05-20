FROM arm64v8/ubuntu
RUN apt-get update && apt-get install -y build-essential git unzip
RUN git clone --depth 1 https://gitee.com/wjt1999/wrk
RUN cd wrk && make -j8

FROM arm64v8/ubuntu
RUN apt-get -y update && \
    apt-get --no-install-recommends -y install jq netbase && \
    apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base
COPY --from=0 /wrk/wrk /bin/
CMD [ "/bin/wrk" ]
