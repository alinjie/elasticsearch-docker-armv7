FROM openjdk:16-slim
ENV ES_JAVA_HOME=${JAVA_HOME}
RUN apt update && apt install wget curl -y
RUN wget -O /tmp/elasticsearch.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.12.1-no-jdk-linux-x86_64.tar.gz
RUN tar -xf /tmp/elasticsearch.tar.gz
RUN adduser --disabled-password --gecos '' elastic
RUN chown -R elastic:root /elasticsearch-7.12.1 && chmod -R 777 /elasticsearch-7.12.1
USER elastic
EXPOSE 9200 9300
CMD [ "bash", "/elasticsearch-7.12.1/bin/elasticsearch" ]