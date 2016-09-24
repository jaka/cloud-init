## Task 8: PHP application

Requires installed Docker, Docker Compose, jaka/mysql docker image from Task 7 and ```mysql-client``` package.

First, create jaka/web docker image:
```
sudo docker build -t jaka/web .
```
Start servers:
```
sudo docker-compose up
```
In another console, populate database:
```
./prepare_db.sh
```
And fetch the result:
```
wget -q http://127.0.0.1/index.php -O -
```
