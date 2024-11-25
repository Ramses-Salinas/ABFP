FROM dockerfile/java:oracle-java8

VOLUME /tmp
ADD abfp.jar /opt/abfp/
EXPOSE 8080
WORKDIR /opt/abfp/
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-Xms512m", "-Xmx1g", "-jar", "abfp.jar"]
