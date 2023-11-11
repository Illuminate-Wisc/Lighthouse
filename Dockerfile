FROM ubuntu:latest

RUN apt update && apt install -y --no-install-recommends \
    ca-certificates \
    git \
    zip \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists

ARG GODOT_VERSION="4.1.2"
ARG GODOT_RELEASE_TYPE="stable"

ENV GODOT_NAME="${GODOT_VERSION}-${GODOT_RELEASE_TYPE}"
ENV GODOT_PLATFORM="linux.x86_64"

RUN curl -fsSL https://github.com/godotengine/godot/releases/download/${GODOT_NAME}/Godot_v${GODOT_NAME}_${GODOT_PLATFORM}.zip -o godot.zip
RUN curl -fsSL https://github.com/godotengine/godot/releases/download/${GODOT_NAME}/Godot_v${GODOT_NAME}_export_templates.tpz -o templates.tpz

RUN mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.${GODOT_RELEASE_TYPE}

RUN unzip godot.zip
RUN mv Godot_v${GODOT_NAME}_${GODOT_PLATFORM} /usr/local/bin/godot
RUN rm godot.zip

RUN unzip templates.tpz
RUN mv templates/web_release.zip ~/.local/share/godot/export_templates/${GODOT_VERSION}.${GODOT_RELEASE_TYPE}
RUN rm templates.tpz && rm -rf templates

