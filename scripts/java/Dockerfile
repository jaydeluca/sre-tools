FROM amazoncorretto:11

WORKDIR /var/www/java

COPY MultiThreadedApp.java /var/www/java

# Compile
RUN javac MultiThreadedApp.java

# Run
CMD ["java", "MultiThreadedApp"]