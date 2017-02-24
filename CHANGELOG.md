### Feature

#### Multiple repository support

It is now possible to support multiple repositories with`freebsd_repos`.

### Incompatibility

The following variables have been removed.

* `freebsd_repos_name`
* `freebsd_repos_url`
* `freebsd_repos_mirror_type`
* `freebsd_repos_mirror_signature_type`
* `freebsd_repos_priority`
* `freebsd_repos_disable_default_repository`

Use `freebsd_repos`, which supports all ketwords described in
`pkg.conf(5)`.

`freebsd_repos_disable_default_repository` should be replaced with:

```yaml
freebsd_repos:
  FreeBSD:
    enabled: "false"
    state: present
```


## Release 1.1.0

* 01398c3 [bugfix] validate pkg.conf(5) (#12)
* ffd8bff Merge pull request #10 from reallyenglish/support_priority
* 03a7ca5 support priority in the custom package site conf
* ab16b1b Merge pull request #8 from reallyenglish/QA
* f26b8b2 QA
* 8288574 QA (#7)
* fda44d0 add tags (#5)

## 1.0.0

* initial release
