# syntax=docker/dockerfile:1.3
FROM maven:3.8.2-openjdk-11-slim@sha256:65fd85ac347fb1a6fa84c3383cc8c061e9b8c04e3d10cd61c6d46baa75dc5b11 AS build
ARG DOCKER_GROUP_ID
RUN groupadd -r -g $DOCKER_GROUP_ID docker && useradd -m -l -r -u 1000 -g docker maven
ENV MAVEN_CONFIG /home/maven/.m2
ENV MAVEN_OPTS -Duser.home=/home/maven
USER maven
WORKDIR /app
