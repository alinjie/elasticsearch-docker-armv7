FROM arm32v7/openjdk:11-jdk

# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199#23
RUN apt update && apt install wget -y
ENV ES_JAVA_HOME=${JAVA_HOME}
RUN wget -O /tmp/elasticsearch.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.12.1-no-jdk-linux-x86_64.tar.gz
RUN tar -xf /tmp/elasticsearch.tar.gz
RUN adduser --disabled-password --gecos '' elastic
RUN chown -R elastic:root /elasticsearch-7.12.1 && chmod -R 777 /elasticsearch-7.12.1
USER elastic
EXPOSE 9200 9300
CMD [ "bash", "/elasticsearch-7.12.1/bin/elasticsearch" ]