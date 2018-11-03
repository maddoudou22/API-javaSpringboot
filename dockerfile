FROM java:8
ARG PACKAGE_VERSION
ARG APPLICATION_NAME
ENV APACKAGE_VERSION ${PACKAGE_VERSION}
ENV AAPPLICATION_NAME ${APPLICATION_NAME}
COPY /target/${APPLICATION_NAME}-${PACKAGE_VERSION}.jar ${APPLICATION_NAME}-${PACKAGE_VERSION}.jar
EXPOSE 8080
CMD java -jar ${AAPPLICATION_NAME}-${APACKAGE_VERSION}.jar
