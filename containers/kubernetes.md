---
marp: true
---
# Kubernetes
![bg contain right:33%](k8s-logo.png)
## While we get started, go make sure you have a working GitHub account.

---
# A quick recap of containers

---
# What is the right size of a computer?

- We spend a lot of time clustering servers together to solve big problems
- We spend even more time subdividing servers to work on a lot of little problems
- We almost never look at a server and think it's the right size

---
# Bare Metal Servers
![bg contain right:33%](image1.png)

- Let's frame this conversation in terms of four layers
- Resource allocation is very static and often requires a credit card to adjust
- Library versions can conflict between applications

---
# Virtual Machines
![bg contain right:33%](image2.png)

- Traditional subdivision used a hypervisor layer to create fake hardware
  - Foundations of this approach can be traced back to IBM S/370 LPARs in 1972
  - VMware brought it to Intel machines in 1998
- "Guest" operating systems ran largely unmodified
- Resource allocation was static and required a guest reboot to change
- Applications can be isolated from each other

---
# Containers
![bg contain right:33%](image3.png)

- People found themselves running huge numbers of nearly identical Linux machines
- Even for different distros, the kernel was nearly identical
- Namespaces allow the kernel to lie to applications, and believe they're running alone
- Resource allocation under one kernel can be very dynamic

---
# A study of containerization shouldn't be limited to Linux

- FreeBSD introduced "jails" in 2000
- Solaris introduced "zones" in 2004
- Both of these have a much more thorough design, coming from operating systems with much more control of the entire development process
- Windows Subsystem for Linux could be considered a form of container (circa 2016)
  - WSL2 is now virtualized

---
# Linux containers don't really "exist"

- Unlike better designed systems like FreeBSD or Solaris, containers are not a kernel object on Linux
- A Linux container is an illusion created by a tool like docker, that ties together various pieces like namespaces and cgroups
- Without a proper definition of their boundaries, there have been issues with host information leaking into containers or applications escaping their container
- Linux security technologies like SELinux, AppArmor, capabilities, or seccomp help enforce container boundaries
- Research is also underway to wrap containers with hardware virtualization

---
# What are namespaces?

- You've probably only thought of Linux in terms of one global namespace
- All users and programs share one view of the system
- Namespaces can restrict a user or application's view of the system

---
# What namespaces are there?

- Mount - the view of filesystems and directories
- Process ID - the view of running processes and map fake process IDs to real PIDs (PID 1, etc)
- Network - what IP address is in use
- IPC - which message queues and semaphores are in use
- Time - set the system clock
- UTS - the hostname of the system
- User ID - map fake user IDs to real UIDs (root UID 0, etc)

---
# cgroups

- CPU - assign CPU cores and time shares
- Memory - limit RAM allocation
- Network IO - limit network bandwidth
- Disk IO - limit filesystem bandwidth

We've used cgroups here inside systemd unit files to help control uncooperative services.

---
# Enter Docker

- chroot introduced in 1979
- cgroups introduced in 2006
- Mount namespaces in 2002, others in 2006
- Docker launched in 2010, docker in 2013
- One of the first to tie all of these technologies together

---
# How is a container built? Declarative Dockerfile/Containerfile

- Describes the base layer of the container
- Describes the steps used to build the container
- Describes the network requirements of the container
- Sets the binary that will run when the container is launched

---
# And now for Kubernetes
![bg contain right:33%](k8s-logo.png)

---
# Quick refresher on GitOps and CI/CD

- "Continuous integration" - code commits are automatically tested on every commit
- "Continuous delivery" - code that passes tests is automatically installed on servers
- GitOps - the entire state of an application is determined by one or more git repos, allowing automated upgrades and downgrades

---
# Legally required intro for every Kubernetes talk
![bg contain right:33%](k8s-logo.png)

- Kubernetes was born in 2015 from the Borg project within Google
- Abbreviated "k8s" - k, 8 random letters, s
- Greek for "helmsman" - steering wheel logo
- Seven-sided for "7 of 9", the friendly Borg
- Google partnered with the Linux Foundation to form the Cloud Native Compute Foundation (CNCF), to develop and maintain the project

---
# What is Kubernetes?

- Think of it as the kernel of your cloud operating system
- It's a database, a scheduling engine, and a loop that tries to keep everything in compliance with your specifications
- Tons of plugins to manage the details of container lifecycle, disk storage, or network routing/firewalling
- Together these form a kind of "distros", like Amazon EKS, Red Hat OpenShift, or VMware Tanzu.
- Also some lightweight versions like k0s, k3s, minikube, or kind

---
# What isn't Kubernetes?

- git repository
- Continuous integration testing system
- Continuous deployment system
- Some of these might run on your cluster
- Some of these are made by the CNCF and integrate very well

---
# What defines an application?

- Source code and its CPU/memory requirements
- Short and long-term storage
- Network connections

---
# What defines an app?

- Deployments - defines a pod of containers, and the replication and scaling strategy
- Services - creates a load-balancer inside a cluster to contact selected pods
- Ingress - maps the outside world to a service

---
# Deployments

- DaemonSet - run exactly one copy of a pod on every host in the cluster
  - Example - monitoring and statistics agent
- ReplicaSet - run one or more copies of a stateless application
  - Probably your typical web app
- StatefulSet - run exactly one copy of a pod with persistent storage
  - Example - database server
  - Can also enforce ordered startup for things like primary/replica databases

---
# Why Kubernetes?

- Kubernetes manages a cluster of servers and a distributed key-value database (etcd)
- It accepts requests to deploy containers
- It tracks resource consumption, and intelligently places containers
- It monitors container health, and restarts failed containers
- It load balances requests across replicas of a container
- It gradually upgrades containers when a new version is deployed

---
# Demo time

- Go to github.com/ripleymj/bird-flock
- Fork & clone a copy for yourself
- Go to Actions -> Build Bird App and hit Run Workflow
- Inspect the workflow result

---
## Workflow steps

- Jinja templates run and are lint tested
- The backend API container is built and archived
- The archived container is retrieved, launched, and tested
- Repeat for the front-end
- If the tests pass, the containers are published and the new templated k8s files are pushed to your repo

---
# Argo - step 1

- Go to argocd.jmunixusers.org and log in
- Log in with uuguser# / uugpass#

---
# Argo - step 2

- Add a new app
- Give it a name, all lower case
- Make the project name your Argo username
- Scroll down to source

---
## Source

- Set the repository URL to your GitHub repo fork (do not use ripleymj)
- Make the path `k8s/`

## Destination

- For cluster URL, choose the ondigitalocean.com address
- Use your Argo username as the namespace

---
# Argo - step 3

- Hit Create at the top to save your app
- Argo will immediately recognize the app hasn't been deployed and is out of sync with git
- Click on the app to open the deployment map before hitting Sync
- When the deployment completes, go learn about birds at
 <http://YOUR-GITHUB-NAME.cluster.jmunixusers.org>

---
# Go crazy!

- Make some change, like:
  - Add new birds to `back-end/birds.json`
  - Add some better CSS to `front-end/src/`
  - Increase replicas in `templates/deployment*`
- Git pull, commit, push
- Let the workflow run, then watch Argo redeploy
