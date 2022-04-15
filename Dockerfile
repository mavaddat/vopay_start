FROM ubuntu:latest

WORKDIR $BITBUCKET_CLONE_DIR

ENV USER $BITBUCKET_USER

# Install curl, jq, unzip
RUN apt update && apt upgrade -y \
    && apt install -y \
    curl \
    unzip \
    jq

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
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip -d /tmp/ \
    && /tmp/aws/install \
    && rm -rf /tmp/aws /tmp/awscliv2.zip

# Install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | sh - \
    && apt install -y nodejs \
    && apt autoremove -y  \
    && rm -rf /var/lib/apt/lists/*

# set_token is a function that sets the bitbucket oauth token in the environment
RUN bash -c 'function set_token { \
    JSON_OUTPUT=$(curl -X POST -u "$BIT_BUCK_KEY:$BIT_BUCK_SECRET" https://bitbucket.org/site/oauth2/access_token -d grant_type=client_credentials); \
    export OAUTH_TOKEN=$(echo $JSON_OUTPUT | tee oauth.json | jq -r .access_token); \
}; \
declare -f set_token >> ~/.bashrc;'

# check_token is a function that checks the bitbucket oauth token
RUN bash -c 'function check_token { \
    if test -f oauth.json; then \
        EXPIRES_IN=$(jq -r .expires_in oauth.json); \
        export OAUTH_TOKEN=$(jq -r .access_token oauth.json); \
        CURRENT_TIME=$(date +%s); \
        OAUTH_MODIFIED_TIME=$(stat -c %Y oauth.json); \
        DELTA=$(($CURRENT_TIME - $OAUTH_MODIFIED_TIME)); \
        if [ $DELTA -gt $EXPIRES_IN ]; then \
            set_token; \
        fi; \
    else \
        set_token; \
    fi; \
}; \
declare -f check_token >> ~/.bashrc;'

# get_amplify_apps is a function that gets the amplify apps from the AWS Amplify API
RUN bash -c 'function get_amplify_apps { \
    curl --aws-sigv4 "aws:amz:ca-central-1:es" --user "$AWS_SECRET_ACCESS_KEY:$AWS_SECRET_ACCESS_KEY" "https://amplify.ca-central-1.amazonaws.com/apps?maxResults=$MAX_RESULTS&nextToken=%00" --output /dev/null --silent --show-error --write-out "%{http_code}"; \
}; \
declare -f get_amplify_apps >> ~/.bashrc;'

# find_amplify_app is a function that finds the amplify app with the given name (using the first arg as the name and the pipeline stdin as the JSON to parse)
RUN bash -c 'function find_amplify_app { \
    read JSON; \
    local APP_NAME=$1; \
    echo $JSON | jq -r ".apps[] | select(.name == \\"$APP_NAME\\") | .appId"; \
}; \
declare -f find_amplify_app >> ~/.bashrc;'

ENTRYPOINT ["/bin/bash"]
