# JMU UUG `git` Tutorial

## Creating a GitHub account

[GitHub](https://github.com), even with it's flaws, is the primary website for
sharing and uploading your code with `git`. They also have a great
[student pack](https://education.github.com/pack) which gives you all kinds of
great benefits.

## Creating a repository on the GitHub website

Using the + button in the top right corner or the webpage, choose
"New Repository". Pick a name and optionally a description. For this tutorial,
we will not be using a pre-provided README, .gitignore, or license. We may these
at future UUG sessions.

Once you create the repository you will get a page with a bunch of commands
that GitHub wants you to run. Select the HTTPS button towards the top of this
guide, and notice the line starting with `git remote add origin`. You don't need
to do anything with this now. Just keep the page open.

## Starting your first `git` repository

First, we will create a directory to use for this tutorial.

    mkdir -p ~/UUG/git_tutorial && cd $_

If we try to use a git command here, we will get an error

    git commit -am "Test commit"

Notice that you got an error when you tried to do this! You cannot create a
commit in git without that directory being a part of a git repository.

So let's initialize your git repository.

    git init

Now we will use that command from earlier

    git add remote origin https://github.com/YOURUSERNAME/REPONAME.git

This has created a .git folder, with all the information about your
repository.

    ls -a
    ls .git

## Basic `git` configuration

By default, `git` will have your name and email configured to be your login
name@hostname. This is nice in some ways, but probably not your actual
email address. Let's fix this.

    git config --global user.name "Your Name"
    git config --global user.email "your@email.address"

Now `git` will always know who you are, and this information will be in all
your commits.

## Making your first commit

Commits are basically a record of changes to your directory. Each time you
make a change, you need to tell `git` to create a new record. You do this
with the commit command.

Before you commit, you have to make a change to the directory. Let's create
a file

    vim README.txt

Now that we have modified a file, we can ask `git` to tell us the status of
of our directory.

    git status

And if we want `git` to tell exactly what's different, in the file, it can do
that too.

    git diff

Let's tell `git` to create a record of our change

    git commit README.txt

Vim (or your default editor) will open. Type a description of your changes,
called a commit message, and save the file (in Vim, you can type `:wq` in
normal mode).

## See a record of commits

`git` keeps a record of each of your changes in a log. TO see this, let's run

    git log

## Reverting a commit

As you're making changes, you very often will want to undo one of your previous
commits. `git` allows for this with its `revert` command.

Let's modify our directory and commit that change.

    rm README.txt
    git commit -a

Later, we realize that we regret this change. We can undo this. The way that
reverting works in `git` is by taking the state of the repository at a point in
time and bringing it back to the present.

So what we need to do is check our log, and find the hash of the commit we want
to revert

    git log
    git revert "hash"

This will create a commit with the default message, 'Revert "Old Commit"'. Push
this change back to GitHub with

    git push
