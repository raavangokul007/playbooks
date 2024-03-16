FROM maven:3.8.4-openjdk-11 as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package


FROM amazoncorretto:11-alpine as tomcat-base
RUN apk  add curl tar bash
ENV TOMCAT_VERSION=9.0.87
RUN curl -fsSL -O https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt \
    && mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
    && rm apache-tomcat-${TOMCAT_VERSION}.tar.gz
EXPOSE 8080
ENV CATALINA_HOME /opt/tomcat
RUN addgroup -S tomcat && \
    adduser -S -G tomcat -h /opt/tomcat -s /bin/false tomcat && \
    chown -R tomcat:tomcat /opt/tomcat/


FROM tomcat-base
COPY --from=builder /app/target/maven-web-application.war /opt/tomcat/webapps/
USER tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
