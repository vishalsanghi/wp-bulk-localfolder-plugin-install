## Wordpress Bulk Plugin Install from Local Folder - Shell Script

The script is used for installing multpile plugins in wordpress from local folder. This script uses WP-CLI. 

This is used for the scenarios where you don't have automatic updates available and you need to install multiple plugins.

**How to use?**

* Run the script with bash wpbulkinstalllocal.sh
* Wordpress Installation Path - WPPATH=<your-wordpress-installation-path> - Specify the path of your wordpress installation. Ex /var/www/<your-wordpress-folder>
* WPI CLI Installation File Name - FILE=wp-cli.phar - This is used for checking whether wordpress command line is installed or not.
* Local Plugin Path - pluginpath=<path-to-store-plugins> - This is the path where you will store all your zip plugin files that needs to be installed.
* Installed Local Plugin Path - ipluginpath=<path-to-move-installed-plugins> - This folder is used to move the installed plugins to other directory to avoid overlaps.
* Documentation - https://wp-cli.org/
* If you get any errors you can delete the hidden .keep file from "plugins" and "installedplugins" directory

**Disclaimer:**

* Author does not take any responsibility of your data loss or any configuration loss.

