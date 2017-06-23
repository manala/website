---
type:               "deployment"
title:              "Deploy a Symfony app from git"
date:               "2017-06-22"
publishdate:        "2017-06-22"
draft:              true
slug:               "symfony-deploy-from-git"
description:        "Remote server automation and deployment tool - Deploy a Symfony app from git."

author_username:    "mcolin"
---

# Deploy a Symfony app from git

<br>
First at all, you must set the folder used where this application will be deployed and how many releases you want to keep: 

{{< highlight yaml >}}
# The directory where your application will be deploy
manala_deploy_dir: /srv/app

# The number of releases to keep (excluding the current release)
manala_deploy_releases: 5
{{< /highlight >}}

<br>
Using the git strategy, you must precise which repository and version to use. Version can be a branch name (like master), a tag/release name (like 1.0) or a commit hash. 

{{< highlight yaml >}}
# Git strategy
manala_deploy_strategy: git

# The git repository you want to deploy 
manala_deploy_strategy_git_repo: git@github.com/your_orga/your_repo.git

# The branch/tag/release your want to deploy
manala_deploy_strategy_git_version: master
{{< /highlight >}}

<br>
If you put your deploy configuration in the same repository that your application, you can use this command to guess the repository address from git remotes:

{{< highlight yaml >}}
# Guess the repository adresse from the current remote repository
manala_deploy_strategy_git_repo: "{{ lookup('pipe','git ls-remote --get-url origin') }}"
{{< /highlight >}}

<br>
Then comes the Symfony parts:

{{< highlight yaml >}}
# parameters.yml will be shared accross releases
manala_deploy_shared_files:
  - app/config/parameters.yml

# Logs and sessions will be shared too
manala_deploy_shared_dirs:
  - var/logs
  - var/sessions

# Test and dev front controller must be removed
manala_deploy_removed:
  - web/app_dev.php
  - web/app_test.php

# Set write permissions to Symfony writable directories
manala_deploy_writable_dirs_default:
  # if your app user and your deploy user are in the same group
  mode:   ug=rwx,o=rx
  follow: true
  # if you want to use ACLs (replace www-data by your app user)
  raw: |
    setfacl -R -m u:"www-data":rwX -m u:`whoami`:rwX %(dir)s && \
    setfacl -dR -m u:"www-data":rwX -m u:`whoami`:rwX %(dir)s

manala_deploy_writable_dirs:
  - var/cache
  - var/logs
  - var/sessions
  
# Then run all commands required to complete the deploy like:
manala_deploy_tasks:
  # Composer install
  - command: composer install --verbose --no-progress --no-interaction --prefer-dist --optimize-autoloader --no-dev
  # Symfony cache warmup
  - command: bin/console cache:warmup --no-debug
  # Migrations
  - command: bin/console doctrine:migrations:migrate --no-debug --no-interaction
{{< /highlight >}}

<br>
# Dealing with Symfony asset version

<br>
Symfony allow you to add a version number at the end of your assets path to invalidate client cache when assets change with the following configuration:

{{< highlight yaml >}}
# config.yml
framework:
  templating:
    assets_version: "%assets_version%"
{{< /highlight >}}

<br>
The `manala.deploy` roles comes with two tasks to handle asset version.

If you define your `assets_version` parameters in `parameters.yml`, then use the `symfony_assets_version` task to automatically update the version when during the deploy. 

{{< highlight yaml >}}
# group_vars/deploy.yml
manala_deploy_tasks:
  - symfony_assets_version
{{< /highlight >}}

<br>
Or, you can define your `assets_version` parameters in a `assets_version.yml` file which is imported in the `config.yml` file. Then use the `symfony_assets_version_file` task:

{{< highlight yaml >}}
# group_vars/deploy.yml
manala_deploy_tasks:
  - symfony_assets_version_file
{{< /highlight >}}

<br>
# Multistage

You may want use multistage to deploy your Symfony application on a **production** or a **staging** environment.

The `group_vars/deploy.yml` file contain global deploy configuration. You can override this configuration for multistage environments by creating `group_vars/deploy_[ENV].yml` files.

For exemple `deploy_production.yml` will override deploy configuration for production environment and `deploy_staging.yml` will override deploy configuration for staging environment.

{{< highlight yaml >}}
# Command to run deploy for production
$ ansible-playbook ansible/deploy.yml --inventory-file=ansible/hosts --limit=deploy_production

# Command to run to deploy for staging
$ ansible-playbook ansible/deploy.yml --inventory-file=ansible/hosts --limit=deploy_staging
{{< /highlight >}}

<br>
Then you can set a different configuration for both environment. Typically you can keep `app_dev.php` frontend on staging for debug purpose and still remove it from production releases.

{{< highlight yaml >}}
# group_vars/deploy_staging.yml
manala_deploy_removed:
  - web/app_test.php
  
# group_vars/deploy_production.yml
manala_deploy_removed:
  - web/app_dev.php
  - web/app_test.php
{{< /highlight >}}
