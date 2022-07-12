FROM ubuntu:latest

# Install curl, jq, unzip
RUN apt update && apt upgrade -y \
    && apt install -y \
    curl \
    unzip \
    jq \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev
# Download the latest curl binary (∵ apt does not have it)
ENV USER="moparisthebest" \
    REPO="static-curl"

ENV GITHUB_API="https://api.github.com/repos/${USER}/${REPO}/releases/latest"

RUN ARCH=$(dpkg --print-architecture) \
    && URL=$(curl -L -s -H 'Accept: application/json' $GITHUB_API | jq -r ".assets[] | select(.name | contains(\"$ARCH\")) | .browser_download_url") \
    && curl -L $URL --output /usr/local/bin/curl \
    && chmod +x /usr/local/bin/curl \
    && apt remove curl -y && apt autoremove -y \
    && echo "Setting hardlink to curl" \
    && ln -s /usr/local/bin/curl /usr/bin/curl

# Install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" \
    && unzip /tmp/awscliv2.zip -d /tmp/ \
    && /tmp/aws/install \
    && rm -rf /tmp/aws /tmp/awscliv2.zip

# Configure the aws cli
ENV AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION $AWS_DEFAULT_REGION


# Install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | sh - \
    && apt install -y nodejs \
    && apt autoremove -y  \
    && rm -rf /var/lib/apt/lists/*

# Update npm
RUN npm install npm -g

ENTRYPOINT ["/bin/bash"]
