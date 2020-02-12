---
marp: true
---
# Kubernetes
![bg contain right:33%](k8s-logo.png)
## While we get started, go make sure you have a working GitHub account.

## Accept an invitation to collaborate on the "k8sdemo" repo, but don't do anything else.

---
# How did we get here?
- Two weeks ago, we talked about containers in general and how they allow encapsulation of an application
- Last week, we did some samples of building a Docker web application on laptops
- Tonight we'll look at how Kubernetes allows us to automate cloud application deployments

---
# Why Kubernetes?
- Kubernetes manages a cluster of servers
- It accepts requests to deploy containers
- It tracks resource consumption, and intelligently places containers
- It monitors container health, and restarts failed containers
- It load balances requests across replicas of a container
- It gradually upgrades containers when a new version is deployed

---
# Tonights demo - full disclosure
This demo was mostly stolen, but ~~ruined~~ modified to work with a group. The original is available here: <https://cloud.google.com/kubernetes-engine/docs/tutorials/gitops-cloud-build>

There are many Kubernetes examples available, but they require several accounts from different providers, or having admin credentials to a cluster.

---
# Demo logistics
- You should receive and accept an invitation to collaborate on the `k8sdemo` repository
- Clone the repository to your computer. **DO NOT FORK AND CLONE TONIGHT**
  - `git clone https://github.com/ripleymj/k8sdemo`
  - `cd k8sdemo`
- Check out the demo branch
  - `git checkout demo`
- Create a personal branch with `uug-YOURNAME`
  - `git checkout -b uug-ripleymj`
- Wait here for everyone to catch up

---
# Deployment time
- Push your branch back to GitHub
  - `git push origin uug-YOURNAME`
- Let's watch the magic happen

---
# What just happened?!?
- Google Cloud has a trigger watching the repository for any branch name `uug-*`
- The trigger will attempt to run a `cloudbuild.yaml` file in the repository
- Cloud Build will run `test_app.py` to verify your `app.py` application
- If the tests pass, the Dockerfile is used to build a container
- If the Dockerfile builds, a `kubernetes.yaml` file is generated from a template to describe your new deployment
- Cloud Build commits the deployment file to a 2nd repository to start another trigger

---
# Let's make some changes
- Edit your `kubernetes.yaml.tpl` and change replicas to 3
- Add, commit, and push your changes
- Watch the cluster adjust when it re-deploys

---
# Now make some changes to your site
- Add, commit, push again
- Watch Kubernetes do a gradual deployment