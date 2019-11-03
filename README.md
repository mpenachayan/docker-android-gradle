# Docker Image with Android SDK and Gradle

The aim of this image is to include all the libraries and dependencies needed to build Android apps in a small Docker Image. This image use Docker image **adoptopenjdk/openjdk8-openj9:alpine-slim** as base and it's inspired by this [Github](https://github.com/alvr/alpine-android)

## Pull Image from Docker Cloud

```
docker pull mpenachayan/android-sdk-gradle:latest
```

```
docker run -it mpenachayan/android-sdk-gradle:latest
```

## Build Docker Image and Run

Follow these steps to build and run Docker image

```
git clone https://gitlab.com/mpenachayan/docker-android-gradle.git
```

```
cd docker-android-gradle
```

Edit Dockerfile as needed to change Android Target SDK, Android Build Tools version and/or Gradle version

```
ENV BUILD_TOOLS "29.0.2"
ENV TARGET_SDK "29"
ENV GRADLE_VERSION "5.6.4"
ENV GRADLE_DIST_TYPE "bin"
```

```
docker build -t android-gradle:tagname .
```

```
docker run -it android-gradle:tagname
```