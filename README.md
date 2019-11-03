# Docker Image with Android SDK and Gradle

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/mpenachayan/android-sdk-gradle)
![Docker Pulls](https://img.shields.io/docker/pulls/mpenachayan/android-sdk-gradle)
![Codacy grade](https://img.shields.io/codacy/grade/7bc655995a5548608df8c04a6fd4f090)
![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/mpenachayan/docker-android-gradle)

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
ENV BUILD_TOOLS "29.0.2"
ENV TARGET_SDK "29"
ENV GRADLE_VERSION "5.6.4"
# Possible values of GRADLE_DIST_TYPE: bin|all
ENV GRADLE_DIST_TYPE "bin"
```

```bash
docker build -t android-gradle:tagname .
```

```bash
docker run -it android-gradle:tagname
```