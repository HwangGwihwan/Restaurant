FROM openjdk:21
ARG VERSION
COPY target/restaurant-0.0.1-SNAPSHOT.jar /app/restaurant.jar
LABEL maintainer="YuTaek Kim<sunnykid7@gmail.com>" \
	title="Guestbook App" \
	version="$VERSON" \
	description="This image is guestbook service"
	ENV APP_HOME /app
EXPOSE 80
VOLUME /app/upload
WORKDIR $APP_HOME
ENTRYPOINT ["java"]
CMD ["-jar","restaurant.jar"]
