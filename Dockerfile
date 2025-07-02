FROM golang:1.22.5-alpine AS base
WORKDIR /app
COPY . . 
RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

WORKDIR /usr/src/app
COPY --from=base app/main .

COPY --from=base /app/static ./static
EXPOSE 8080
CMD ["./main"]


