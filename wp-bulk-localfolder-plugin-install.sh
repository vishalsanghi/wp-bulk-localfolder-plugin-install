#!/bin/bash
# Author: Vishal Dilip Sanghi
# Install WordPress Bulk Plugin Installation from local folder on a Debian/Ubuntu VPS
# Created on: 21st May 2020
# Last Updated on: 02 June 2020

# Wordpress Installation Path
WPPATH=<your-wordpress-installation-path>

# WPI CLI Installation File Name
FILE=wp-cli.phar

# Local Plugin Path. Keep your plugins in this folder
pluginpath=./plugins

# Installed Local Plugin Path. Your installed plugin will be in this folder
ipluginpath=./installedplugins

localpluginupdate() {
	echo
	echo "========================================================"
        echo "Plugin Update Operation from Local Folder Path Started"
        echo "========================================================"
        echo
	for file in $pluginpath/*; do
	echo "Initiating the plugin installation from local folder path"
	plugin=$pluginpath/$(basename "$file")
	wp plugin install --force $plugin --activate --path=$WPPATH --allow-root
	echo "Plugin $(basename "$file") related operation completed"
	if [ -d "$ipluginpath" ]
		then
			cd $pluginpath
			mv $pluginpath/$(basename "$file") $ipluginpath/
			echo "Moved plugin zip file to $ipluginpath"
		else
			mkdir $ipluginpath
			mv $pluginpath/$(basename "$file") $ipluginpath/
			echo "Moved plugin zip file to $ipluginpath"
	fi
	echo
	echo "========================================================"
        echo "Plugin Update Operation from Local Folder Path Completed"
        echo "========================================================"
        echo
	done
}

wpcliinstall() {
 	# Starting the Wordpress installation process using wp-cli
	echo "===================================="
	echo "Please wait while we install wp-cli"
	echo "===================================="
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	cp wp-cli.phar /usr/bin/wp
	echo "=========================="
	echo "Finished installing wp-cli"
	echo "=========================="
	echo
}


if [ -f "$FILE" ]
    then
        localpluginupdate
    else
        wpcliinstall
        localpluginupdate
fi
