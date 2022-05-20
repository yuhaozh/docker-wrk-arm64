FROM arm64v8/alpine
RUN apk --no-cache add build-base git luajit perl linux-headers
RUN git clone --depth 1 https://github.com/wg/wrk
RUN cd wrk && sed -i 's/LDFLAGS += -Wl,-E/LDFLAGS += -Wl,-E -static/g' Makefile && make

FROM arm64v8/alpine
COPY --from=0 /wrk/wrk /bin/
CMD [ "/bin/wrk", "-h" ]
