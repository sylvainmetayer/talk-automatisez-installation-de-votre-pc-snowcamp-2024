# Ansible

speaker:

Outil d'automatisation permettant provisionnement machines

Peut déployer sur parc de machine distant ou une seule machine locale

Notion playbook / roles => communauté

Syntaxe YAML

,,,

## Avantages / Inconvénients <!-- .element: class="advantage_inconvenience" -->

| Objectif                                | État |
|-----------------------------------------|------|
| Gérer mes fichiers de configuration     | ✅    |
| Gérer les logiciels installés           | ✅    |
| Versionnable                            | ✅    |
| Facilement maintenable                  | ✅    |
| Gérer mon poste de travail pro et perso | ✅    |
| Gestion de secrets                      | ✅    |

speaker:

- Peu de prérequis
- Vous utilisez déjà ansible pour votre configuration de machines ?
- Roles / Playbooks (séparer PC pro/perso)
- Syntaxe YAML

Cependant, si pas d'usage d'ansible autre que pour un seul poste, peu être "lourd" à mettre en place

,,,

## Concrètement, comment fait-on ?

<img src="assets/img/tell_me_more.gif"  height="300" width="600" alt="Tell me more">

speaker:

- Structure
- Usage
- Symlink
- Gestion des secrets
- Plusieurs machines

Structure :

roles, tasks, playbook, variables

Ansible galaxy fournit plein de roles déjà prêt (exemple : Guerrlinguy docker) pour setup votre pc

Usage :

montrer script bootstrap rapidement

Installation de packages :

dotfiles/roles/fedora_dependencies/tasks/main.yaml

Symlink :

dotfiles/roles/commons/tasks/symlink.yml + fonction gitignore à présenter

Templating : Dire que possible si besoin de boucles à partir de variables, mais ne pas présenter et renvoyer vers la documentation

Montrer résultat de gitconfig

Gestion des secrets : secret_data.txt + bootstrap.sh

Plusieurs machines : playbooks demo + work avec variables différentes

,,,

## Structure

```bash []
├── playbooks
│   ├── demo
│   └── work
├── roles
│   ├── jetbrains_toolbox
│   │   ├── defaults
│   │   ├── tasks
│   │   └── templates
│   └── ssh_config
│       ├── files
│       ├── tasks
│       └── templates
│   └── [...]
└── scripts
```

,,,

## Playbook

```yaml []
- hosts: localhost
  pre_tasks:
    - name: "Simple task"
      debug:
        msg: "Hello, BDX I/O !"
  roles:
    - role: geerlingguy.docker
      become: true
    - role: git_config
```

speaker: task / role communauté / role custom

,,,

## Communauté

TODO Image ? + requirement.yml

,,,

## Usage

```bash [1-4|5-6|7-10]
$ cat scripts/bootstrap.sh
python3 -m pip install --user -r "requirements.txt"
ansible-galaxy role install -r "requirements.yml"
ansible-playbook playbooks/demo/main.yaml -K
$ cat requirements.txt
ansible==7.0.0
$ cat requirements.yml
roles:
  - src: geerlingguy.docker
    version: 6.1.0
```

,,,

## Installation de paquets

TODO

,,,

## Symlink

TODO

,,,

## Templating

TODO Dire que possible si besoin de boucles à partir de variables, mais ne pas présenter et renvoyer vers la documentation

TODO Image template

,,,

## Gestion des secrets

TODO Montrer fichier chiffré / ansible-vault / résultat

,,,

## Plusieurs postes ?

```bash
├── demo
│   ├── main.yaml
└── work
    └── main.yaml
```

,,,

### Et si je veux faire...

<https://docs.ansible.com/>

<https://galaxy.ansible.com/>
