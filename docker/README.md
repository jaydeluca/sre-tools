# Docker
| Command | Desc  |
| --      | --    |
| `docker run -ti --name container_name image_name /command`  | Run a shell command inside a freshly created and started container. |
| `docker run --rm -ti image_name /command` | Run a command inside a container from the image and remove the container when command is done.  |
| `docker exec -ti container_name "cmd"`  | Run a shell command in the container.	|
| `docker logs -ft container_name`  | Show/follow log output of the container.  |
| `docker kill $(docker ps -q)` | Kill all runnning docker containers.	 |
| `docker rmi $(docker images -q -f dangling=true)` | Delete dangling Docker images.  |
| `docker rm $(docker ps -a -q)`  | Remove all stopped containers.	|