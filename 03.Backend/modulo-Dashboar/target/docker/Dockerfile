FROM dockerfile/java:oracle-java8

VOLUME /tmp
ADD abfp.dashboard.jar /opt/abfp.dashboard/
EXPOSE 8080
WORKDIR /opt/abfp.dashboard/
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-Xms512m", "-Xmx1g", "-jar", "abfp.dashboard.jar"]
