FROM dart:stable

WORKDIR /app

# نسخ المشروع بالكامل
COPY . .

# تثبيت الحزم من الجذر (workspace)
RUN dart pub get

# الدخول إلى السيرفر
WORKDIR /app/nexa_serverpod_server

# تشغيل السيرفر
CMD ["dart", "bin/main.dart", "--mode", "production"]
