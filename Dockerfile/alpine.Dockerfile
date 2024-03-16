# Stage 1: Build stage
FROM alpine:latest AS build

# Install dependencies
RUN apk update && \
    apk add --no-cache wget openjdk11-jre-headless && \
    addgroup -S tomcat && \
    adduser -S -G tomcat -h /opt/tomcat -s /sbin/n tomcat

# Download and extract Tomcat
RUN mkdir /opt && \
    wget -qO- https://downloads.apache.org/tomcat/tomcat-9/v9.0.50/bin/apache-tomcat-9.0.50.tar.gz | tar xz -C /opt && \
    mv /opt/apache-tomcat-9.0.50 /opt/tomcat && \
    chown -R tomcat:tomcat /opt/tomcat

# Stage 2: Final stage
FROM alpine:latest

# Create a tomcat user
RUN addgroup -S tomcat && \
    adduser -S -G tomcat -h /opt/tomcat -s /sbin/nologin tomcat

# Copy Tomcat from the build stage
COPY --from=build --chown=tomcat:tomcat /opt/tomcat /opt/tomcat

# Expose Tomcat ports
EXPOSE 8080

# Switch to the tomcat user
USER tomcat

# Set environment variables
ENV CATALINA_HOME /opt/tomcat

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
