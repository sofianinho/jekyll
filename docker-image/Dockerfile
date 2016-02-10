FROM ruby:2.3

ADD entrypoint.sh /
VOLUME /mnt

RUN ruby -S gem install jekyll therubyracer 

USER jekyll
EXPOSE 4000
CMD ["/bin/bash", "entrypoint.sh"]
