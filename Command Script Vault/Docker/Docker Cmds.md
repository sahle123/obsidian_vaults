#cmds
## Getting PID of a container
	docker inspect -f {{.State.Pid}} <container ID>>
## Get container info
	docker container top CONTAINER
## Get local IP address for some docker container
	docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id

## Stop all docker containers
	docker stop $(docker ps -aq)

## Remove all docker containers
	docker rm $(docker ps -aq)

## Run custom compose file
	docker-compose -f .\docker-compose.custom.yml up

## View all containers that are 'exited'
	docker ps -f "status=exited" -q