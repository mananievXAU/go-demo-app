FROM golang:1.26.1 AS builder

WORKDIR /go/src/app

COPY src/ .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/myapp .

FROM scratch

COPY --from=builder /app/myapp /app

ENTRYPOINT ["/app"]