docker-compose down
sudo rm -rf data
docker volume prune
docker image prune
docker container prune
docker network prune
