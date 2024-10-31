# Start with an official base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    ssh \
    npm \
    maven \
    openjdk-11-jdk \
    && apt-get clean

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Verify installation of each tool
RUN kubectl version --client && \
    git --version && \
    npm --version && \
    mvn --version && \
    java -version

# Set working directory
WORKDIR /workspace

# Define entrypoint (optional, based on your specific needs)
CMD ["/bin/bash"]
