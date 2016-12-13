# ansible-role-freebsd-repos

Configures alternate package repository for FreeBSD

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| freebsd\_repos\_dir                       | path to pkg repo dir | /usr/local/etc/pkg/repos |
| freebsd\_repos\_name                      | name of the repo | reallyenglish |
| freebsd\_repos\_url                       | URL of the repo (required) | "" |
| freebsd\_repos\_mirror\_type              | MIRROR\_TYPE, see `pkg.conf(5)` | srv |
| freebsd\_repos\_mirror\_signature\_type   | SIGNATURE\_TYPE, see `pkg.conf(5)` | none |
| `freebsd_repos_priority`                  | `PRIORITY`, see `pkg.conf(5)` | 0 |
| `freebsd_repos_disable_default_repository` | If `true`, disable the official default package site | `true` |

Created by [yaml2readme.rb](https://gist.github.com/trombik/b2df709657c08d845b1d3b3916e592d3)


# Dependencies

None

# Example Playbook

    - hosts: localhost
      roles:
        - ansible-role-freebsd-repos
      vars:
        freebsd_repos_url: pkg+http://10.3.build.reallyenglish.com/${ABI}
    freebsd_repos_priority: 100

# License

```
Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [ansible-role-init](https://gist.github.com/trombik/d01e280f02c78618429e334d8e4995c0)
