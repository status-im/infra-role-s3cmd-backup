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

# Administration

The upload job runs as a systemd service triggered by a timer.
Assuming our backup target is called `database` you can do:
```
 $ sudo systemctl status backup-database.service
● backup-database.service - "Service for uploading database backups to s3 buckets."
   Loaded: loaded (/lib/systemd/system/backup-database.service; static; vendor preset: enabled)
   Active: inactive (dead) since Fri 2020-01-24 15:08:57 UTC; 7min ago
     Docs: https://github.com/status-im/infra-role-s3cmd-backup
  Process: 15536 ExecStart=/var/lib/backups/backup_hackmd.sh (code=exited, status=0/SUCCESS)
 Main PID: 15536 (code=exited, status=0/SUCCESS)

Jan 24 15:08:44 node-01.do-ams3.todo.misc systemd[1]: Starting "Service for uploading database backups to s3 buckets."...
Jan 24 15:08:44 node-01.do-ams3.todo.misc backup_database.sh[15536]: Uploading: database_db_dump_20200124040001.sql >> s3://hackmd-backups
...
```
You can check the timer status too:
```
 $ sudo systemctl list-timers backup-database.timer
NEXT                         LEFT    LAST PASSED UNIT                  ACTIVATES
Sat 2020-01-25 00:00:00 UTC  8h left n/a  n/a    backup-database.timer backup-database.service
```
