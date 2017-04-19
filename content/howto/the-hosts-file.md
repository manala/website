---
type:               "post"
title:              "The hosts file"
date:               "2016-03-10"
publishdate:        "2016-03-10"
draft:              true
slug:               "the-hosts-file"
description:        "Defining my hosts and variables"

author_username:    "gfaivre"
---

# The hosts file

First have a look at this essential part, how to declare my hosts properly ?
We chose not to reinvent the wheel and for most of parts to follow the Ansible recommendations.
Main goal is to keep it short (far as possible), because soon or later we will potentially have a bunch of boxes in there ...

## Hosts

We are beginning by declaring our «Infrastructure» hosts, meaning the containers needed by our cloud to work properly.

{{< highlight shell >}}
# Infra
ns-1     ansible_ssh_host=ns-1.manala.example
ns-2     ansible_ssh_host=ns-2.manala.example
lb-1     ansible_ssh_host=lb-3.manala.example
lb-2     ansible_ssh_host=lb-4.manala.example
{{< /highlight >}}

Now we are able to resolve our containers' names and to have a load balanced entry point for HTTP/HTTPS requests.

We should now have somme applications containers:

{{< highlight shell >}}
# App
web-1.manala        ansible_ssh_host=XXX.XXX.XXX.XXX
web-2.manala        ansible_ssh_host=XXX.XXX.XXX.XXX

mariadb-1.manala    ansible_ssh_host=mariadb-1.manala.example
mariadb-2.manala    ansible_ssh_host=mariadb-1.manala.example
mariadb-3.manala    ansible_ssh_host=mariadb-1.manala.example
{{< /highlight >}}

The `ansible_ssh_host` is not a mandatory parameter if you prefer to use complete host name in your groups definition **BUT** it can be usefull (and also more confortable) to manipulate shorted names and to avoid a well known «string length» issue when using an EC2 public DNS name for example ;)

## Variables

For advanced use you can have a look on the [Ansible documentation](http://docs.ansible.com/ansible/intro_inventory.html#group-variables).

{{< highlight shell >}}
[all:vars]
ansible_become=true
ansible_sudo_flags=-H -S

[dc_aws]
web-1.manala
web-2.manala

[dc_aws:vars]
ansible_ssh_common_args='-o ControlPath=~/.ansible/cp/%C'
{{< /highlight >}}

Defining variables this way is a good point to factorize the shared variables for several groups/environments, we can define them on a the global environment `all` and on a dedicated group as above for our AWS datacenter.

## Groups

We have hosts, we have variables and we can now define our `groups` used to apply a same environment definition on sibling containers.

{{< highlight shell >}}
[ns]
ns-[1:2]

[lb]
lb-[1:4]

[backup]
backup-[1:1]

[mysql_manala]
mysql-[1:3].manala

[app]
web-1.manala
web-2.manala
{{< /highlight >}}

And voila ! We are ready to go further and have a look on the content of the [`group_vars` directory](/howto/fullfil-my-group-vars).
