laravel
=======
Laravel environment with Berkshelf Chef and Vagrant support
* Master: [![Build Status](https://api.travis-ci.org/sergiuionescu/laravel.svg?branch=master)](http://travis-ci.org/sergiuionescu/laravel)
* Dev: [![Build Status](https://api.travis-ci.org/sergiuionescu/laravel.svg?branch=dev)](http://travis-ci.org/sergiuionescu/laravel)

- builds a [lamp](https://github.com/sergiuionescu/lamp) environment
- exposes a LWRP that allows setting up one or multiple laravel applications

Requirements(prod)
------------------
* chef-solo: https://downloads.chef.io/chef-client/
* berkshelf: http://berkshelf.com/

Requirements(dev)
-----------------
* vagrant: https://www.vagrantup.com/downloads.html
* chef dk: https://downloads.getchef.com/chef-dk/
* virtualbox: https://www.virtualbox.org/wiki/Downloads

Testing the dev environment
---------------------------
- Clone the repository
- Go to the project root
- Run kitchen converge

Recipes
-------
- default - installs basic services and the laravel installer
- test - installs laravel under '/var/www/laravel'

LWRP
----

laravel_app
-----------
Create/delete a laravel application

Actions
-------
- :create - installs a new laravel application via composer
- :delete - deletes the application folder

Attribute parameters
--------------------
- app_name: name attribute. Determines the installation path relative to '/var/www'.

```
#install the laravel application under '/var/www/laravel'
laravel_app "laravel" do
  action :create
end
```

How to test dev environment
---------------------------
- Clone the repository
- Go to the project root
- Run "kitchen converge"

Customizing your dev environment
--------------------------------
The role used to provision the dev environment, you can create your own role to fit your needs:
```json
{
    "name": "laravel",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "description": "Laravel environment configuration.",
    "run_list": [
        "recipe[laravel]",
        "recipe[lamp::nfs]",
        "recipe[lamp::xdebug]"
    ],
    "default_attributes": {
        "lamp": {
            "xdebug": {
                "directives": {
                    "remote_host": "10.0.2.2",
                    "remote_enable": 0,
                    "remote_autostart": 1
                }
            }
        }
    }
}
```

Details:
```json
"run_list": [
        "recipe[laravel]",
        "recipe[lamp::nfs]",
        "recipe[lamp::xdebug]"
    ],
```
The recipes lamp::nfs and lamp::xdebug are only required for the dev environment to expose a nfs share of your /var/www directory and install the xdebug extension for php.


```json
"mysql": {
    "server_root_password": "",
    "server_repl_password": "",
    "server_debian_password": ""
}
```
Configure your mysql dev server credentials.

```json
"lamp": {
    "xdebug": {
        "directives": {
            "remote_host": "10.0.2.2",
            "remote_enable": 0,
            "remote_autostart": 1
        }
    }
}
```
Set the xdebug configuration, all xdebug configuration directives are supported here. In this example xdebug is connecting back on the vm's NAT interface, 
configured to start the debugging session automatically but disabled. You need to enable it manually by editing your xdebug.ini.

Customizing the role in production
----------------------------------

An example role for production would be the following:
```json
{
    "name": "Laravel",
    "chef_type": "role",
    "json_class": "Chef::Role",
    "description": "Laravel environment configuration.",
    "run_list": [
        "recipe[laravel]"
    ],
    "default_attributes": {
        "mysql": {
            "server_root_password": "supersecretpassword",
            "server_repl_password": "supersecretpassword",
            "server_debian_password": "supersecretpassword"
        }
    }
}
```
Notice that you can drop the dependencies on nfs and xdebug, you should also set a more secure password for your mysql server.

Source mounts
-------------

The project root directory is mounted inside the dev virtual machine directory under the /vagrant path when using both kitchen converge or vagrant up to launch the machine.
