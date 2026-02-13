FROM dart:stable

WORKDIR /app

# نسخ المشروع بالكامل (workspace root)
COPY . .

# الدخول لمجلد السيرفر
WORKDIR /app/nexa_serverpod_server

# تثبيت الحزم
RUN dart pub get

# تشغيل السيرفر
CMD ["dart", "bin/main.dart", "--mode", "production"]
