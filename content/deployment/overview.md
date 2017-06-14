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

And it's looks like:
