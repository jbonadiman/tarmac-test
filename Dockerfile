FROM tinygo/tinygo:0.30.0 AS build

COPY . .
ENV GOFLAGS=-buildvcs=false
RUN tinygo build -o tarmac.wasm -target wasi

FROM madflojo/tarmac:latest

COPY --from=build /home/tinygo/tarmac.wasm /home/tinygo/tarmac.json /functions/

ENV APP_LISTEN_ADDR=0.0.0.0:8080 APP_ENABLE_TLS=false APP_DEBUG=true

EXPOSE 8080
