FROM fedora:21

MAINTAINER fabric8.io <fabric8@googlegroups.com>

RUN yum install -y npm git && \
	npm install -g yo generator-hubot coffee-script hubot && \
	yum clean all -y

RUN useradd hubot

RUN mkdir -p /home/hubot
	
WORKDIR /home/hubot

RUN npm install hubot-slack --save

# Add plugins
RUN npm install --save hubot-jenkins-notifier
RUN npm install --save hubot-grafana

RUN chown -R hubot:hubot /home/hubot

USER hubot

RUN yo hubot --owner="fabric8.io <fabric8@googlegroups.com>" --name="fabric8" --description="Platform manager" --adapter=slack --defaults

RUN git clone https://github.com/fabric8io/fabric8-hubot-scripts.git && \
	mv fabric8-hubot-scripts/*.coffee /home/hubot/scripts && \
	rm -rf fabric8-hubot-scripts

ADD external-scripts.json ./external-scripts.json
WORKDIR /home/hubot

CMD bin/hubot -a slack


