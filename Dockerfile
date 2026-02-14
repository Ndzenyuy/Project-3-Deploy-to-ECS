FROM openjdk:17-ea-17-jdk-slim AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY ./ lumiatech-project
RUN cd lumiatech-project &&  mvn install 

FROM tomcat:9-jre11
LABEL "Project"="Lumiatech"
LABEL "Author"="Jones"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE lumiatech-project/target/lumiatech-v1.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]