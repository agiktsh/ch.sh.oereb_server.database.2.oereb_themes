docker run \
  --name $CONTAINERNAME \
  -d \
  -p 54321:5432 \
  $IMAGE

# wait until the db is read and is accepting connections
until docker exec $CONTAINERNAME pg_isready; do \
  echo "$CONTAINERNAME was not ready, waiting another cycle"; \
  sleep 5; \
done
