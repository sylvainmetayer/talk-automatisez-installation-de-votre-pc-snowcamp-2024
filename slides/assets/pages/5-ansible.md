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

```yaml []
# roles/commons/defaults/main.yaml
packages_to_install:
  - vim
  - firefox
  - code
```

```yaml []
# roles/commons/tasks/main.yaml
- name: Install packages
  become: true
  ansible.builtin.package:
    name: "{{ packages_to_install }}"
    state: present
```

,,,

## Symlink

```bash []
roles/commons
├── defaults
│   └── main.yaml
├── files
│   ├── .tmux.conf
│   └── .vimrc
├── tasks
│   ├── main.yml
│   └── symlink.yml
```

```yaml []
# roles/commons/tasks/main.yaml
- name: Setup symlinks
  include_tasks: symlink.yml
  loop: "{{ commons_symlinks }}"
```

,,,

## Symlink

```yaml [2-5|7-11|19-24]
# roles/commons/tasks/symlink.yaml
- name: "{{ item }} : Collect file info"
  stat:
    path: "~/{{ item }}"
  register: dotfile

- name: "{{ item }} : Ensure folder does exists"
  file:
    mode: "0700"
    path: "~/{{ item | dirname }}"
    state: directory

- name: "{{ item }} : Delete regular file"
  file:
    path: "~/{{ item }}"
    state: absent
  when: dotfile.stat.islnk is defined and dotfile.stat is defined and dotfile.stat.isreg

- name: "{{ item }} : Update dotfile symlink"
  file:
    src: "{{ role_path }}/files/{{ item }}"
    dest: ~/{{ item }}
    state: link
    force: false
```

,,,

## Templating

```yaml []
- name: Template gitconfig
  ansible.builtin.template:
    src: templates/gitconfig.j2
    dest: /tmp/hostname
```

```ini []
# roles/git_config/templates/gitconfig.j2
[user]
{% if git_config_user is defined %}
  name = {{ git_config_user }}
{% endif %}
{% if git_config_email is defined %}
  email = {{ git_config_email }}
{% endif %}
[...]
```

<https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_templating.html>

speaker: Dire que possible si besoin de boucles à partir de variables, mais ne pas présenter et renvoyer vers la documentation

,,,

## Gestion des secrets

```yaml []
- name: "Copy secret file"
  copy:
    src: "secret_data.txt"
    dest: ~/secret_data.txt
    mode: "0600"
```

speaker: ansible transparent sur usage vault, va utiliser password indiqué. Possible de le préciser dans un fichier pour éviter d'avoir à le retaper à chaque fois.

,,,

## Gestion des secrets

```bash
$ cat secret_data.txt
$ANSIBLE_VAULT;1.1;AES256
64346566373365653966353131653732343436653438653737643065636338663463373736326630
6436396132396637353939353935653064666363653463330a366338356261363965303132643039
63343262646361653537666535366237623666643466303630316135333366303038306364316236
3432636165363032650a626161323965616139333064363433663562333863326662363537376236
34383731613265326264363566613036316531666431383666313363323033303138
```

speaker: ansible transparent sur usage vault, va utiliser password indiqué. Possible de le préciser dans un fichier pour éviter d'avoir à le retaper à chaque fois.

,,,

## Gestion des secrets

```bash [1|2-4]
$ ansible-playbook playbooks/demo/main.yaml --ask-vault-pass
$ ansible-vault view secret_data.txt
Vault password:
Bonjour BDX I/O ! :)
```

speaker: ansible transparent sur usage vault, va utiliser password indiqué. Possible de le préciser dans un fichier pour éviter d'avoir à le retaper à chaque fois.

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
