# ---------- Stage 1: Build ----------
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY . .

WORKDIR /app/nexa_serverpod_server
RUN flutter pub get
RUN dart compile exe bin/main.dart -o server

# ---------- Stage 2: Runtime ----------
FROM dart:stable

WORKDIR /app
COPY --from=build /app/nexa_serverpod_server/server .

EXPOSE 8080

CMD ["./server"]

