---
type:               "post"
title:              "IDE integration"
date:               "2016-03-10"
publishdate:        "2016-03-10"
draft:              true
slug:               "ide-integration"
description:        "Integrate your IDE"

author_username:    "mcolin"
---

# Configuration

Xdebug and Symfony can generate links to your files in there error reports (and Symfony profiler). To enable this behavior, configure the `xdebug.file_link_format` ini parameter.

Add the following configuration in `group_vars/app_local.yml` (or copy it from `group_vars/app_local.yml.sample`). This configuration works for [PHPStorm](https://www.jetbrains.com/phpstorm/), check out the format for other IDE. 

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
