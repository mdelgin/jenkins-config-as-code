#FROM jenkinsci/jenkins
#ROM cloudbees/cloudbees-jenkins-team:2.107.2.1
FROM cloudbees/cje-mm:2.107.2.1

LABEL maintainer "melgin@cloudbees.com"

USER root

# add config file to jenkins_home
COPY jenkins.yaml /usr/share/jenkins/ref/

# add environment variable to point to configuration file
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/jenkins.yaml

# copy Jenkins Configuration as Code plugin to plugins folder
#ADD http://updates.jenkins-ci.org/download/plugins/configuration-as-code/0.5-alpha/configuration-as-code.hpi /var/jenkins_home/plugins/

# Install plugin(s) that are not bundled by default
ENV JENKINS_UC https://updates.jenkins.io/experimental/update-center.json
ADD https://raw.githubusercontent.com/jenkinsci/docker/master/install-plugins.sh /usr/local/bin/install-plugins.sh
RUN chmod +x /usr/local/bin/install-plugins.sh
ADD https://raw.githubusercontent.com/jenkinsci/docker/master/jenkins-support /usr/local/bin/jenkins-support
RUN chmod +x /usr/local/bin/jenkins-support
RUN /usr/local/bin/install-plugins.sh configuration-as-code workflow-multibranch:2.9.2 git github-branch-source pipeline-model-definition
