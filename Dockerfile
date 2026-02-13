# ---------- Stage 1: Build ----------
FROM dart:stable AS build

WORKDIR /app

# نسخ المشروع بالكامل (workspace root)
COPY . .

# حل المشكلة: تثبيت حزم السيرفر فقط بدون flutter
WORKDIR /app/nexa_serverpod_server

RUN dart pub get
RUN dart compile exe bin/main.dart -o server

# ---------- Stage 2: Runtime ----------
FROM debian:stable-slim

WORKDIR /app

# تثبيت certificates
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# نسخ الملف التنفيذي فقط
COPY --from=build /app/nexa_serverpod_server/server ./server

EXPOSE 8080

CMD ["./server", "--mode", "production"]
