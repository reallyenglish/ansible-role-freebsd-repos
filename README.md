# ansible-role-freebsd-repos

Configures alternate package repository for FreeBSD

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `freebsd_repos_dir` | path to pkg repo dir | `/usr/local/etc/pkg/repos` |
| `freebsd_repos` | dict of repository configs (see below) | `{}` |

## `freebsd_repos`

This is a dict with key value pair described in `pkg.conf(5)`. In addtions to
the keywords listed in `pkg.conf(5)`, a key, `state`, must be present with a
value, either `present` or `absent`

The following dict creates `/usr/local/etc/pkg/repos/FreeBSD.conf`, and
effectively disables the default repository.

```yaml
freebsd_repos:
  FreeBSD:
    enabled: "false"
    state: present
```

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-freebsd-repos
  vars:
    freebsd_repos:
      FreeBSD:
        enabled: "false"
        state: present
      10.3.build:
        url: pkg+http://10.3.build.reallyenglish.com/${ABI}
        enabled: "true"
        mirror_type: srv
        signature_type: none
        priority: 100
        state: present

      10.1.build:
        url: pkg+http://10.1.build.reallyenglish.com/${ABI}
        enabled: "true"
        mirror_type: srv
        signature_type: none
        priority: 100
        state: present
```

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
