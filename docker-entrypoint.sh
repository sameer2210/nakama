#!/bin/sh
set -eu

if [ -n "${DATABASE_ADDRESS:-}" ]; then
  DB_ADDR="$DATABASE_ADDRESS"
elif [ -n "${DATABASE_URL:-}" ]; then
  DB_ADDR="$DATABASE_URL"
elif [ -n "${POSTGRES_URL:-}" ]; then
  DB_ADDR="$POSTGRES_URL"
elif [ -n "${PGHOST:-}" ] && [ -n "${PGUSER:-}" ] && [ -n "${PGPASSWORD:-}" ] && [ -n "${PGDATABASE:-}" ]; then
  DB_ADDR="${PGUSER}:${PGPASSWORD}@${PGHOST}:${PGPORT:-5432}/${PGDATABASE}"
elif [ -n "${RAILWAY_ENVIRONMENT:-}" ]; then
  echo "Missing database config on Railway. Set DATABASE_ADDRESS or reference Postgres PG* vars into this service." >&2
  exit 1
else
  DB_ADDR="postgres:localdb@postgres:5432/nakama"
fi

SOCKET_PORT="${PORT:-7350}"

/nakama/nakama migrate up --database.address "$DB_ADDR"
exec /nakama/nakama \
  --name nakama1 \
  --database.address "$DB_ADDR" \
  --socket.port "$SOCKET_PORT" \
  --runtime.path /nakama/data/modules \
  --logger.level INFO
