FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY booking-service.jar /app/app.jar

EXPOSE 8080

# Optional: healthcheck (remove if you don't use Actuator)
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -qO- http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java","-jar","/app/app.jar"]
