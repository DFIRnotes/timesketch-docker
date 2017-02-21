timesketch-docker
=================

This project contains a Dockerfile, entrypoint script and docker-compose configuration file that will
build out a cluster of containers with the necessary parts to run timesketch.

https://github.com/google/timesketch/wiki/Installation

Requirements
------------

Docker ships with everything needed. I've been testing on 14.04 and 16.04 host systems.

Build
-----
```
$ git clone https://github.com/nickryand/timesketch-docker.git
$ cd timesketch-docker
$ docker-compose up
```

Usage
-----

### Webapp
The Timesketch app should be available at the IP of the `docker-vm` on port 5000. To get the UP address, echo
the `$DOCKER_HOST` environment variable.

Browse to: `http://<ip of docker-vm>:5000`

### Add Users

To add users, you exec the `tsctl` commands inside the timesketch docker container. 
```
$ docker ps
CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS                    NAMES
7bed6615388f        timesketchdocker_timesketch   "/bin/bash /entrypoin"   58 minutes ago      Up 58 minutes       0.0.0.0:5000->5000/tcp   timesketchdocker_timesketch_1
6d9f223f9099        redis                         "docker-entrypoint.sh"   58 minutes ago      Up 58 minutes       6379/tcp                 timesketchdocker_redis_1
7fc70a9d063e        elasticsearch:1.7.5           "/docker-entrypoint.s"   58 minutes ago      Up 58 minutes       9200/tcp, 9300/tcp       timesketchdocker_elasticsearch_1
$ docker exec timesketchdocker_timesketch_1 tsctl add_user --username testuser --password testpass
User testuser created/updated
$
```
You can use the same pattern to run any of the tsctl commands you may need.

Upstream Author
------

Nick Downs <nickryand@gmail.com> put together this project, the Docker configs, and scripts

Timesketch: https://github.com/google/timeskech/
