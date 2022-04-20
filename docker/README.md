# Docker
| Command | Desc  |
| --      | --    |
| `docker run -ti --name container_name image_name /command`  | Run a shell command inside a freshly created and started container. |
| `docker run --rm -ti image_name /command` | Run a command inside a container from the image and remove the container when command is done. |
| `docker exec -ti container_name "cmd"`  | Run a shell command in the container. |
| `docker exec -ti container_name /bin/bash`  | Jump into a running container to poke around. |
| `docker logs -ft container_name`  | Show/follow log output of the container. |
| `docker kill $(docker ps -q)` | Kill all runnning docker containers. |
| `docker image prune` | Delete dangling Docker images. |
| `docker image prune --all` | Remove all images without at least one container associated to them. |
| `docker container prune`  | Remove all stopped containers. |
| `docker system prune` | Remove all stopped containers, all unused networks, all dangling images, all dangling build cache |
| `docker system prune --all` | Same as `system prune` but also any images not associated |
| `docker builder prune` | Remove all dangling build cache |
| `docker builder prune --all` | Remove all build cache |
| `docker volume prune` | Remove all local volumes not used by at least one container |


## Debugging

### Open Sockets inside a running container
Run netstat from the underlying host using nsenter to get open socket connections (requires netstat to be installed on 
the host):

```
sudo nsenter -t $(docker inspect -f '{{.State.Pid}}' container_name_or_id) -n netstat
```