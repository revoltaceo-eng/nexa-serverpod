# ---------------------------
# Stage 1: Build
# ---------------------------
FROM dart:stable AS build

WORKDIR /app

# نسخ السيرفر فقط
COPY nexa_serverpod_server ./nexa_serverpod_server

WORKDIR /app/nexa_serverpod_server

# تعطيل workspace
RUN dart pub get --no-workspace

# بناء executable
RUN dart compile exe bin/main.dart -o server


# ---------------------------
# Stage 2: Runtime
# ---------------------------
FROM debian:stable-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /app/nexa_serverpod_server/server ./server

EXPOSE 8080

CMD ["./server", "--mode", "production"]
