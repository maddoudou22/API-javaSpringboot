FROM java:8
WORKDIR /var/lib/repositories/API-javaSpringboot_local
ADD /snapshot/API-javaSpringboot-0.1.0.jar API-javaSpringboot-0.1.0.jar
EXPOSE 8080
CMD java -jar API-javaSpringboot-0.1.0.jar
