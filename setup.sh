#!/bin/bash

cd /workspaces/capstone-codespace

if [[ ! -f "/home/vscode/.ssh/id_rsa" ]]; then
    ssh-keygen
    echo "New public key created."
    echo "Add this to your GitLab account for git access: https://gitlab.com/-/user_settings/ssh_keys"
    echo "Then rerun this script."
    echo ""
    cat /home/vscode/.ssh/id_rsa.pub
    exit 0
fi
if [[ ! -d "/workspaces/capstone-codespace/dso-capstone" ]]; then
    echo "Cloning capstone project to /workspaces/capstone-codespace/dso-capstone"
    git clone git@gitlab.com:pragdata/dso-capstone.git
fi
echo "Capstone project available at /workspaces/capstone-codespace/dso-capstone"
if [[  $(wc -l < do-kube.nogit.yaml) -lt 3 ]]; then
    echo "Paste the configuration file to connect to the cluster in do-kube.nogit.yaml"
    echo "This file should be open in the editor now."
    echo "Save and close the file when you are done."
    echo "Then rerun this script."
    git update-index --skip-worktree do-kube.nogit.yaml
    code do-kube.nogit.yaml
else
    echo "You should now be able to use 'kubectl-prod' to access the production cluster."
    echo "The 'kubectl' command will work with minikube."
fi