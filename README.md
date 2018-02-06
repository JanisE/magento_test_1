## Prerequisites

* Docker (https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* Docker Compose >= 1.13 (https://docs.docker.com/install/)

## Magento test environment

The environment and software is defined by [/docker_magento/Dockerfile](/docker_magento/Dockerfile) and [/docker_magento/install_magento.sh](/docker_magento/install_magento.sh).

Branch "magento_221_with_sample" installs PHP 7.1.11, Apache 2.4.10, Magento CE/Open 2.2.1 with sample data.

## Set up Magento

This is what I do to set up Magento on my computer. Adjust paths and the like as necessary.

### Clean the previous installation

If applicable.

```bash
sudo docker ps --all
sudo docker rm magentotest1_dev_1
sudo docker rm magentotest1_db_1
sudo docker images
sudo docker rmi docker_magento

# The paths defined in "docker-compose.yml".
sudo rm -rf /home/janis/magento/v221_with_sample/db
sudo rm -rf /home/janis/magento/v221_with_sample/html
```

### Set up the new installation

```bash
mkdir -p /home/janis/magento
mkdir /home/janis/magento/v221_with_sample
cd /home/janis/magento

git clone https://github.com/JanisE/magento_test_1.git
cd magento_test_1
git checkout magento_221_with_sample
```

In `docker_magento/auth.json`, replace the username and password with your Magento Marketplace credentials.
Copy all custom modules into `docker_magento/app` folder (e.g., `docker_magento/app/code/Amasty/Base/[..]`).

Then:

```bash
cd /home/janis/magento/magento_test_1
sudo docker-compose up
```
and wait...

When everything is done (when I see messages like `mysqld: ready for connections.`, `End of list of non-natively partitioned tables`), in another terminal, I run
```bash
sudo docker exec magentotest1_dev_1 bash /root/install_magento.sh
```

When that one is over, the site is available at http://127.0.0.1:8234/magento/.
Admin may be accessed at http://127.0.0.1:8234/magento/admin as `admin:admin123`.

## Notes

To access the Magento installation files, I can use `/home/janis/magento/v221_with_sample/html` folder,

or I can connect to the environment by
```bash
sudo docker exec -it magentotest1_dev_1 bash
```


To stop the DB and Apache services, abort the docker-compose command ([Ctrl]+[c]).
