# Base image
FROM arm64v8/debian:buster

ENV TVTIMEZONE=America\/New_York
ENV LINEUPID=USA-OTA30236

# Install dependencies
# Set a different package repository mirror
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nginx \
    supervisor \
    php \
    cron \
    ffmpeg \
    libssl-dev \
    libx11-dev \
    libva2 \
    libva-drm2 \
    libva-x11-2 \
    libvdpau-dev \
    libgl1-mesa-dev \
    xvfb \
    x11vnc \
    openbox \
    xinit \
    ttf-dejavu-core \
    dbus-x11

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Set up Xvfb and Openbox configurations
RUN mkdir -p /root/.config/openbox && \
    echo 'xrandr -s 1280x720' >> /root/.config/openbox/autostart && \
    echo 'x11vnc -forever -passwd password' >> /root/.config/openbox/autostart

# Download and install DizqueTV
RUN cd /opt && git clone https://github.com/vexorian/dizquetv.git 
RUN cd /opt/dizquetv && git checkout 1.5.0 && \
    npm install && \
    npm run build

# Expose ports 8000 and 8001
EXPOSE 8000
EXPOSE 8001

COPY tvtv2xmltv-config /etc
COPY docker-entrypoint.sh /etc/nginx
RUN chmod +x /etc/nginx/docker-entrypoint.sh

# Start dizqueTV
WORKDIR /opt/dizquetv
CMD ["/bin/bash"]

ENTRYPOINT ["/etc/nginx/docker-entrypoint.sh"]
