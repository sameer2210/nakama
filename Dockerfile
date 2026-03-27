FROM registry.heroiclabs.com/heroiclabs/nakama:3.21.1

COPY modules/ /nakama/data/modules/

EXPOSE 7349 7350 7351

ENTRYPOINT ["/bin/sh", "-ec", "DB_ADDR=\"${DATABASE_ADDRESS:-${DATABASE_URL:-postgres:localdb@postgres:5432/nakama}}\"; /nakama/nakama migrate up --database.address \"$DB_ADDR\" && exec /nakama/nakama --name nakama1 --database.address \"$DB_ADDR\" --runtime.path /nakama/data/modules --logger.level INFO"]
