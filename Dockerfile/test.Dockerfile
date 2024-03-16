FROM alpine:latest as build
RUN apk update && \
    apk add --no-cache wget openjdk11-jre-headless && \
    addgroup -S tomcat && \
    adduser -S -G tomcat -h /opt/tomcat -s /sbin/n tomcat
RUN mkdir /opt && \
    wget -qO- https://downloads.apache.org/tomcat/tomcat-9/v9.0.50/bin/apache-tomcat-9.0.50.tar.gz | tar xz -C /opt && \
    mv /opt/apache-tomcat-9.0.50 /opt/tomcat && \
    chown -R tomcat:tomcat /opt/tomcat

FROM alpine:latest
RUN addgroup -S tomcat && \
    adduser -S -G tomcat -h /opt/tomcat -s /sbin/nologin tomcat
COPY --from=build --chown=tomcat:tomcat /opt/tomcat /opt/tomcat
EXPOSE 8080
USER tomcat
ENV CATALINA_HOME /opt/tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

