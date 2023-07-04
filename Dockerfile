# syntax=docker/dockerfile:1.3
FROM maven:3.8.6-openjdk-11-slim@sha256:2cb7c73ba2fd0f7ae64cfabd99180030ec85841a1197b4ae821d21836cb0aa3b AS build
ARG ENFORCER_FAIL

RUN groupadd -r -g 1000 maven && useradd -m -l -r -u 1000 -g maven maven
ENV MAVEN_CONFIG /home/maven/.m2
ENV MAVEN_OPTS -Duser.home=/home/maven
USER maven

WORKDIR /app
COPY --chown=maven:maven . /app

ARG MAVEN_PHASE
RUN --mount=type=cache,uid=1000,gid=1000,target=/home/maven/.m2 echo "0" > EXIT_STATUS_FILE &&\
    mvn --batch-mode $MAVEN_PHASE -Denforcer.fail=$ENFORCER_FAIL || echo $? > EXIT_STATUS_FILE


FROM scratch AS target
COPY --from=build /app/target/ /

FROM build AS status
COPY --from=build /app/EXIT_STATUS_FILE/ /EXIT_STATUS_FILE
RUN exit $(cat /EXIT_STATUS_FILE)
