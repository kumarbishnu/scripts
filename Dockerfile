FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y curl unzip libaio1 && \
    curl -L https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip -o /tmp/instantclient-basic-linux.zip && \
    curl -L https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-sqlplus-linux.x64-19.3.0.0.0dbru.zip -o /tmp/instantclient-sqlplus-linux.zip && \
    unzip /tmp/instantclient-basic-linux.zip -d /usr/local/ && \
    unzip /tmp/instantclient-sqlplus-linux.zip -d /usr/local/ && \
    if [ ! -f /usr/local/instantclient_19_3/sqlplus ]; then \
      echo "Error: SQLplus executable not found."; \
      exit 1; \
    fi && \
    ln -s /usr/local/instantclient_19_3/sqlplus /usr/bin/sqlplus && \
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/instantclient_19_3' >> /etc/bash.bashrc && \
    echo 'export PATH=$PATH:/usr/local/instantclient_19_3' >> /etc/bash.bashrc && \
    apt-get remove -y curl unzip && \
    apt-get autoremove -y && \
    apt-get clean

USER jenkins
