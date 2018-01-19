==================

Docker container image with [DokuWiki](https://www.dokuwiki.org/dokuwiki) and nginx

### How to run

Assume your docker host is localhost and HTTP public port is 8000 (change these values if you need).

First, run new dokuwiki container:

    docker run -d -p 1088:80 --name dokuwiki jialei123123/docker-dokuwiki

Then setup dokuwiki using installer at URL `http://localhost:1088/install.php`

### How to make data persistent

To make sure data won't be deleted if container is removed, create an empty container named `dokuwiki-data` and attach DokuWiki container's volumes to it. Volumes won't be deleted if at least one container owns them.

    # create data container and use data continer to creatde server container
    docker run -v /data --name dokuwiki-data busybox
    docker run --volumes-from dokuwiki-data -d -p 1088:80 --name dokuwiki jialei123123/docker-dokuwiki
    or
    docker run --volumes-from dokuwiki --name dokuwiki-data busybox

    # now you can safely delete dokuwiki container
    docker stop dokuwiki && docker rm dokuwiki

    # to restore dokuwiki, create new dokuwiki container and attach dokuwiki-data volume to it
    docker run -d -p 1088:80 --volumes-from dokuwiki-data --name dokuwiki jialei123123/docker-dokuwiki
 
 ### How to backup data

    # create dokuwiki-backup.tar.gz archive in current directory using temporaty container
    docker run --rm --volumes-from dokuwiki-data -v $(pwd):/backup centos:7 tar zcvf /backup/dokuwiki-backup.tar.gz /var/dokuwiki-storage

**Note:** only these folders are backed up:

* `data/pages/`
* `data/meta/`
* `data/media/`
* `data/media_attic/`
* `data/media_meta/`
* `data/attic/`
* `conf/`

### How to restore from backup

    # create data container for persistency (之前创建过就不用再创建了)
    docker run --volumes-from dokuwiki --name dokuwiki-data busybox

    # restore from backup using temporary container
    docker run --rm --volumes-from dokuwiki-data -v $(pwd):/backup centos:7 tar xzvf /backup/dokuwiki-backup.tar.gz 
    
    #create new dokuwiki container with data container
    docker create -p 1088:80 --name dokuwiki jialei123123/docker-dokuwiki
