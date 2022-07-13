FROM ubuntu:latest

# Install curl, jq, unzip
RUN apt update && apt upgrade -y \
    && apt install -y \
    curl \
    unzip \
    jq \
    gpg \
    lsb-core \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev

# Download the latest curl binary (∵ apt does not have it)
ENV GH_USER="moparisthebest" \
    CURL_REPO="static-curl"

ENV CURL_LATEST="https://api.github.com/repos/${GH_USER}/${CURL_REPO}/releases/latest"

RUN ARCH=$(dpkg --print-architecture) \
    && URL=$(curl -L -s -H 'Accept: application/json' $CURL_LATEST | jq -r ".assets[] | select(.name | contains(\"$ARCH\")) | .browser_download_url") \
    && curl -L $URL --output /usr/local/bin/curl \
    && chmod +x /usr/local/bin/curl \
    && apt remove curl -y && apt autoremove -y \
    && echo "Setting hardlink to curl" \
    && ln -s /usr/local/bin/curl /usr/bin/curl \
    && echo "curl version '$(which curl)':" \
    && curl --version

# Download the latest upstream git binary (∵ apt does not have it)

ENV PPA_REPO="git-core" \
    PPA_SIG="A1715D88E1DF1F24"

RUN mkdir /root/.gnupg/ \
    && gpg --no-default-keyring --secret-keyring /etc/apt/secring.gpg --trustdb-name /etc/apt/trustdb.gpg --keyring /usr/share/keyrings/${PPA_REPO}-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ${PPA_SIG} \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/${PPA_REPO}-archive-keyring.gpg] https://ppa.launchpadcontent.net/${PPA_REPO}/ppa/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/${PPA_REPO}.list \
    && cat /etc/apt/sources.list.d/${PPA_REPO}.list \
    && apt update \
    && apt install -y git \
    && echo "git version '$(which git)':" \
    && git --version

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
