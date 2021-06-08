ARG jver="4.13"
ARG hver="2.2"
RUN mkdir -p /java \
	&& wget $WGET_EXTRA_FLAGS -L -O /java/junit.jar "https://search.maven.org/remotecontent?filepath=junit/junit/4.13/junit-${jver}.jar" \
	&& wget $WGET_EXTRA_FLAGS -L -O /java/hamcrest.jar "https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest/${hver}/hamcrest-${hver}.jar"

ENV CLASSPATH=/java/hamcrest.jar:/java/junit.jar
