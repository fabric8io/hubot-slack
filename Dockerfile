FROM fabric8/hubot-base:latest

MAINTAINER fabric8.io <fabric8@googlegroups.com>

RUN yo hubot --owner="fabric8.io <fabric8@googlegroups.com>" --name="fabric8" --description="Platform manager" --adapter=slack --defaults

CMD bin/hubot -a slack
