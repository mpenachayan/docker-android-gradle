FROM adoptopenjdk/openjdk8:alpine-slim
LABEL maintainer="Martín Pena https://gitlab.com/mpenachayan/"
LABEL version="1.0"
LABEL basedOn="alvrme/alpine-android-base"

ENV SDK_TOOLS "4333796"
ENV ANDROID_HOME "/opt/sdk"
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
ENV BUILD_TOOLS "29.0.2"
ENV TARGET_SDK "29"
ENV GRADLE_VERSION "5.6.4"
ENV GRADLE_DIST "${GRADLE_VERSION}-bin"
ENV GRADLE_WRAPPER_HOME "/root/.gradle/wrapper/dists/gradle-${GRADLE_DIST}/bxirm19lnfz6nurbatndyydux/"

# Install required dependencies
RUN apk add --no-cache bash git unzip wget && \
    apk add --virtual .rundeps $runDeps && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

# Download and extract Android Tools
RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS}.zip -O /tmp/tools.zip && \
    mkdir -p ${ANDROID_HOME} && \
    unzip -qq /tmp/tools.zip -d ${ANDROID_HOME} 

# Install SDK Packages
RUN mkdir -p ~/.android/ && touch ~/.android/repositories.cfg && \
    yes | ${ANDROID_HOME}/tools/bin/sdkmanager "--licenses" && \
    ${ANDROID_HOME}/tools/bin/sdkmanager "platform-tools" "build-tools;${BUILD_TOOLS}" "platforms;android-${TARGET_SDK}" && \    
    ${ANDROID_HOME}/tools/bin/sdkmanager "--update"

#Download and extract Gradle to WRAPPER folders 
RUN wget -q https://services.gradle.org/distributions/gradle-${GRADLE_DIST}.zip -O /tmp/gradle.zip && \
    mkdir -p ${GRADLE_WRAPPER_HOME} && \ 
    unzip -qq /tmp/gradle.zip -d ${GRADLE_WRAPPER_HOME}

#Set execution permissions to gradle binaries
RUN chmod +x ${GRADLE_WRAPPER_HOME}/gradle-${GRADLE_VERSION}/bin/gradle 

#Remove temporal folder to reduce image size
RUN rm -rf /tmp/*

WORKDIR /home/android
