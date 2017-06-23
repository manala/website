---
type:               "deployment"
title:              "Deploy from a local build"
date:               "2017-06-22"
publishdate:        "2017-06-22"
draft:              true
slug:               "deploy-from-local-build"
description:        "Remote server automation and deployment tool - Deploy from a local build."

author_username:    "mcolin"
---

# Deploy from a local build

A particular deploy strategy proposed by `manala.deploy` consist in building a local release of your application and then deploying it.

The process consist in 2 steps:

1. A release playbook **building** your release
2. A deploy playbook **deploying** your release
 
## Build the release

To build the release we simply deploy your application in local and create an archive with it.

First thing is to **add localhost to your host inventary file** in a `release` group:

{{< highlight ini >}}
localhost_production ansible_connection=local

[release_production]
localhost_production

[release:children]
release_production
{{< /highlight >}}

<br>
Configure your deploy as [usually](/deployment/symfony-deploy-from-git/) in a `group_vars/release.yml` file and set where your build will be stored.

{{< highlight yaml >}}
# release.yml
manala_deploy_dir: "/tmp/your-app-build"
{{< /highlight >}}

<br>
You can also remove all file and directory not required on the server once the release is builded, like tests, dot files, ansible config, frontend dependencies, ...

{{< highlight yaml >}}
manala_deploy_removed:
  - ansible
  - node_modules
  - tests
  - web/app_dev.php
  - web/app_test.php
  - .editorconfig
  - .gitignore
  - .php_cs
  - package.json
  - phpunit.xml.dist
  - webpack.config.js
  - yarn.lock
{{< /highlight >}}

<br>

Then create a new `release.yml` playbook which will play the deploy role. The playbook will also create an archive from the locally deployed release.

{{< highlight yaml >}}
---
- hosts: release
  any_errors_fatal: true
  roles:
    - manala.deploy
  tasks:
    - name: Release > Remove previous archive
      file:
        path: /tmp/your-app-build/current.tar.gz
        state: absent
    - name: Release > Create archive
      shell: "tar zcvf /tmp/your-app-build/current.tar.gz ."
      args:
        chdir: /tmp/your-app-build/current
        creates: current.tar.gz
{{< /highlight >}}

<br>
You can use any archive format you want while it's compatible with Ansible [`unarchive`](https://docs.ansible.com/ansible/unarchive_module.html) module.

And finally play the playbook:

{{< highlight yaml >}}
ansible-playbook ansible/release.yml --inventory-file=ansible/hosts --limit=release_production
{{< /highlight >}}

<br>
At the end, you will get an archive at `/tmp/your-app-build/current.tar.gz` containing your builded release ready to be deployed.

## Deploy the release

To deploy your archived application, create your deploy configuration and use the **unarchive** strategy with the following configuration in your `group_vars/deploy.yml` file:

{{< highlight yaml >}}
manala_deploy_strategy: "unarchive"
manala_deploy_strategy_unarchive_src: "/tmp/your-app-build/current.tar.gz"
{{< /highlight >}}

<br>
Create your `deploy.yml` plabook:

{{< highlight yaml >}}
---

- hosts: deploy
  any_errors_fatal: true
  roles:
    - manala.deploy
{{< /highlight >}}

<br>
And run the deploy playbook:

{{< highlight yaml >}}
ansible-playbook ansible/deploy.yml --inventory-file=ansible/hosts --limit=deploy_production
{{< /highlight >}}

<br>
The archive will be uploaded on the server, unarchived and deleted.
