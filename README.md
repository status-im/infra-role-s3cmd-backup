# Description

This role is intended for uploading backups to DigitalOcean Spaces using the [`s3cmd`](https://s3tools.org/s3cmd) script.

# Installation

In your `requirements.yml` file:
```yaml
- name: infra-role-s3cmd-backup
  src: git@github.com:status-im/infra-role-s3cmd-backup.git
  scm: git
```

# Usage

This role should be included by anothe role and ran with certain variables:
```yaml
- name: Configure Ghost backups
  include_role:
    name: s3cmd-backup
  vars:
    backup_name: my-app-backups
    backup_number: 1
    backup_hour: 4
    backup_day: '*/4'
    backup_directory: '/var/tmp/backups'
    backup_base_domain: 'ams3.digitaloceanspaces.com'
    backup_bucket_name: 'my-app-backups'
    backup_access_key: 'ACCESS_KEY'
    backup_secret_key: 'SECRET_KEY'
```

If you want to use S3 you can set:
```yaml
backup_base_domain: s3.amazonaws.com
```
