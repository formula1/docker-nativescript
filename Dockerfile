FROM kallikrein/cordova:5.1.1

MAINTAINER Thomas Charlat
RUN \
apt-get update && \
apt-get install -y lib32stdc++6 lib32z1 lib32ncurses5 lib32bz2-1.0 g++ ant python make

RUN curl -sL https://deb.nodesource.com/setup_iojs_2.x | sudo bash - && sudo apt-get install -y iojs
RUN npm install n -g
RUN n stable
RUN npm install nativescript -g --unsafe-perm

# download and extract android sdk
# update and accept licences
RUN curl http://dl.google.com/android/android-sdk_r24.2-linux.tgz | tar xz -C /usr/local && \
  ( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /usr/local/android-sdk-linux/tools/android update sdk --no-ui -a --filter platform-tool,build-tools-23.0.1,android-22,extra-android-m2repository

ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
ENV GRADLE_USER_HOME /src/gradle
VOLUME /src
WORKDIR /src
