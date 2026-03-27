FROM registry.heroiclabs.com/heroiclabs/nakama:3.21.1

COPY modules/ /nakama/data/modules/
COPY docker-entrypoint.sh /nakama/docker-entrypoint.sh
RUN chmod +x /nakama/docker-entrypoint.sh

EXPOSE 7349 7350 7351

ENTRYPOINT ["/nakama/docker-entrypoint.sh"]
