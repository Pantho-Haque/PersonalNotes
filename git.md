- [Local Repository](#local-repository)
  - [Config](#config)
  - [Initialization](#initialization)
  - [status](#status)
  - [Add file](#add-file)
  - [Commit](#commit)
  - [Branch](#branch)
- [Remote Repository](#remote-repository)
  - [Add remote repository](#add-remote-repository)
  - [Remote Status](#remote-status)
  - [Remove a remote repo](#remove-a-remote-repo)
  - [Clone](#clone)
  - [Pull](#pull)
  - [Push](#push)

## Local Repository

### Config

    // Running git config globally

```sh
    $ git config --global user.email "my@emailaddress.com"
    $ git config --global user.name "myName"

    // Running git config on the current repository settings
    $ git config user.email "my@emailaddress.com"
    $ git config user.name "Brian Kerr"
```

### Initialization

```sh
    git init
```

### status

```sh
    git status
    git log
    git log -<number>
    git log --oneline
    git log --oneline -<number>
```

### Add file

```sh
                      // -> to make a file staged from
    git add --all     // main directory
    git add .         // current directory
    git add *         // all files in the current directory except ones that begin with a period
    git reset // to make a files unstaged
```

### Commit

```sh
    git commit -m " "
    git reset HEAD~     // reset to working directory from local repo
```

### Branch

```sh
    git branch <branch_name>        // creat a new branch
    git branch -a                   // list all remote or local branch
    git branch -d <branch_name>     // delete a branch

    git checkout <branch_name>      // changing branch
    git checkout -b <new_branch>    // create and changing into a new branch

    git merge <other_branch_name>   // Merge changes into current branch
```

## Remote Repository

### Add remote repository

```sh
    git remote  <command>  <remote_name>      <remote_URL>
                | add |     | remote  |   |https://github.com/.....|
                |     |     |repo name|   |                        |

    // A remote repository can have any name. It’s common practice to name the remote repository ‘origin’.
```

### Remote Status

```sh
    git remote -v       // list of all remote repositories
    git branch -r       // list of remote branches
```

### Remove a remote repo

```sh
    git remote remove <remote_name>
```

### Clone

```sh
    git clone <remote_URL>  // just take a copy of remote repository
```

### Pull

```sh
    git pull <branch_name> <remote_URL/remote_name>         // get the latest version of a repository
```

### Push

```sh
    git push <remote_URL/remote_name> <branch> //Sends local commits to the remote repository.

    git push --all                              //Push all local branches to remote repository
```

<!-- http://guides.beanstalkapp.com/version-control/common-git-commands.html

stash
log
rm

 -->

**_this project code_**

```sh
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M master
    git remote add personalNotes https://github.com/Pantho-Haque/PersonalNoets.git
    git push -u personalNotes master
```
