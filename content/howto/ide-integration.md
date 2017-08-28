---
type:               "post"
title:              "IDE integration"
date:               "2017-08-28"
publishdate:        "2017-08-28"
draft:              true
slug:               "ide-integration"
description:        "Integrate your IDE"

author_username:    "mcolin"
---

# Configuration

Xdebug and Symfony can generate links to your files in there error reports (and Symfony profiler). To enable this behavior, configure the `xdebug.file_link_format` ini parameter.

Add the following configuration in `group_vars/app_local.yml` (or copy it from `group_vars/app_local.yml.sample`). This configuration works for [PhpStorm](https://www.jetbrains.com/phpstorm/), check out the format for other IDE below. 

{{< highlight yaml >}}
---

app_local_patterns:

  #######
  # Php #
  #######

  php_configs:
    - file: app_local.ini
      config:
        # Symfony ide integration, see: http://symfony.com/doc/current/reference/configuration/framework.html#ide
        - xdebug.file_link_format: "'phpstorm://open?file=%f&line=%l&/srv/app>/path/to/your/project'"
{{< /highlight >}}

<br>
Replace `/path/to/your/project` by your project root path on your host.

Then, you have to provision your VM doing `make provision` (or `make provision-php` to provision php only).

*Note the `group_vars/app_local.yml` file is git ignored and shoud not be commited as it contains configuration that works on your machine only.*

# Formats

| IDE          | format                               |
|--------------|--------------------------------------|
| TextMate     | txmt://open?url=file://%%f&line=%%l  |
| MacVim       | mvim://open?url=file://%%f&line=%%l  |
| Emacs        | emacs://open?url=file://%%f&line=%%l |
| Sublime Text | subl://open?url=file://%%f&line=%%l  |
| PhpStorm     | phpstorm://open?file=%%f&line=%%l    |

