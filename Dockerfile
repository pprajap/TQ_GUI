# Use Ubuntu as the base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    python3 \
    python3-pip \
    mesa-common-dev \
    mesa-utils \
    libvulkan-dev \
    libxkbcommon-x11-0 \
    libxkbcommon-dev \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
RUN apt-get update && apt-get install -y \
    libxcb-xinerama0 \
    libxcb-xinput0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxcb-xkb1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && add-apt-repository ppa:oibaf/graphics-drivers \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    qt6-base-dev \
    qt6-declarative-dev \
    qt6-tools-dev \
    qt6-tools-dev-tools \
    qt6-wayland-dev \
    qml6-module-qtqml \
    qml6-module-qtqml-workerscript \
    qml6-module-qtquick \
    qml6-module-qtquick-window \
    qml6-module-qtquick-controls \
    qml6-module-qtquick-layouts \
    qml6-module-qtquick-templates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV QT_BASE_DIR=/usr/lib/qt6
ENV PATH=$QT_BASE_DIR/bin:$PATH
ENV LD_LIBRARY_PATH=$QT_BASE_DIR/lib
ENV QML2_IMPORT_PATH=$QT_BASE_DIR/qml
ENV QT_PLUGIN_PATH=$QT_BASE_DIR/plugins

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
# COPY . /app

# Command to run when starting the container
CMD ["/bin/bash"]

# build this image with name qt6webapp
# docker build -t tq_gui .

# run the container and mount the current directory to /app in the container
# xhost +local:docker
# docker run -it --rm \
# -e DISPLAY=$DISPLAY \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# --device /dev/dri \
# -v $(pwd):/app \
# tq_gui