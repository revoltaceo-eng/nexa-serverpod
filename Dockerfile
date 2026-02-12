FROM dart:stable

WORKDIR /app

COPY . .

WORKDIR /app/nexa_serverpod_server

RUN dart pub get

EXPOSE 8080

CMD ["dart", "bin/main.dart"]

