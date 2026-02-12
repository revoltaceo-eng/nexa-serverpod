FROM dart:stable

WORKDIR /app

# نسخ مجلد السيرفر فقط
COPY nexa_serverpod_server ./nexa_serverpod_server

WORKDIR /app/nexa_serverpod_server

# تثبيت الحزم الخاصة بالسيرفر فقط
RUN dart pub get

# تشغيل السيرفر بوضع production
CMD ["dart", "bin/main.dart", "--mode", "production"]

