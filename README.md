## Magento test environment

For reproducing https://github.com/magento/magento2/issues/12146

The environment and software is defined by [/docker_magento/Dockerfile](/docker_magento/Dockerfile) and [/docker_magento/install_magento.sh](/docker_magento/install_magento.sh).

At the moment, it installs PHP 7.1.11, Apache 2.4.10, Magento CE/Open 2.2.1 without sample data.

## Set up Magento

This is what I do to set up Magento on my computer. Adjust paths and the like as necessary.

```bash
mkdir -p /home/janis/magento
cd /home/janis/magento

git clone https://github.com/JanisE/magento_test_1.git
cd magento_test_1
```

In `docker_magento/auth.json`, replace the username and password with my Magento Marketplace credentials. Then:

```bash
cd /home/janis/magento/magento_test_1
sudo docker-compose up
```
and wait...

When everything is done (when I see messages like `mysqld: ready for connections.`, `End of list of non-natively partitioned tables`), in another terminal, I run
```bash
sudo docker exec magentotest1_dev_1 bash /root/install_magento.sh
```

When that one is over (the last output being `Nothing to import.`), the site is available at http://127.0.0.1:8234/magento/, where I create a new account as a customer.

Then I go to admin at http://127.0.0.1:8234/magento/admin and log in as `admin:admin123`.

## Notes

To access the Magento installation files, I can use `/home/janis/magento/magento_test_1/html` folder,

or I can connect to the environment by
```bash
sudo docker exec -it magentotest1_dev_1 bash
```


To stop the DB and Apache services, abort the docker-compose command ([Ctrl]+[c]).
