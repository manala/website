---
type:               "page"
title:              "Deploying my app with Manala"
date:               "2017-06-10"
publishdate:        "2017-06-10"
draft:              true
slug:               "deploying-my-app-with-manala"
description:        "Deploying applications with the manala project."

author_username:    "gfaivre"
---

## Getting Started

To get up and running you will need the following:

- Ansible 2.+
- Remote ssh access on the target server

## Preparing your project

For this example we'll used a PHP/Symfony project.
Depending if you are already using the manala project or just want a deployment solution, you should have (or create) a directory named `manala`.

You should have an arboresence similar to:

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
