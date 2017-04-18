---
type:               "post"
title:              "What to add into my group_vars ?"
date:               "2016-03-10"
publishdate:        "2016-03-10"
draft:              true
slug:               "fullfil-my-group-vars"
description:        "Creating group definition files"

author_username:    "gfaivre"
---

# Fullfil my group vars

Group vars with no surprise will store group's environment definitions. Beginning with the all.yml we will store there common variable definitions and for the first of them, we like to define the domain concerned and the environment (production, testing ... ).

## all.yml

```
---

##########
# Domain #
##########

domain: manala.example

#######
# Env #
#######

env: prod
```

### Options

This part will be responsible for defining cross containers variables like ssh keys.

```
all_options:

  # Team infra
  authorized_keys_infra:
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/guewen.faivre@manala.io.pub') }}"
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/florian.rey@manala.io.pub') }}"
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/yves.heitz@manala.io.pub') }}"

  # Extra gateway
  authorized_keys_gateway:
  # Aliens
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/luke.skywalker@yavin.com.pub') }}"
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/totoro@neighbour.com.pub') }}"
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/jupiter@solar.system.pub') }}"
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/e.t@home.faraway.pub') }}"

  # Global app
  authorized_keys_app:
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/benjamin.leveque@manala.io.pub') }}"
    - "{{ lookup('file', playbook_dir ~ '/files/users/keys/maxime.colin@manala.io.pub') }}"
```

### Patterns

```
all_patterns:

  ########
  # Sudo #
  ########

  sudo_sudoers_exclusive: true
  sudo_sudoers: "{{ infra_options.dc.admin_sudoers }}"

  ###############
  # Environment #
  ###############

  environment_files:
    - zsh

  #######
  # Vim #
  #######

  vim_config_template: config/default.{{ env }}.j2

  #######
  # Git #
  #######

  git_config_template: config/default.{{ env }}.j2
```
