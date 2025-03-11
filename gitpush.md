# GitPush

A tool that make you git commit and push more dependable

## Make the script

- Open terminal and type

```sh
nano gitpush
```

- inside the file

```sh
#!/bin/bash

# Check if commit message is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <commit-message> [branch-name]"
  exit 1
fi

# Set branch name to the second argument if provided; otherwise, default to 'pantho'
BRANCH_NAME=${2:-pantho}

git checkout -b "$BRANCH_NAME"
git add .
git commit -m "$1"
git push origin "$BRANCH_NAME"
```

- make it executable

```sh
chmod +x gitpush
```

## move the script to the PATH

```sh
sudo mv gitpush /usr/local/bin/
```

## Use the Script

```sh
gitpush "Your commit message here" "targeted branch here"
```

## Sample output

```sh
pantho@pantho-c3203:~/Desktop/PersonalNotes$ gitpush "new tool- gitpush" main
Switched to a new branch 'main'
[main 4d5f877] new tool- gitpush
 1 file changed, 49 insertions(+)
 create mode 100644 gitpush.md
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 679 bytes | 679.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote:
remote: Create a pull request for 'main' on GitHub by visiting:
remote:      https://github.com/Pantho-Haque/PersonalNotes/pull/new/main
remote:
To https://github.com/Pantho-Haque/PersonalNotes.git
 * [new branch]      main -> main
```
