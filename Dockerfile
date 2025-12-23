# syntax=docker/dockerfile:1.3
FROM maven:3.8.2-openjdk-11-slim@sha256:65fd85ac347fb1a6fa84c3383cc8c061e9b8c04e3d10cd61c6d46baa75dc5b11 AS build
ARG BUILDKIT_SBOM_SCAN_CONTEXT=true
ARG BUILDKIT_SBOM_SCAN_STAGE=true
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g "${GROUP_ID}" maven && useradd --create-home --no-log-init -u "${USER_ID}" -g "${GROUP_ID}" maven
ENV MAVEN_CONFIG /home/maven/.m2
ENV MAVEN_OPTS -Duser.home=/home/maven
USER maven
