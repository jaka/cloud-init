## Task 7: Three mysql docker containers in master-slave replication

First, install Docker:
```
sudo puppet apply ../task6/docker.pp
```
Next install Docker Compose:
```
sudo apt-get -y install python-pip
sudo pip install docker-compose
```
Create jaka/mysql docker image:
```
sudo docker build -t jaka/mysql .
```
And then start one master and two slaves by issuing:
```
sudo docker-compose up
```
Check slaves (requires ```sudo apt-get install mysql-client```):
```
mysql -uadmin -pmypass -h127.0.0.1 -P3306 -e "SHOW SLAVE HOSTS;"
