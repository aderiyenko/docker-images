FROM postgres:9.6
RUN apt-get update && apt-get install postgis -y

COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
