# Specify the base image
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y micro ncat curl git python3.10 libglib2.0-0 libnss3 pip redis tmux

# Configure the environment to your preferences
RUN echo 'alias l="ls -la --group-directories-first --color=auto"' >> ~/.bashrc && \
    echo 'alias c="clear"' >> ~/.bashrc && \
    echo 'export TERM=xterm-256color' >> ~/.bashrc

# Copy key file into container
COPY key.txt /opt/key.txt

# Set up Auto-GPT
RUN ln -s /usr/bin/python3.10 /usr/bin/python && \
    cd /opt && git clone https://github.com/Significant-Gravitas/Auto-GPT.git && \
    cd Auto-GPT && \
    git checkout stable && \
    cp .env.template .env && \
    sed -i "s/OPENAI_API_KEY=your-openai-api-key/OPENAI_API_KEY=$(cat /opt/key.txt)/" .env && \
    sed -i "s/# MEMORY_BACKEND=local/MEMORY_BACKEND=redis/" .env && \
    sed -i "s/# REDIS_HOST=localhost/REDIS_HOST=127.0.0.1/" .env && \
    sed -i "s/# REDIS_PORT=6379/REDIS_PORT=6379/" .env && \
    sed -i "s/# WIPE_REDIS_ON_START=True/WIPE_REDIS_ON_START=False/" .env

# Set working directory
WORKDIR /opt/Auto-GPT

# Define default command
CMD ["bash"]
