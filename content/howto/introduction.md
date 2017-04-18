---
type:               "post"
title:              "Introduction - Being classy"
date:               "2016-03-10"
publishdate:        "2016-03-10"
draft:              true
slug:               "Introduction-being-classy"
description:        "How to organize my Ansible project"

author_username:    "gfaivre"
---

# Introduction «being classy»

One of the essential rules of any project is organization.
We have been working on the Manala project for 2 years now and we are thinking have been successful in the mean of «organization».

The following tutorials are made to make your life easy when starting a new provisioning project with Ansible, this is not **THE** good way to go but **OUR** good way to make things:

* Simple
* Powerfull
* Organized

And most of all, maintainable.

The main structure of a standard manala project is the following

```
├── files
├── group_vars
├── host_vars
├── roles
├── hosts
├── playbook.yml
├── README.md
├── templates
└── roles.yml
```

We will now begin by defining the [hosts file](/howto/the-hosts-file).
