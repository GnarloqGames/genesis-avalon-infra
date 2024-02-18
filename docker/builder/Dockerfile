FROM golang:bookworm

RUN apt-get update && apt-get install -y curl

RUN go install github.com/goreleaser/goreleaser@latest
RUN go install github.com/caarlos0/svu@latest

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.56.2