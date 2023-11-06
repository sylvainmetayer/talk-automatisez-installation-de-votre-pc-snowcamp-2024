# Démo dotfiles

## perso

```shell
git clone https://github.com/sylvainmetayer/talk-automatisez-installation-de-votre-pc-bdxio-2023.git && cd talk-automatisez-installation-de-votre-pc-bdxio-2023/dotfiles/ && ./scripts/bootstrap.sh

newgrp docker
docker container run hello-world

/opt/toolbox/jetbrains-toolbox &
code $HOME/talk-automatisez-installation-de-votre-pc-bdxio-2023/dotfiles

# ctrl = // zoom in # ctrl - // zoom out # color theme => light+

# // structure / playbook / roles
# playbooks/perso/main.yaml
# playbooks/perso/locals.yaml
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

# playbooks/perso/main.yaml
# playbooks/perso/secret_data.txt
cat ~/secret_data.txt
```

## Initial Setup

- `dnf install git python3-pip`
- `git clone https://github.com/sylvainmetayer/talk-automatisez-installation-de-votre-pc-bdxio-2023`
- `./scripts/bootstrap.sh` Will install dependencies and start perso playbook with the sudo password on the demo VM

## Usage

- `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-playbook playbooks/perso/main.yaml -K`

- view file : `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-vault view secret_data.txt`
- edit file : `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-vault edit secret_data.txt`
- encrypt file : `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-vault encrypt secret_data.txt`
- decrypt file: `ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible_vault.txt ansible-vault decrypt secret_data.txt`
