FROM adoptopenjdk/openjdk8:alpine-slim
LABEL maintainer="Martín Pena https://gitlab.com/mpenachayan/"
LABEL version="1.0"
LABEL basedOn="alvrme/alpine-android-base"

ENV SDK_TOOLS "4333796"
ENV ANDROID_HOME "/opt/sdk"
ENV GRADLE_HOME "/opt/gradle"
ENV BUILD_TOOLS "29.0.2"
ENV TARGET_SDK "29"
ENV GRADLE_VERSION "6.0.1"
#Posible values of GRADLE_DIST_TYPE: bin|all
ENV GRADLE_DIST_TYPE "bin" 
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$GRADLE_HOME/gradle-$GRADLE_VERSION/bin

# Install required dependencies
RUN apk --no-cache add bash \
        git \
        unzip \
        wget 
        
# Download and extract Android Tools
RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS}.zip -O /tmp/tools.zip && \
    mkdir -p ${ANDROID_HOME} && \
    unzip -qq /tmp/tools.zip -d ${ANDROID_HOME} 

# Install SDK Packages
RUN mkdir -p ~/.android/ && touch ~/.android/repositories.cfg && \
    yes | ${ANDROID_HOME}/tools/bin/sdkmanager "--licenses" && \
    ${ANDROID_HOME}/tools/bin/sdkmanager "platform-tools" "build-tools;${BUILD_TOOLS}" "platforms;android-${TARGET_SDK}" && \    
    ${ANDROID_HOME}/tools/bin/sdkmanager "--update"

#Download Gradle and extract Gradle to GRADLE_HOME 
RUN wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -O /tmp/gradle.zip && \
    mkdir -p ${GRADLE_HOME} && \ 
    unzip -qq /tmp/gradle.zip -d ${GRADLE_HOME} && \
    chmod +x ${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin/gradle

WORKDIR /home/gradle

#Create Wrapper Files to proper Gradle Distribution and force download of Wrapper Distribution
RUN gradle wrapper --gradle-version=${GRADLE_VERSION} --distribution-type=${GRADLE_DIST_TYPE} && \
    chmod +x ./gradlew && \
    ./gradlew
    
#Remove temporal folder to reduce image size and remove downloaded Gradle Distribution 
RUN rm -rf /tmp/* && rm -rf "${GRADLE_HOME:?}"/*
