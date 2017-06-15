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

- Specifity: Event if Manala deploy role, almost out of the box, can put you code on your server/container your project will have is own needs end configuration steps requirements.
It's why you can easily define tasks to run when deploying.
- Multiple stages:
You just need to define your global configuration once and make custom configurations for environments like domain names or IP adresses.
- Community: Manala is an open source project build on top on Ansible, it's easily extensible and technology agnostic, meaning you can deploy whatever you want, Wordpress, Symfony, RoR or Laravel applications.
- Simplicity: Basicaly it's juste SSH and automation (Ansible), if you are familiar with command line and SSH instructions it will perfectly feat to your needs.

## Preparing your project

For this example we'll used a PHP/Symfony project.
Depending if you are already using the manala project or just want a deployment solution, you should have (or create) a directory named `manala`.

You should have an arborescence similar to:

```
├── Jenkinsfile
├── Makefile
├── README.md
├── ansible
├── app
├── behat.yml.dist
├── bin
├── composer.json
├── composer.lock
├── features
├── manala
├── manala.yml
├── package.json
├── phpunit.xml.dist
├── src
├── tests
├── var
├── web
├── webpack.mix.js
└── yarn.lock
```

## Configuration

The base file will be the `deploy.yml` it will contain all common instructions between environments.

### Options

- `manala_deploy_dir`: Will target the remote directory where the application will be deploy.
- `manala_deploy_release`: Allow tou to specify the number of releases you want to keep (default is 5).
- `manala_deploy_strategy`: Deployment strategy can be `git` or `synchronize` they will be explain further.

#### Git strategy

In this case we want to checkout directly from the repository to the target server. We need to have to more informations:

- `manala_deploy_strategy_git_repo`: As you probably guess, concerne the url of the repository
- `manala_deploy_strategy_git_version`: The branch/tag considered.

#### Synchronize strategy

Strategy synchronize
