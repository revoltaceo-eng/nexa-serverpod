FROM cirrusci/flutter:stable

WORKDIR /app

COPY . .

WORKDIR /app/nexa_serverpod_server

RUN flutter pub get

EXPOSE 8080

CMD ["dart", "bin/main.dart"]

