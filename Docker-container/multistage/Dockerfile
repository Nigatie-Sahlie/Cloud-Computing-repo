# ---------- Stage 1: build. This entire stage is discarded. ----------
FROM golang:1.22 AS builder

WORKDIR /src
COPY go.mod ./
COPY main.go ./

# CGO_ENABLED=0 → a fully static binary with no libc dependency
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags='-s -w' -o /out/server .

# ---------- Stage 2: runtime. This is all that ships. ----------
FROM gcr.io/distroless/static:nonroot
COPY --from=builder /out/server /server
USER nonroot:nonroot
EXPOSE 8080
ENTRYPOINT ["/server"]