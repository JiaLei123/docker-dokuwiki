#!/bin/bash
# if we hava all data been run, then this shell can be used to package the datas


# Get date from the system
#


DATE=`date +%Y-%m-%d`
docker run --rm --volumes-from dokuwiki-data -v $(pwd):/backup ubuntu:14.04 tar zcvf /backup/dokuwiki-backup-{DATE}.tar.gz /var/dokuwiki-storage
