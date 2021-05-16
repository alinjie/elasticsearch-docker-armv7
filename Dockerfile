FROM arm32v7/openjdk:11-jdk

# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199#23
RUN apt update && apt install wget -y
RUN wget -O /tmp/elasticsearch.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.12.1-no-jdk-linux-x86_64.tar.gz
RUN mkdir /usr/share/elasticsearch
RUN tar -xf /tmp/elasticsearch.tar.gz -C /usr/share/elasticsearch --strip-components=1
RUN adduser --disabled-password --gecos '' elastic
RUN chown -R elastic:root /usr/share/elasticsearch && chmod -R 777 /usr/share/elasticsearch
USER elastic
ENV ES_JAVA_HOME=${JAVA_HOME}
EXPOSE 9200 9300
CMD [ "bash", "/usr/share/elasticsearch/bin/elasticsearch" ]