#!/bin/bash

export MYSQL_CONTAINER_NAME="mysql-test-container"
export MYSQL_ROOT_PASSWORD="root_password"
export DB_NAME="test_db"
export DB_USER="test_user"
export DB_PASSWORD="test_password"
export DB_PORT="3306"
export DB_HOST="localhost"

export API_KEY="test"
export HOST="localhost"
export PORT="8000"

start_mysql() {
  if docker ps -a --format '{{.Names}}' | grep -wq "$MYSQL_CONTAINER_NAME"; then
    echo "Container $MYSQL_CONTAINER_NAME already exists. Starting it..."
    docker start "$MYSQL_CONTAINER_NAME"
  else
    echo "Container $MYSQL_CONTAINER_NAME does not exist. Creating and starting it..."
    docker run --name "$MYSQL_CONTAINER_NAME" -d \
      -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
      -e MYSQL_DATABASE="$DB_NAME" \
      -e MYSQL_USER="$DB_USER" \
      -e MYSQL_PASSWORD="$DB_PASSWORD" \
      -p "$DB_PORT:$DB_PORT" \
      -v "$(pwd)/db/data/init.sql.local:/docker-entrypoint-initdb.d/init.sql" \
      -v "$(pwd)/.local-secrets:/secrets" \
      mysql:latest
  fi
}

wait_mysql() {
  echo "Waiting for MySQL to be ready..."
  until docker exec "$MYSQL_CONTAINER_NAME" mysqladmin ping -h "localhost" --silent; do
    echo "Waiting for MySQL..."
    sleep 3
  done
  echo "MySQL is ready."
}

run_tests() {
  echo "Running tests..."
  echo "$DB_PASSWORD" > ./.local-secrets/db-password-temp

  npm i
  npm run build

  DB_PASS="./.local-secrets/db-password-temp" \
    npm run start > /dev/null 2>&1 &

  until nc -z localhost 8000; do
    echo "Waiting for server to be ready..."
    sleep 2
  done

  echo "Server is ready. Running tests..."
  DB_PASS="./.local-secrets/db-password-temp" npm test
}

clean() {
  if docker ps -a | grep -q "$MYSQL_CONTAINER_NAME"; then
    echo "Stopping MySQL container..."
    docker stop "$MYSQL_CONTAINER_NAME"
    docker rm "$MYSQL_CONTAINER_NAME"
    echo "MySQL container stopped and removed."
  else
    echo "MySQL container is not running."
  fi
}

stop() {
  if docker ps -a | grep -q "$MYSQL_CONTAINER_NAME"; then
    echo "Stopping MySQL container..."
    docker stop "$MYSQL_CONTAINER_NAME"
    echo "MySQL container stopped."
  else
    echo "MySQL container is not running."
  fi
}

case "$1" in
  clean)
    clean
    ;;
  help)
    echo "Usage: $0 [clean|help]"
    echo "clean: Stop and remove MySQL container."
    echo "help: Show this help message."
    echo "No command: run tests and stops MySQL container."
    ;;
  *)
    echo "No valid command provided, running default for testing..."
    start_mysql
    wait_mysql
    run_tests
    stop
esac
