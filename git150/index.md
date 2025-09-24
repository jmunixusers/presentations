---
marp: true
---
# Git 101 - Warmup

![bg 60% right](welcome.png)
Take a moment to create a GitHub account, or verify your password.

Please post your username in Discord (UUG welcome over there --> ) so we can get a little social network going.

Follow me @ripleymj.

---
# What is git?

- Git is a distributed version control system
- Git was started by Linus Torvalds out of frustration with existing systems
- Theories on git’s naming origin vary widely

---
# What is version control?

- A system for tracking changes to files
- A system for tracking the author of changes
- A system for coordinating changes

---
# "Distributed"?

- Everyone has a complete copy of the repository
- Any change can be made to the repository copy
- Changes can be synchronized between copies
- Repository synchronization requires both sides to agree on the __exact__
series of events in their history
  - There are __NO__ exceptions to this rule
- Branch-merge strategy allows private changes that can later be merged into
a common history in an orderly manner

---
# What’s the alternative?

- Centralized systems like Subversion are also available
- Repositories are cached locally, but are not authoritative copies
- Committing requires a connection to the central repository
- Much less flexibility, but much less chance of disagreement

---
# So what about GitHub?

- A social network for git users
- A place to keep a backup repository copy
- A means to exchange changes between people
- A database of issues
- A database of change requests, comments, and approvals
- An API for running events on repository changes

---
# So what about GitHub?

- Remember that git is a tool, and GitHub is a provider of git services
- Other services:
  - GitLab
  - Bitbucket
  - Azure Repos, AWS CodeCommit, Google Cloud Source
