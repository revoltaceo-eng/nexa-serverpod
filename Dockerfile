FROM dart:stable

# مجلد العمل الأساسي
WORKDIR /app

# نسخ كل المشروع
COPY . .

# الدخول إلى مجلد السيرفر
WORKDIR /app/nexa_serverpod_server

# تثبيت الحزم
RUN dart pub get

# تشغيل السيرفر في وضع production
CMD ["dart", "bin/main.dart", "--mode", "production"]

