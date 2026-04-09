FROM golang:1.22.5 as base 
# Alias for multi stage docker build
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .

# Final stage with distro less image

FROM gcr.io/distroless/base

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
