FROM ubuntu:18.04

ARG USERNAME=thiea
ARG PASSWORD
ARG GROUPNAME=thiea
ARG USERID=1000
ARG GROUPID=1000
ARG http_proxy
ARG https_proxy
ARG no_proxy

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV NVM_DIR /home/${USERNAME}/.nvm

RUN apt-get update -y \
	&& apt-get install -y curl git sudo python build-essential locales language-pack-ja-base language-pack-ja \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/* \
    && locale-gen ja_JP.UTF-8 \
    && localedef -f UTF-8 -i ja_JP ja_JP.utf8 \
    && groupadd -g ${GROUPID} ${GROUPNAME} \
    && useradd -d /home/${USERNAME} -m -s /bin/bash -u ${USERID} -g ${GROUPID} ${USERNAME} \
    && gpasswd -a ${USERNAME} sudo \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USERNAME}

USER ${USERID}

COPY package.json /home/${USERNAME}
COPY docker-entrypoint1.sh /home/${USERNAME}

RUN sudo chown ${USERNAME}:${GROUPNAME} /home/${USERNAME} \
    && cd /home/${USERNAME} \
	&& curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
	&& export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && nvm install 10 \
    && npm install -g yarn \
    && yarn \
    && yarn theia build
    
WORKDIR /home/${USERNAME}/workspace

# Expose port 8000 of the container
EXPOSE 8000

ENTRYPOINT ["./../docker-entrypoint1.sh"]