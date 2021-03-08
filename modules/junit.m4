ARG jver="4.13"
WORKDIR /java
RUN wget $WGET_EXTRA_FLAGS -L -O junit.jar "https://search.maven.org/remotecontent?filepath=junit/junit/4.13/junit-${jver}.jar"

ARG hver="2.2"
WORKDIR /java
RUN wget $WGET_EXTRA_FLAGS -L -O hamcrest.jar https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest/${hver}/hamcrest-${hver}.jar

ENV CLASSPATH=/java/hamcrest.jar:/java/junit.jar

