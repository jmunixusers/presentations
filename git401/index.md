---
marp: true

---
# Advanced git tricks

---
# add patch

- Selectively add parts of a file to make more meaningful commits

---
# bisect

- Sometimes you pull a large number of commits and suddenly find a problem
- git-bisect lets you select a problem commit and a last-known good commit, then binary search for the cause
- Can use an automated test to search for you

<https://git-scm.com/docs/git-bisect>

---
# cherry-pick

- Copy and paste a commit between branches

---
# commit amend

- Change the contents of the last commit or commit message
- Add `--no-edit` to only update the commit contents

---
# gitattributes

- Allows you to change settings by file path/extension
- Force CR or LF
- Binary vs text handling
- Run checkout/commit filters - formatter by source language
- Custom diff tools
- Embed commit ID in files

<https://git-scm.com/docs/gitattributes>

---
# Pretty history

- git log --graph --oneline --all
- git log --pretty=oneline --abbrev-commit
- git shortlog

Also, aliasing:

- git config --global alias.tree "log --oneline --decorate --all --graph"
- git tree

---
# rebase

- Rebasing is your powertool for fixing history
- Simplest form is to just fetch upstream history and layer it under your new commits
  - From last week: `git pull --rebase`
- Interactive rebasing opens a world of crazy possibilities
  - Edit the past five commits: `git rebase -i HEAD~5`

<https://git-scm.com/docs/git-rebase>

---
# reflog

- git remembers all the commits you've checked out
- reflog shows you that history and lets you jump between points in history
- Can be very helpful for repairing damage after failed merges and rebases

<https://git-scm.com/docs/git-reflog>

---
# ssh signing

    git config --global gpg.format ssh
    git config --global user.signingkey ~/.ssh/examplekey.pub
    git commit -S -m "My commit msg"
    git config --global commit.gpgsign true

<https://docs.gitlab.com/user/project/repository/signed_commits/ssh/>

---
# worktrees

- git allows you to store the .git metadata folder outside the working directory
- Worktrees allow you to reuse a git directory, and check out another branch to a parallel directory
- Possibly interesting for compairing code for web apps, where you need both running to see the changes

<https://git-scm.com/docs/git-worktree>
