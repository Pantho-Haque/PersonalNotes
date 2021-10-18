## Local Repository

---

### Config

    // Running git config globally

    ```
        $ git config --global user.email "my@emailaddress.com"
        $ git config --global user.name "myName"
    ```


    // Running git config on the current repository settings

    ```sh
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
    ```

### Add file

    ```sh
        git add
    ```

### Commit

    ```sh
        git commit -m " "
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

---

### Add remote repository

    ```sh
        git remote  <command>  <remote_name>      <remote_URL>
                    | add |     | remote  |   |https://github.com/.....|
                    |     |     |repo name|   |                        |

        // A remote repository can have any name. It’s common practice to name the remote repository ‘origin’.

        git remote -v       // list of all remote repositories
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

        git push -all                              //Push all local branches to remote repository
    ```

<!-- http://guides.beanstalkapp.com/version-control/common-git-commands.html

stash
log
rm

 -->

```sh
    git init
    git add README.md
    git commit -m "first commit"
    git branch -M main
    git remote add origin https://github.com/Pantho-Haque/PersonalNoets.git
    git push -u origin main
```
