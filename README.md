# :warning: LEGACY WARNING :warning:

This role is no longer actively used and has been retired in favor of [Restic](https://restic.net/).

# Description

This role is intended for uploading backups to DigitalOcean Spaces using the [`s3cmd`](https://s3tools.org/s3cmd) script.

# Installation

In your `requirements.yml` file:
```yaml
- name: infra-role-s3cmd-upload
  src: git@github.com:status-im/infra-role-s3cmd-upload.git
  scm: git
```

# Usage

This role should be included by anothe role and ran with certain variables:
```yaml
- name: Configure Ghost backups
  include_role:
    name: s3cmd-upload
  vars:
    s3cmd_upload_name: 'my-app-backups'
    s3cmd_upload_number: 1
    s3cmd_upload_hour: 4
    s3cmd_upload_day: '*/4'
    s3cmd_upload_directory: '/var/tmp/backups'
    s3cmd_upload_base_domain: 'ams3.digitaloceanspaces.com'
    s3cmd_upload_bucket_name: 'my-app-backups'
    s3cmd_upload_access_key: 'ACCESS_KEY'
    s3cmd_upload_secret_key: 'SECRET_KEY'
```

If you want to use S3 you can set:
```yaml
s3cmd_upload_base_domain: 's3.amazonaws.com"
```

# Administration

The upload job runs as a systemd service triggered by a timer.
Assuming our backup target is called `database` you can do:
```
 $ sudo systemctl status upload-database.service
● upload-database.service - "Service for uploading database backups to s3 buckets."
   Loaded: loaded (/lib/systemd/system/upload-database.service; static; vendor preset: enabled)
   Active: inactive (dead) since Fri 2020-01-24 15:08:57 UTC; 7min ago
     Docs: https://github.com/status-im/infra-role-s3cmd-upload
  Process: 15536 ExecStart=/usr/local/bin/upload_databasse.sh (code=exited, status=0/SUCCESS)
 Main PID: 15536 (code=exited, status=0/SUCCESS)

Jan 24 15:08:44 node-01.do-ams3.todo.misc systemd[1]: Starting "Service for uploading database backups to s3 buckets."...
Jan 24 15:08:44 node-01.do-ams3.todo.misc upload_database.sh[15536]: Uploading: database_db_dump_20200124040001.sql >> s3://database-backups
...
```
You can check the timer status too:
```
 $ sudo systemctl list-timers upload-database.timer
NEXT                         LEFT    LAST PASSED UNIT                  ACTIVATES
Sat 2020-01-25 00:00:00 UTC  8h left n/a  n/a    upload-database.timer upload-database.service
```
