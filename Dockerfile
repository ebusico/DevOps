FROM maven as build
WORKDIR /build
COPY pom.xml .
COPY . .
RUN mvn clean package

FROM openjdk:8
COPY --from=build /build/target/RoomsGatewayAPI-0.0.1-SNAPSHOT.jar  room.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","room.jar"]
