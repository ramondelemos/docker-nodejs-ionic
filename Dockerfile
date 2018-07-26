FROM ubuntu:16.04

LABEL MAINTAINER="Ramon de Lemos"

# Configure ANDROID_HOME
ENV ANDROID_HOME="/var/opt/android"
ENV PATH="/var/opt/gradle/2.14/bin:/var/opt/android/tools:/var/opt/android/tools/bin:/var/opt/android/platform-tools:/var/opt/android/platform-tools/bin:${PATH}"

RUN apt-get update

RUN apt-get install -y curl git software-properties-common unzip

# Install debian Packages
RUN apt-get install --yes \
    build-essential \
    inotify-tools \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables

# Install PostgreSQL Client
RUN apt-get install --yes postgresql-client

# Install Node.js 8.x
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Install Ionic and Cordova
RUN npm install -g ionic cordova

# Install Java 8
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper from https://github.com/jpetazzo/dind.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

WORKDIR /var/opt

# Install Android sdk-tools and sdkmanager
RUN curl -o sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
RUN unzip sdk-tools.zip -d android
RUN sdkmanager --update
RUN yes | sdkmanager "build-tools;26.0.2"
RUN yes | sdkmanager "platforms;android-26"
RUN sdkmanager "tools"

# Install Gradle 2.14
RUN curl -o gradle-2.14-bin.zip https://downloads.gradle.org/distributions/gradle-2.14-bin.zip
RUN unzip gradle-2.14-bin.zip -d gradle
RUN mv gradle/gradle-2.14 gradle/2.14

WORKDIR /root

# Define additional metadata for our image.
VOLUME /var/lib/docker
VOLUME /var/run/docker.sock

CMD ["wrapdocker"]