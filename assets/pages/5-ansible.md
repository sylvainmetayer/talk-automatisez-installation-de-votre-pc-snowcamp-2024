# Ansible

speaker:

Outil d'automatisation permettant provisionnement machines

Peut déployer sur parc de machine distant ou une seule machine locale

roles/playbooks

Notion communauté +++ qui va permettre de faire assemblage de roles pour répondre au besoin ou création roles et publication

Syntaxe YAML

,,,

## Concrètement, comment fait-on ?

<img src="assets/img/tell_me_more.gif"  height="300" width="600" alt="Tell me more">

,,,

## Structure

```bash []
├── playbooks
│   ├── perso
│   ├── work
│   ├── ├── main.yaml
├── roles
│   ├── jetbrains_toolbox
│   │   ├── defaults
│   │   ├── tasks
│   │── git_config
│   │   ├── tasks
│   └── [...]
```

,,,

## Playbook

```yaml []
- hosts: localhost
  tasks:
    - name: "Simple task"
      debug:
        msg: "Hello, SnowCamp !"
  roles:
    - role: geerlingguy.docker
      become: true
    - role: git_config
```

speaker: task / role communauté / role custom

,,,

## Usage

```bash [1-3|4-5|6-9]
$ cat scripts/setup.sh
python3 -m pip install --user -r "requirements.txt"
ansible-galaxy role install -r "requirements.yml"
$ cat requirements.txt
ansible==7.0.0
$ cat requirements.yml
roles:
  - src: geerlingguy.docker
    version: 6.1.0
```

,,,

## Usage

```bash []
$ ansible-playbook playbooks/perso/main.yaml -K
BECOME password:
```

```text
PLAY [localhost] ************************************

TASK [git_config : Ensure Git config file exists] ************************************
ok: [localhost]

TASK [git_config : Render Git config Template] ************************************
changed: [localhost]

PLAY RECAP ************************************
localhost                  : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

Playbook run took 0 days, 0 hours, 0 minutes, 1 seconds
```

speaker: !!!! idempotent !!!!!! OK vs changed

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

```yaml []
# playbooks/perso/main.yaml
- hosts: localhost
  roles:
    - role: commons
      vars:
        packages_to_install: [vim]
```

,,,

## Symlink

```text []
roles/symlink
├── files
│   ├── .config
│   │   ├── htop
│   │   │   └── htoprc
│   └── .vimrc
```

```yaml [1-2|7-12]
# item = .vimrc
# roles/symlink/tasks/main.yaml

# [...] Create folders
# [...] Ensure file does not exists

- name: "{{ item }} : Update dotfile symlink"
  file:
    src: "{{ role_path }}/files/{{ item }}"
    dest: ~/{{ item }}
    state: link
```

speaker: réplique comportement stow

,,,

## Templating

```yaml []
- name: Template gitconfig
  ansible.builtin.template:
    src: templates/gitconfig.j2
    dest: "~/.gitconfig"
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
```

<https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_templating.html>

speaker:

- variabiliser
- ansible utilise jinja2 comme moteur de template
- Dire que possible si besoin de boucles à partir de variables, mais ne pas présenter et renvoyer vers la documentation

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

TODO refaire exemple

```bash
$ cat secret_data.txt
$ANSIBLE_VAULT;1.1;AES256
38626633303165353335613735613032613334653564316562363336366664323433336239633132
6432623338656162363862396237393730356434656539390a333735613165383262653831386339
30396337303231373036396361356232313038326565313063343237663034303239393137643230
6238313738623463630a323661373635386331313765306462633331666632323636376163306631
35663034323138616564626165396361363261616439393165636531623361303364343434636633
66623434343638353436636630343034363365323264663264363566353665383531336531303362
36353538333063396638666632316537333931373933666262313064333264323839386430346233
36356633643032373263
```

speaker: ansible transparent sur usage vault, va utiliser password indiqué. Possible de le préciser dans un fichier pour éviter d'avoir à le retaper à chaque fois.

,,,

## Gestion des secrets

```bash [1|2-5|6]
$ ansible-vault create secret_data.txt
$ ansible-vault view secret_data.txt
Vault password:
Bonjour SnowCamp ! :)
$ ansible-playbook playbooks/perso/main.yaml --ask-vault-pass
```

speaker: ansible transparent sur usage vault, va utiliser password indiqué. Possible de le préciser dans un fichier pour éviter d'avoir à le retaper à chaque fois.

,,,

## Plusieurs postes ?

```bash
├── perso
│   ├── main.yaml
└── work
    └── main.yaml
```

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

### Et si je veux faire...

<https://docs.ansible.com/>

<https://galaxy.ansible.com/>
