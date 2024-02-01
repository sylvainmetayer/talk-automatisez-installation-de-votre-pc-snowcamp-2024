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
│   ├── demo
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
$ ansible-playbook playbooks/demo/main.yaml -K
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
# playbooks/demo/main.yaml
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

```bash
$ cat secret_data.txt
$ANSIBLE_VAULT;1.1;AES256
66346336343766663038323062316537383065383137633163363434666232653335653833346633
3838343030646662306232346361393431656537653635310a353034343734643333303064363235
33666538383165666434343435613861666161663535313938623461326435386266633162343139
3233386634303566630a666238303633336266363237336461643435626238363134363430636230
35613437313833373662306239373830383766656135646136313535366231336363
```

speaker: ansible transparent sur usage vault, va utiliser password indiqué. Possible de le préciser dans un fichier pour éviter d'avoir à le retaper à chaque fois.

,,,

## Gestion des secrets

```bash [1|2-4|5]
$ ansible-vault create secret_data.txt
$ ansible-vault view secret_data.txt
Vault password:
Bonjour SnowCamp ! :)
$ ansible-playbook playbooks/demo/main.yaml --ask-vault-pass
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

## Mais encore ?

<img src="assets/img/battery_off.png" height="33" width="127" alt="Indicateur batterie off">

```yaml
- name: Display battery percentage
  dconf:
    key: "/org/gnome/desktop/interface/show-battery-percentage"
    value: "true"
    state: present
```

<img src="assets/img/battery_on.png" height="33" width="127" alt="Indicateur batterie on">

Windows (regedit) : [win_regedit_module](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_regedit_module.html)

,,,

## Petite démo

<video width="1000" height="600" controls muted data-autoplay>
  <source src="assets/img/demo.mp4" type="video/mp4">
</video>

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
