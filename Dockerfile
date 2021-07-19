FROM ubuntu:18.04 as builder
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

RUN git clone https://github.com/ameysunu/realm-swiftui.git

FROM caddy:2.1.1-alpine
COPY --from=builder /home/developer/realm-swiftui/ .
EXPOSE 80
CMD ["caddy","file-server","--browse"]