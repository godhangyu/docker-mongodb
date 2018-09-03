
ARG IMAGE_ARG_IMAGE_TAG

FROM mongo:${IMAGE_ARG_IMAGE_TAG:-3.2.17} as base

# see https://github.com/docker-library/mongo/blob/master/3.2/Dockerfile

FROM scratch

COPY --from=base / /

RUN set -ex \
  && mkdir -p /data/db /data/configdb \
  && usermod -u 1000  mongodb \
  && groupmod -g 1000 mongodb \
  && chown -hR mongodb:mongodb /data \
  && cat /etc/passwd

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 27017
CMD ["mongod"]
