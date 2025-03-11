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
gitpush "Your commit message here"
```
