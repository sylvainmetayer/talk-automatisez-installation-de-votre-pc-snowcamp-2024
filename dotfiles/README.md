# Démo dotfiles

Recorded demo

```shell
git clone https://github.com/sylvainmetayer/talk-automatisez-installation-de-votre-pc-snowcamp-2024.git && cd talk-automatisez-installation-de-votre-pc-snowcamp-2024/dotfiles/ && ./scripts/bootstrap-demo.sh
```

## demo

```shell
git clone https://github.com/sylvainmetayer/talk-automatisez-installation-de-votre-pc-snowcamp-2024.git && cd talk-automatisez-installation-de-votre-pc-snowcamp-2024/dotfiles/ && ./scripts/bootstrap.sh

newgrp docker
docker container run hello-world

/opt/toolbox/jetbrains-toolbox &
code $HOME/talk-automatisez-installation-de-votre-pc-snowcamp-2024/dotfiles

# ctrl = // zoom in # ctrl - // zoom out # color theme => light+

# // structure / playbook / roles
# playbooks/demo/main.yaml
# playbooks/demo/locals.yaml
# roles/commons/tasks/main.yml
# inventory.yml

# // usage
# scripts/bootstrap.sh
# requirements.txt
# requirements.yml

# // packages
# roles/fedora_dependencies/tasks/main.yaml
# roles/fedora_dependencies/tasks/packages.yaml
# roles/fedora_dependencies/defaults/main.yaml

# // symlink
# roles/commons/tasks/main.yml
# gitignore rust // which gitignore
# roles/commons/files/.bashrc.d/gitignore.sh

guake
ls -ail ~
cat ~/.gitconfig # template
cat ~/.vimrc # symlink

# playbooks/demo/main.yaml
# playbooks/demo/secret_data.txt
cat ~/secret_data.txt
```

## Initial Setup

- `dnf install git python3-pip`
- `git clone https://github.com/sylvainmetayer/talk-automatisez-installation-de-votre-pc-snowcamp-2024`
- `./scripts/bootstrap.sh` Will install dependencies and start demo playbook with the sudo password on the demo VM

## Usage

- `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-playbook playbooks/demo/main.yaml -K`

- view file : `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-vault view secret_data.txt`
- edit file : `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-vault edit secret_data.txt`
- encrypt file : `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-vault encrypt secret_data.txt`
- decrypt file: `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-vault decrypt secret_data.txt`

Password is `sylvain`
