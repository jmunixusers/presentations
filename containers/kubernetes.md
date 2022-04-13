---
marp: true
---
# Kubernetes
![bg contain right:33%](k8s-logo.png)
## While we get started, go make sure you have a working GitHub account.

---
# How did we get here?

- Two weeks ago, we talked about containers in general and how they allow encapsulation of an application
- Last week, we built some web apps
- Tonight we'll look at how Kubernetes allows us to automate cloud application deployments

---
# What is GitOps and CI/CD?

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
- Google partnered with the Linux Foundation to form the Cloud Native Compute Foundation, to development and maintain the project

---
# What is Kubernetes?

- Think of it as the kernel of your cloud operating system
- It's a database, a scheduling engine, and a loop that tries to keep everything in compliance with your specifications
- Tons of plugins to manage the details of container lifecycle, disk storage, or network routing/firewalling
- Together these form a kind of "distros", like Amazon EKS, Red Hat OpenShift, or VMware Tanzu.

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
# Argo - step 1

- Go to argocd.jmunixusers.org and log in
- Add a new app
- Give it a name, all lower case
- Make the project name your Argo username

---
# Argo - step 2

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
