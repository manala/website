---
type:               "deployment"
title:              "Features"
date:               "2017-06-10"
publishdate:        "2017-06-10"
draft:              true
slug:               "features"
description:        "Remote server automation and deployment tool - Features."

author_username:    "gfaivre"
---

# Features

There are many ways to automate deployments, from simple rsync bash scripts to complex containerized toolchains.
The main goal here is to reproduce what you are doing manually over SSH, the difference being it's repeatable and scalable.

Some of the features:

- **Specifity:** Event if Manala deploy role (almost out of the box) can put your code on your server/container your project will have is own needs end configuration steps requirements.
It's why you can easily define tasks to run when deploying.
- **Multiple stages:**
You just need to define your global configuration once and make custom configurations for environments like domain names and/or IP adresses.
- **Community:** Manala is an open source project build on top of Ansible, it's easily extensible and technology agnostic, meaning you can deploy whatever you want, Wordpress, Symfony, RoR or Laravel applications.
- **Simplicity:** Basicaly it's juste SSH and automation (Ansible), if you are familiar with command line and SSH instructions it will perfectly feat to your needs.

