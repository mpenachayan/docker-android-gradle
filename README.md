# Docker Image with Android SDK and Gradle

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7bc655995a5548608df8c04a6fd4f090)](https://www.codacy.com/manual/mpenachayan/docker-android-gradle?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=mpenachayan/docker-android-gradle&amp;utm_campaign=Badge_Grade)
[![CodeFactor](https://www.codefactor.io/repository/github/mpenachayan/docker-android-gradle/badge)](https://www.codefactor.io/repository/github/mpenachayan/docker-android-gradle)

The aim of this image is to include all the libraries and dependencies needed to build Android apps in a small Docker Image. This image use Docker image **adoptopenjdk/openjdk8-openj9:alpine-slim** as base and it's inspired by this [Github](https://github.com/alvr/alpine-android)

## Pull Image from Docker Cloud

```bash
docker pull mpenachayan/android-sdk-gradle:latest
```

```bash
docker run -it mpenachayan/android-sdk-gradle:latest
```

## Build Docker Image and Run

Follow these steps to build and run Docker image

```bash
git clone https://gitlab.com/mpenachayan/docker-android-gradle.git
```

```bash
cd docker-android-gradle
```

Edit Dockerfile as needed to change Android Target SDK, Android Build Tools version and/or Gradle version

```docker
ENV SDK_TOOLS "6514223_latest"
ENV BUILD_TOOLS "30.0.2"
ENV TARGET_SDK "30"
ENV GRADLE_VERSION "6.6"
# Possible values of GRADLE_DIST_TYPE: bin|all
ENV GRADLE_DIST_TYPE "bin"
```

```bash
docker build -t android-gradle:tagname .
```

```bash
docker run -it android-gradle:tagname
```
