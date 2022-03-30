#!/usr/bin/env bash

# Create a container
container=$(buildah from ubuntu:20.04)

buildah config --env DEBIAN_FRONTEND=noninteractive $container

echo ---Running apt-get update---
buildah run $container -- /usr/bin/apt-get update

echo ---Running apt-get install curl---
buildah run $container -- /usr/bin/apt-get -y -qq install curl

echo ---Running curl---
buildah run $container -- sh -c '/usr/bin/curl -fsSL https://deb.nodesource.com/setup_16.x | /bin/bash -l -'

echo ---Running apt-get install nodejs---
buildah run $container -- /usr/bin/apt-get install -y nodejs

echo ---Running npx create---
buildah run $container -- /usr/bin/npx -y create-react-app my-app

echo ---Copying js files---
buildah copy $container *js my-app/src/

echo ---Setting working dir---
buildah config --workingdir "/my-app" $container

echo ---Setting config---
buildah config --cmd "/usr/bin/npm start" $container
buildah config --port 3000 $container

buildah commit $container react-hello-world:latest
buildah rm $container 