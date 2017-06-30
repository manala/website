
## Configuration

This directory will contains all the deployment configuration files.
The base file will be the `deploy.yml` it will contains common instructions between environments and will look like:

{{< highlight yaml >}}
---

#######
# Dir #
#######

manala_deploy_dir: /srv/app

############
# Releases #
############

manala_deploy_releases: 5

############
# Strategy #
############

manala_deploy_strategy: git

manala_deploy_strategy_git_repo:    git@github.com:Elao/myproject.git
manala_deploy_strategy_git_version: master

##########
# Shared #
##########

manala_deploy_shared_files:
  - app/config/parameters.yml
  - app/config/hr.yml

manala_deploy_shared_dirs:
  - var/logs
  - var/sessions

{{< /highlight >}}



### Options

- **`manala_deploy_dir`:** Will target the remote directory where the application will be deploy.
- **`manala_deploy_release`:** Allow tou to specify the number of releases you want to keep (default is 5).
- **`manala_deploy_strategy`:** Deployment strategy can be `git` or `synchronize` they will be explain further.

#### Git strategy

In this case we want to checkout directly from the repository to the target server.

- **`manala_deploy_strategy_git_repo`:** As you probably guess, concerne the url of the repository
- **`manala_deploy_strategy_git_version`:** The branch/tag considered.

#### Synchronize strategy

This one allow you to run local tasks before pushing files directly to the server.

- **`manala_deploy_strategy_synchronize_src`:** Where we should find files to push on the server.
