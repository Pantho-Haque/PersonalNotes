# Git Comprehensive Guide

## Table of Contents
- [Local Repository](#local-repository)
  - [Configuration](#configuration)
  - [Initialization](#initialization)
  - [Status & History](#status--history)
  - [Staging Files](#staging-files)
  - [Committing Changes](#committing-changes)
  - [Branching](#branching)
  - [Stashing](#stashing)
  - [Undoing Changes](#undoing-changes)
  - [Viewing Differences](#viewing-differences)
  - [Tagging](#tagging)
- [Remote Repository](#remote-repository)
  - [Managing Remotes](#managing-remotes)
  - [Cloning](#cloning)
  - [Fetching & Pulling](#fetching--pulling)
  - [Pushing](#pushing)
- [Advanced Operations](#advanced-operations)
  - [Rebasing](#rebasing)
  - [Cherry-picking](#cherry-picking)
  - [Cleaning](#cleaning)
  - [Bisect](#bisect)
  - [Submodules](#submodules)
- [Git Workflows](#git-workflows)
- [Interview Questions & Concepts](#interview-questions--concepts)
- [Best Practices](#best-practices)
- [Common Scenarios & Solutions](#common-scenarios--solutions)

---

## Local Repository

### Configuration

```sh
# Global configuration (applies to all repositories)
git config --global user.email "my@emailaddress.com"
git config --global user.name "Your Name"

# Repository-specific configuration
git config user.email "my@emailaddress.com"
git config user.name "Your Name"

# Set default branch name
git config --global init.defaultBranch main

# View configurations
git config --list
git config --global --list
git config --local --list
git config user.name

# Remove a configuration
git config --global --unset user.name
```

### Initialization

```sh
# Initialize a new Git repository
git init

# Initialize with a specific branch name
git init -b main

# Initialize a bare repository (for servers)
git init --bare
```

### Status & History

```sh
# View status of working directory
git status
git status -s              # Short format
git status -sb             # Short format with branch info

# View commit history
git log
git log -n 5               # Show last 5 commits
git log --oneline          # Condensed view
git log --oneline -{last_n_commits}
git log --all --graph --oneline --decorate  # Detailed graph view

# View history of a specific file
git log -- <filename>
git log -p <filename>      # Show changes in each commit

# View who changed what in a file
git blame <filename>
git blame -L 10,20 <filename>  # Lines 10-20 only

# View commit details
git show <commit-hash>
git show HEAD              # Show latest commit
git show HEAD~2            # Show commit 2 steps back

# Search commits
git log --grep="bug fix"   # Search commit messages
git log -S "function_name" # Search code changes
git log --author="John"    # Filter by author
git log --since="2 weeks ago"
git log --until="2024-01-01"
git log --after="2024-01-01" --before="2024-12-31"

# View reflog (history of HEAD movements)
git reflog
git reflog show <branch-name>
```

### Staging Files

```sh
# Add files to staging area
git add <filename>         # Add specific file
git add .                  # Add all files in current directory
git add --all              # Add all files in repository
git add -A                 # Same as --all
git add *.js               # Add all JavaScript files
git add src/               # Add all files in src directory

# Remove files from staging area
git reset                  # Unstage all files
git reset <filename>       # Unstage specific file
git reset HEAD <filename>  # Same as above

# Remove files from repository
git rm <filename>          # Remove file and stage deletion
git rm --cached <filename> # Remove from Git but keep in filesystem
```

### Committing Changes

```sh
# Commit staged changes
git commit -m "Title" -m "Description"

# Commit all tracked files (skip staging)
git commit -am "Commit message"

# Create an empty commit
git commit --allow-empty -m "Empty commit"

# Checkout to a specific commit (creates detached HEAD state)
git checkout <commit-hash>

# Reset commits
git reset HEAD~            # Undo last commit, keep changes in working directory
git reset --soft HEAD~     # Undo last commit, keep changes staged
git reset --hard HEAD~     # Undo last commit, discard all changes
git reset --hard HEAD~3    # Undo last 3 commits

# Reset to a specific commit
git reset --hard <commit-hash>
```

### Branching

```sh
# List branches
git branch                 # List local branches
git branch -a              # List all branches (local + remote)
git branch -r              # List remote branches
git branch -v              # List with last commit message
git branch -vv             # Show tracking branches

# Create branches
git branch <branch-name>   # Create new branch
git checkout <branch-name>
git checkout -b <branch-name>  # Create and switch to new branch

# Rename branches
git branch -m <old-name> <new-name>
git branch -m <new-name>   # Rename current branch

# Delete branches
git branch -d <branch-name>      # Delete merged branch
git branch -D <branch-name>      # Force delete unmerged branch
git push origin --delete <branch-name>  # Delete remote branch

# Merge branches
git merge <branch-name>          # Merge branch into current branch
git merge --no-ff <branch-name>  # Create merge commit even for fast-forward
git merge --squash <branch-name> # Squash all commits into one

# Resolve merge conflicts
# 1. Edit conflicting files manually
# 2. git add <resolved-files>
# 3. git commit

# Set upstream branch
git branch --set-upstream-to=origin/<branch-name>
git branch -u origin/<branch-name>
```

### Stashing

```sh
# Stash changes
git stash                  # Stash uncommitted changes
git stash save "message"   # Stash with description
git stash -u               # Include untracked files
git stash --all            # Include untracked and ignored files

# List stashes
git stash list

# Apply stashes
git stash apply            # Apply most recent stash
git stash apply stash@{2}  # Apply specific stash
git stash pop              # Apply and remove most recent stash
git stash pop stash@{2}    # Apply and remove specific stash

# View stash contents
git stash show             # Show summary
git stash show -p          # Show diff
git stash show stash@{1}   # Show specific stash

# Delete stashes
git stash drop             # Delete most recent stash
git stash drop stash@{1}   # Delete specific stash
git stash clear            # Delete all stashes

# Create branch from stash
git stash branch <branch-name>
```

### Undoing Changes

```sh
# Discard changes in working directory
git restore .                       # Restore all files
```

### Viewing Differences
```sh
# View changes
git diff                           # Changes in working directory
git diff <commit1> <commit2>       # Between two commits
git diff <branch1>..<branch2>      # Between two branches
git diff HEAD~2 HEAD               # Last 2 commits

# View changes for specific file
git diff <filename>
git diff HEAD~2 <filename>

```

## Remote Repository

### Managing Remotes

```sh
# Add remote repository
git remote add <remote-name> <remote-URL>  # git remote add origin https://github.com/user/repo.git

# View remotes
git remote                 # List remote names
git remote -v              # List with URLs
git remote show origin     # Detailed info about remote

# Rename remote
git remote rename <old-name> <new-name>

# Remove remote
git remote remove <remote-name>
```

### Fetching & Pulling

```sh
# Fetch changes (doesn't merge)
git fetch                  # Fetch from default remote
git fetch origin           # Fetch from origin
git fetch --all            # Fetch from all remotes
git fetch origin <branch-name>

# Pull changes (fetch + merge)
git pull                   # Pull from tracking branch
git pull origin main       # Pull from specific branch
git pull --rebase          # Pull with rebase instead of merge
git pull --ff-only         # Only pull if fast-forward is possible
```

### Pushing

```sh
# Push changes
git push                   # Push to tracking branch
git push origin main       # Push to specific branch
git push --all             # Push all branches

# Force push (use carefully!)
git push --force           # Overwrite remote history

# Push new branch
git push -u origin <new-branch>

# Delete remote branch
git push origin --delete <branch-name>
```

### Cherry-picking

```sh
# Apply specific commits to current branch
git cherry-pick <commit-hash>
git cherry-pick <commit1> <commit2>
git cherry-pick <commit1>..<commit2>  # Range of commits

# Cherry-pick without committing
git cherry-pick -n <commit-hash>
git cherry-pick --no-commit <commit-hash>
```

### Cleaning

```sh
# Remove untracked files
git clean -n               # Dry run
git clean -f               # Force clean
git clean -fd              # Clean files and directories
git clean -fX              # Clean ignored files
git clean -fx              # Clean all untracked files

# Interactive clean
git clean -i
```

---

## Git Workflows

### Feature Branch Workflow
```sh
# 1. Create feature branch
git checkout -b feature/new-feature

# 2. Work on feature and commit
git add .
git commit -m "Add new feature"

# 3. Push feature branch
git push -u origin feature/new-feature

# 4. Create pull request (on GitHub/GitLab)

# 5. After approval, merge to main
git checkout main
git merge feature/new-feature
git push origin main

# 6. Delete feature branch
git branch -d feature/new-feature
git push origin --delete feature/new-feature
```

### Gitflow Workflow
```sh
# Main branches: main, develop
# Supporting branches: feature/*, release/*, hotfix/*

# Start feature
git checkout -b feature/my-feature develop

# Finish feature
git checkout develop
git merge --no-ff feature/my-feature
git branch -d feature/my-feature

# Start release
git checkout -b release/1.0.0 develop

# Finish release
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0
git checkout develop
git merge --no-ff release/1.0.0
git branch -d release/1.0.0
```


---

## Interview Questions & Concepts

### 1. **What is Git and why use it?**
**Answer:** Git is a distributed version control system that tracks changes in source code during software development. It allows multiple developers to work together, maintains history of changes, enables branching and merging, and provides backup and recovery options.

### 2. **Git vs GitHub/GitLab/Bitbucket?**
**Answer:** 
- **Git** is the version control system (software)
- **GitHub/GitLab/Bitbucket** are hosting services for Git repositories with additional features like pull requests, issue tracking, CI/CD, etc.

### 3. **What is the difference between Git pull and Git fetch?**
**Answer:**
- `git fetch` downloads changes from remote but doesn't merge them
- `git pull` downloads changes and automatically merges them (fetch + merge)

### 4. **What is the difference between merge and rebase?**
**Answer:**
- **Merge:** Creates a new merge commit, preserves complete history, creates a branching history
- **Rebase:** Moves commits to new base, creates linear history, rewrites commit history

```sh
# Merge
git merge feature-branch

# Rebase
git rebase main
```

### 5. **What is a detached HEAD state?**
**Answer:** When HEAD points directly to a commit instead of a branch. Happens when you checkout a specific commit or tag.

```sh
git checkout <commit-hash>  # Enters detached HEAD
git checkout -b new-branch  # Create branch to save work
```

### 6. **What is the difference between git reset, git revert, and git checkout?**
**Answer:**
- **git reset:** Moves branch pointer, can alter history (dangerous for shared branches)
- **git revert:** Creates new commit that undoes changes (safe for shared branches)
- **git checkout:** Switches branches or restores files

### 7. **What are the three states in Git?**
**Answer:**
1. **Modified:** Changed but not staged
2. **Staged:** Marked to go into next commit
3. **Committed:** Stored in local database

### 8. **What is the Git stash and when would you use it?**
**Answer:** Temporarily saves uncommitted changes so you can switch branches without committing incomplete work.

```sh
git stash
git stash pop
```

### 9. **How do you undo the last commit?**
**Answer:**
```sh
# Keep changes in working directory
git reset HEAD~

# Keep changes staged
git reset --soft HEAD~

# Discard all changes
git reset --hard HEAD~

# Keep commit in history (safe for shared branches)
git revert HEAD
```

### 10. **What is a fast-forward merge?**
**Answer:** When Git can merge by simply moving the branch pointer forward because there are no divergent commits. No merge commit is created.

```sh
# Fast-forward merge
git merge feature-branch

# If fast-forward is possible:
    # Output: "Fast-forward"
    main:     A --- B --- C
                           \
    feature:                D --- E --- F
# If not possible:
    # Output: "Merge made by the 'recursive' strategy."
          C - D ----
         /          \
    A - B            M (main) <- New merge commit
         \          /
          E - F ---

# Prevent fast-forward (create merge commit)
git merge --no-ff feature-branch
```

### 11. **How do you resolve merge conflicts?**
**Answer:**
1. Git marks conflicts in files with `<<<<<<<`, `=======`, `>>>>>>>`
2. Manually edit files to resolve conflicts
3. `git add <resolved-files>`
4. `git commit` or `git merge --continue`

### 12. **What is cherry-picking?**
**Answer:** Applying specific commits from one branch to another without merging the entire branch.

```sh
git cherry-pick <commit-hash>
```

### 13. **What is the difference between HEAD, working tree, and index?**
**Answer:**
- **HEAD:** Pointer to current branch/commit
- **Working tree:** Your actual files/directories
- **Index (staging area):** Where changes are prepared for commit

### 14. **How do you rename a local and remote branch?**
**Answer:**
```sh
# Rename local branch
git branch -m old-name new-name

# Delete old remote branch and push new one
git push origin --delete old-name
git push -u origin new-name
```

### 15. **What is a bare repository?**
**Answer:** A repository without a working directory, used on servers. Contains only Git metadata.

```sh
git init --bare
```

### 16. **How do you squash commits?**
**Answer:**
```sh
# Interactive rebase
git rebase -i HEAD~3

# In editor, change 'pick' to 'squash' or 's' for commits to squash
```

### 17. **What is the difference between origin and upstream?**
**Answer:**
They're just common names developers use for remote repositories
- **origin:** Your remote repository (usually your fork)
    - `git remote add origin <url>`  # automatically added when you clone
- **upstream:** Original repository you forked from
    - `git remote add upstream <url>`  # add manually and dont push (you might not have permission)

### 18. **How do you undo git push?**
**Answer:**
# Reset local branch
git reset --hard HEAD~1

# Force push (use carefully!)
git push --force-with-lease
```

### 19. **What is .gitignore?**
**Answer:** File that specifies which files/directories Git should ignore.

```sh
# .gitignore example
*.log
node_modules/
.env
dist/
```

### 20. **How do you find who changed a specific line in a file?**
**Answer:**
```sh
git blame <filename>
git log -p <filename>
```

### 21. **What is git reflog?**
**Answer:** Reference log that records when tips of branches and HEAD were updated. Useful for recovering lost commits.

```sh
git reflog
git checkout <commit-from-reflog>
```

### 22. **How would you find a bug in commit history?**
**Answer:** Use `git bisect` to perform binary search through commits.

```sh
git bisect start
git bisect bad
git bisect good <commit>
# Test and mark commits as good or bad
git bisect reset
```

### 23. **What is the difference between --soft, --mixed, and --hard reset?**
**Answer:**
```sh
git reset --soft HEAD~   # Keeps changes staged
git reset --mixed HEAD~  # Keeps changes unstaged (default)
git reset --hard HEAD~   # Discards all changes
```

### 24. **How do you configure line endings in Git?**
**Answer:**
```sh
# Windows
git config --global core.autocrlf true

# Mac/Linux
git config --global core.autocrlf input
```

### 25. **What are Git hooks?**
**Answer:** Scripts that run automatically at specific points in Git workflow (pre-commit, post-commit, pre-push, etc.). Located in `.git/hooks/`.

---

## Best Practices

### Commit Messages
```
# Good commit message format:
<type>(<scope>): <subject>

<body>

<footer>

# Examples:
feat(auth): add login functionality
fix(api): handle null pointer exception
docs(readme): update installation instructions
refactor(database): optimize query performance
test(user): add unit tests for user service
```

### Types of commits:
- **feat:** New feature
- **fix:** Bug fix
- **docs:** Documentation changes
- **style:** Formatting, missing semicolons, etc.
- **refactor:** Code restructuring
- **test:** Adding tests
- **chore:** Maintenance tasks

### General Best Practices

1. **Commit often, push regularly**
2. **Write meaningful commit messages**
3. **Keep commits atomic** (one logical change per commit)
4. **Don't commit generated files**
5. **Use .gitignore properly**
6. **Pull before push**
7. **Use branches for features/fixes**
8. **Review code before committing**
9. **Don't commit secrets** (API keys, passwords)
10. **Use tags for releases**

### Branching Conventions

```
main/master         - Production-ready code
develop             - Development branch
feature/feature-name - New features
bugfix/bug-name     - Bug fixes
hotfix/fix-name     - Urgent production fixes
release/version     - Release preparation
```

---

## Common Scenarios & Solutions

### Scenario 1: Accidentally committed to wrong branch
```sh
# Save commit hash
git log -1

# Undo commit but keep changes
git reset --soft HEAD~1

# Switch to correct branch
git checkout correct-branch

# Commit changes
git add .
git commit -m "Your message"
```

### Scenario 2: Need to edit last commit message
```sh
# If not pushed
git commit --amend -m "New message"

# If already pushed (use carefully!)
git commit --amend -m "New message"
git push --force-with-lease
```

### Scenario 3: Need to remove file from last commit
```sh
git reset --soft HEAD~1
git restore --staged <file>
git commit -c ORIG_HEAD
```

### Scenario 4: Accidentally deleted branch
```sh
# Find commit hash
git reflog

# Recreate branch
git branch <branch-name> <commit-hash>
```

### Scenario 5: Need to update commit author
```sh
# Last commit
git commit --amend --author="Name <email@example.com>"

# Multiple commits
git rebase -i HEAD~3
# Change 'pick' to 'edit' for commits to modify
git commit --amend --author="Name <email@example.com>"
git rebase --continue
```

### Scenario 6: Merge conflict during pull
```sh
git pull origin main
# Conflicts occur
# Edit files to resolve conflicts
git add <resolved-files>
git commit -m "Resolve merge conflicts"
```

### Scenario 7: Need to split a commit
```sh
git rebase -i HEAD~3
# Change 'pick' to 'edit' for commit to split
git reset HEAD~
git add <file1>
git commit -m "First part"
git add <file2>
git commit -m "Second part"
git rebase --continue
```

### Scenario 8: Accidentally committed sensitive data
```sh
# Remove from last commit
git rm --cached <sensitive-file>
echo "<sensitive-file>" >> .gitignore
git add .gitignore
git commit --amend --no-edit

# Remove from history (use carefully!)
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch <sensitive-file>" \
  --prune-empty --tag-name-filter cat -- --all

# Or use BFG Repo-Cleaner (recommended)
bfg --delete-files <sensitive-file>
```

### Scenario 9: Sync fork with upstream
```sh
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

### Scenario 10: Recover deleted files
```sh
# Find commit where file existed
git log --all --full-history -- <file-path>

# Restore file
git checkout <commit-hash>^ -- <file-path>
```

---

## Quick Reference Cheat Sheet

```sh
# Setup
git config --global user.name "name"
git config --global user.email "email"

# Create
git init
git clone <url>

# Changes
git status
git diff
git add <file>
git commit -m "message"

# Branching
git branch
git branch <name>
git checkout <name>
git merge <branch>

# Remote
git remote add origin <url>
git push -u origin main
git pull
git fetch

# Undo
git reset <file>
git reset --hard HEAD
git revert <commit>

# History
git log
git log --oneline
git reflog

# Stash
git stash
git stash pop

# Tag
git tag v1.0.0
git push --tags
```

## Your Project Setup

```sh
# Initialize repository
git init

# Add README
git add README.md
git commit -m "first commit"

# Rename branch to master (if needed)
git branch -M master

# Add remote repository
git remote add personalNotes https://github.com/Pantho-Haque/PersonalNotes.git

# Push to remote
git push -u personalNotes master
```
