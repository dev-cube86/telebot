FROM quay.io/projectquay/golang:1.22 as builder
ARG TARGETOS
ARG GOARCH
WORKDIR /go/src/app
COPY . .
RUN make $TARGETOS

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/telebot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
# LABEL org.opencontainers.image.source=https://https://github.com/dev-cube86/telebot
ENTRYPOINT ["./telebot"]