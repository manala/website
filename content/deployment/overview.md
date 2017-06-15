---
type:               "deployment"
title:              "Remote server automation and deployment tool"
date:               "2017-06-10"
publishdate:        "2017-06-10"
draft:              true
slug:               "overview"
description:        "Remote server automation and deployment tool."

author_username:    "gfaivre"
---

# Prerequisites

To get up and running you will need the following:

- Ansible 2.+
- Remote ssh access on the target server

# Overview

«Manala deploy» is a remote server deployment tool.

There's plenty usefull tools to make a clean deployment, you probably know Fabric, Capistrano or UrbanCode which are known solutions but implies to have «another» tool in you stack.
Because we are using [Ansible](https://www.ansible.com/) for lot of stuff why don't do deployment either ?

Manala bring a lightweight deployment solution, probably not so advanced compare to mainstream tools, but with the advantage to keep a big part of the project under the same spirit. In fact’s there’s two objectives in our approch:

- Don't introduce a new technology in the existing and complex stack of our projects
- Allow developpers to understand, write and being autonomous with their deployments

# Ok but what's a remote server deployment tool ?

It's quite simple, with this kind of solution you can automate your deployment workflows, which mean:

- Reliably deploy web applications
- Script arbitrary workflows over SSH
- Automate common (and often forgotten) tasks

And it's looks like a common Ansible execution task:

{{< highlight shell >}}
PLAY [Api (demo)] *************************************************************************************

TASK [Gathering Facts] ********************************************************************************
ok: [demo]

TASK [manala.deploy : setup > Create structure] *******************************************************
ok: [demo] => {"ansible_facts": {"deploy_helper": {"current_path": "/srv/app/api/current",
"new_release": "20170614141041", "new_release_path": "/srv/app/api/releases/20170614141041",
"previous_release": "20170614125936", "previous_release_path": "/srv/app/api/releases/20170614125936",
"project_path": "/srv/app/api", "releases_path": "/srv/app/api/releases",
"shared_path": "/srv/app/api/shared", "unfinished_filename": "DEPLOY_UNFINISHED"}}, "changed": false, "state": "present"}

TASK [manala.deploy : include] ************************************************************************
included: /Volumes/Elao/workspace/infra/manala/roles/manala.deploy/tasks/strategy/git.yml for demo

TASK [manala.deploy : strategy/git > Cached repository] ***********************************************
ok: [demo] => {"after": "a8e8d1df26adbca42fa2e3cb33646c4b2874c1ee", "before": "a8e8d1df26adbca42fa2e3cb33646c4b2874c1ee",
"changed": false, "remote_url_changed": false}

TASK [manala.deploy : strategy/git > Export repository] ***********************************************
{{< /highlight >}}
