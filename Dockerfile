################################################################################
# building
################################################################################
FROM openjdk:8-jdk-alpine as building

ENV TZ=Asia/Bangkok

COPY build.gradle gradlew settings.gradle ./
RUN chmod +x ./gradlew
RUN ./gradlew build 2>/dev/null || return 0

COPY . .
RUN ./gradlew test build --profile

################################################################################
# deployment
################################################################################
FROM openjdk:8-jre-alpine as deployment

COPY --from=building /build/libs/sbthapi0-0.0.1.jar ./sbthapi0-0.0.1.jar

ENTRYPOINT ["java","-jar","/sbthapi0-0.0.1.jar"]