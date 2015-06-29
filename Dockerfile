FROM java:7

# Install maven
RUN apt-get update -qq && \
    apt-get upgrade -y -q && \
    apt-get install -y -q maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# download and build GATK from current master
RUN git clone https://github.com/broadgsa/gatk-protected.git
WORKDIR /gatk-protected/
RUN ["mvn", "verify"]

ENTRYPOINT ["/usr/lib/jvm/java-7-openjdk-amd64/bin/java", "-jar", "target/GenomeAnalysisTK.jar"]
