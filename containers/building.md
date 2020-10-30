---
marp: true
---
# Building Containers

---
# Getting started

- Go to w3.cs.jmu.edu/uug
- Download `fedora-docker.ova` and import to VirtualBox
  - Username: uuguser
  - Password: uugpassword
- Follow along at jmunixusers.org/presentations

---
# Terminology and commands

- Try running the list commands
- Image
  - `docker images` - list images
  - `docker rmi` - delete image
- Container
  - `docker ps` - list running containers
  - `docker ps -a` - list all containers
  - `docker rm` - delete container

---
# Docker Hello World

- `docker run hello-world`
- `docker ps -a`
- `docker images`

# Clean up

- `docker rm ID` - from output of `docker ps -a`
- `docker rmi ID` - from output of `docker images`

---
# Run some Ubuntu

- `docker run -it ubuntu:18.04 /bin/bash`
  - Notice docker pulling image files as needed
  - `cat /etc/os-release`
  - `exit`
- `docker pull ubuntu:19.10`
- `docker run -it ubuntu:19.10 /bin/bash`
  - Notice the instant launch, since we downloaded first
  - `cat /etc/os-release`
  - `exit`

---
# Inspect and clean up some Ubuntu

- `docker images`
- `docker ps -a`
- `docker rm ID` - dead/exited containers
- `docker inspect ubuntu:19.10`
  - Nothing particularly interesting in the Ubuntu container, but a handy tool as you progress

---
# Let's actually do some work in a container

- `docker pull httpd:latest`
- `docker run -dit -p 8080:80 httpd:latest`
  - `-i` - keep stdin open
  - `-t` - allocate a pseudo-terminal
  - `-d` - detach the container into the background
  - `-p` - map a local port into the container
- Open Firefox and browse <http://localhost:8080>

---
# What can we learn about this container?

- `docker ps` - shows us a running container for the first time
  - Container's hash ID
  - Image source
  - Launch command
  - Runtime
  - Port mappings
  - Nickname
- `docker logs ID` - show recent stdout
- `docker kill ID` - end the container
- Clean up with `docker ps -a` and `docker rm`

---
# Let's build our own

- `mkdir container1; cd container1`
- `vi index.html`

```html
<h1>I made a container at UUG</h1>
```

- `vi Dockerfile`

```dockerfil
FROM httpd:2.4
COPY index.html /usr/local/apache2/htdocs/
```

- `docker build -t my-apache2:1.0 .`
- `docker images`
- `docker run -dit --name my-app -p 8080:80 my-apache2:1.0`
- Open <http://localhost:8080> in Firefox

---
# A slightly more advanced example

- `sudo dnf install docker-compose`
- `git clone https://github.com/ChloeCodesThings/chloe_flask_docker_demo`
- `cd chloe_flask_docker_demo`
- `docker-compose up`
- More information: <https://codefresh.io/docker-tutorial/hello-whale-getting-started-docker-flask/>

---
# A quick buildah example

```bash
container=$(sudo buildah from ubuntu:19.10)
mountpoint=$(sudo buildah mount ${container})
echo $mountpoint

sudo cat ${mountpoint}/etc/os-release
sudo ls ${mountpoint}
bin   dev  home  lib64          media  opt   root  sbin  sys  usr
boot  etc  lib   lost+found  mnt        proc  run   srv   tmp  var
```

```bash
sudo buildah unmount $container
sudo buildah delete $container
```