- Other git implementations:
  - Eclipse EGit
  - GitHub Desktop
  - Git Bash (ok, so it's just a port)
- Git functionality heavily integrated into VS Code
- A [student pack](https://education.github.com/pack) is available

---
# What is git?

- Git stores a series of changes to files and attributes of that change
  - File diff, author, timestamp, previous change hash
- Change and attributes are hashed together to uniquely identify a commit
- Branches allow different authors to pursue different paths
  - Like an actual tree, branches can go their own way, but the trunk must be shared
- Never delete a commit: use a revert to undo, but that change is then logged
- Some leeway to rewrite history if your changes haven't been pushed and become
visible to others, or working on a private branch

---
# Branch naming

- Git-based projects have a primary branch, often `main` or `dev`
- You can develop new code on different branches, with the goal of integrating
that code back into the primary branch
- Older repos may use a `master` branch, but please don't for new projects

---
# Help along the way

- Git uses man pages extensively to document its options and features
- One man page would be too much for all of git, so pages are hyphenated with
the git-command. For example:
  - `git commit` uses `git-commit(1)`
  - `git push` uses `git-push(1)`
- The `git(1)` man page exists to document the common options and provide an overview

---
# Demo Time

We'll work through some git basics with a partner. Player 1 should be the person with less git experience, and player 2 the more experienced.

---
# All: Understanding GitHub security

GitHub does not allow plain password use from the command line

1. Are you on a computer you frequently use?
    - Yes? Use SSH keys
    - No? ssh to stu, use SSH keys
    - No? Generate a disposable personal token

2. Do you already have SSH keys? `ls -l $HOME/.ssh` and look for id files
    - Yes? Cool!
    - No? Time to generate some

---
# All: Generating SSH keys

- You may already have a key on your laptop from last week's meeting, but may also want one on stu to connect to GitHub
- `ssh-keygen -t ed25519 -C "your_email@example.com"`
- Since you don't already have keys, accept the default file name - `.ssh/id_ed25519`
- Password is optional depending how much you trust the computer's security.
You'll be prompted for this password every time you use the key.

---
# All: Uploading SSH keys

- Cat your public key, either `.ssh/id_ed25519.pub` or `.ssh/id_rsa.pub`
- Do not accidentally give away your private key non-.pub file
- Top-right menu -> Settings
- SSH and GPG keys
- New Key, give it a name, and paste your pub file contents

---
# All: Basic `git` configuration

By default, `git` will have your name and email configured to be your login
name@hostname. This is nice in some ways, but probably not your actual
email address. Let's fix this. Make sure you substitute all of your own info
in the following commands:

    git config --global user.name "Your Name"
    git config --global user.email "your@email.address"

Now `git` will always know who you are, and this information will be in all
your commits.

---
# P1: Starting your first `git` repository

First, we will create a directory to use for this tutorial.

    mkdir -p ~/UUG/uug-git-intro && cd $_

If we try to use a git command here, we will get an error:

    git commit -am "Test commit"

Notice that you got an error when you tried to do this! You cannot create a
commit in git without that directory being a part of a git repository.

---
# P1: Starting your first `git` repository

Let's initialize your repository.

    git init

If you run `ls -al`, you will now see a `.git` directory there. This is where
git stores all of the data about your repository. Do not go in here and make
changes without really knowing what you're doing.

---
# P1: Making your first commit

Commits are basically a record of changes to your directory. Each time you
make a change, you need to tell `git` to create a new record. You do this
with the commit command.

Before you commit, you have to make a change to the directory. Let's create
a file:

    nano README.txt

---
# P1: Making your first commit

Now that we have created a file, we can ask `git` to tell us the status of
of our directory.

    git status

Normally `git` can tell exactly what's different in the file.

    git diff

But that only works against the last commit, so it will not show our README.

---
# P1: Making your first commit

We should instruct `git` to start tracking changes to our README.txt file. We
also need to add it to our 'stage'. To do this, we will use the following command.

    git add README.txt

Let's tell `git` to create a record of our change

    git commit

Vim (or your default editor) will open. Type a description of your changes,
called a commit message, and save the file (in Vim, you can type `:wq` in
normal mode).

---
# P1: See a record of commits

`git` keeps a record of each of your changes in a log. To see this:

    git log

---
# P1: Changing branch name

`git log` should show that git has automatically chosen the name `master` for your
primary branch. Let's change that now.

    git branch -M main

---
# All: About GitHub URLs

When connecting your local repository to GitHub, there are two types of URLs you can use.

- If using ssh keys, use `git@github.com` URLs
- If using a token, use `https://github.com` URLs

This should make more sense in a few minutes. If you change your mind in the future, you can update URLs with `git remote set-url`.

---
# P1: Creating a repository on the GitHub website

Using the + button in the top right corner of the webpage, choose
"New Repository". Pick a name and optionally a description. For this tutorial, we will not be using a pre-provided README, .gitignore, or license.

Once you've created the repository, select the HTTPS or SSH button towards the top of this guide, and notice the section for `push an existing repository`.

---
# P1: Starting your first `git` repository

You now have to tell `git` where your code should be pushed to. We are using
GitHub for this. Run the following command, but change `YOURUSERNAME` to your

    git remote add origin git@github.com:YOURUSERNAME/REPONAME.git

Remember later that you have named your GitHub URL `origin`.

---
# P1: Synchronizing GitHub

The first time you push to an upstream copy, you can use the `-u` option to tell
git your preferred default.

    git push -u origin main

This will tell git to push your current branch `main` (since you just renamed it)
to the `main` branch at the `origin` URL, and to remember that for future use. Now
that you've set the default, you can simply use:

    git push

Go check GitHub now to confirm your changes were uploaded.

---
# P1: Inviting a GitHub friend

- Go to your GitHub repository settings, and find the Collaborators page
- Invite your partner, and have them accept the invitation

---
# P2: Cloning a repository

- Player 2 will now need to copy the repository to their laptop/stu
- Run `git clone git@github.com:PLAYER1/REPOSITORY.git`
- `cd` into the repository directory

---
# P2: Making a bad change

Let's modify our directory and commit that change.

    git rm README.txt
    git commit
    git push -u origin main

---
# P1: Reverting a commit

Player 1 runs `git pull` and sees this terrible change and wants to undo this. Git can take the state of the repository at a point in time and bringing it back to the present.

So what we need to do is check our log, and find the hash of the commit we want to revert. Use the following command (replacing the hash):

    git log
    git revert "hash"

This will create a commit with the default message, 'Revert "Old Commit"'.
Do not push yet.

---
# P2: Keeps working and pushes another change

    nano BetterReadme.txt
    git add BetterReadme.txt
    git commit
    git push

---
# P1: Push, with conflicts

- Player 1 now tries to run `git push` to sync their changes to GitHub
- GitHub will reject this push because there is a disagreement about what comes after README was deleted
  - Player 1 reverted the change
  - Player 2 created a new file
- Since there is no conflict between these changes, run `git pull --rebase` to layer the GitHub changes underneath your own
- Check `git log` to see the change sequence
- Run `git push` and GitHub should now accept your changes because the sequence is consistent

---
# All: Time permitting, create and resolve a merge conflict

---
# gitignore

- While git CAN contain binary files (like images in a presentation),
tradition says it SHOULD NOT contain binaries that are artifacts of source files
  - Commit your C or Java files, not executables, `.o`, or `.class` files
- A `.gitignore` file will tell git about file extensions or folders you don't want
- You always choose which files to commit, but `.gitignore` will prevent accidentally
committing files you don't want

---
# A note about danger

- As you work with git, you're going to experience challenges merging and resolving history
- Too many people's first instinct is to delete the git directory and clone again from GitHub
- Git is quietly saving all of your mistakes locally, but will only push them to GitHub if they're part of the branch you're working on
- If you run into trouble, ask for help. Lots of things can be repaired, and will likely teach you about preventing problems in the future

---
# More fun with GitHub

- Follow friends and inspirational developers
- Star projects either as bookmarks or upvotes
- Publish with GitHub Pages, even with your own custom domain
- Create a repo called your username to put a homepage README
- Create a repo called username.github.io as your personal GH Pages home
- Create an Action to automatically run a process for events like push or merge
- Use wikis for project documentation
- Create Kanban boards for project management
- Use gists to save or share text

---
# Going futher

For a `git` reference, check out GitHub's
[Git cheat sheet](https://training.github.com/downloads/github-git-cheat-sheet/) or
[Git cheat sheet for education](https://education.github.com/git-cheat-sheet-education.pdf)
