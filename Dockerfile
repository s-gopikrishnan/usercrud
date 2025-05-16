# Use a base image with JDK 17 and Maven installed
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy everything into the container
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# Use a lightweight image to run the app
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/usercrud-0.0.1-SNAPSHOT.jar app.jar

# Run the Spring Boot app
CMD ["java", "-jar", "app.jar"]
