# ---------------------------
# Stage 1: Build
# ---------------------------
FROM dart:stable AS build

WORKDIR /app

# نسخ المشروع كامل (workspace root)
COPY . .

# الدخول إلى مجلد السيرفر فقط
WORKDIR /app/nexa_serverpod_server

# تحميل dependencies الخاصة بالسيرفر فقط
RUN dart pub get

# بناء executable للسيرفر
RUN dart compile exe bin/main.dart -o server


# ---------------------------
# Stage 2: Runtime
# ---------------------------
FROM debian:stable-slim

WORKDIR /app

# تثبيت شهادات SSL فقط (خفيف جداً)
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# نسخ الملف التنفيذي فقط من مرحلة البناء
COPY --from=build /app/nexa_serverpod_server/server ./server

# فتح البورت
EXPOSE 8080

# تشغيل السيرفر
CMD ["./server", "--mode", "production"]
