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

	# Loop to update the plugin one by one containing in the plugins folders
	for file in $pluginpath/*; do
	echo "Initiating the plugin installation from local folder path"

	# Adding the path of the to be installed plugins with all the plugin files
	plugin=$pluginpath/$(basename "$file")

	# Wordpress CLI commnad to force install the plugin, at specified wordpress installation folder and activating it
	wp plugin install --force $plugin --activate --path=$WPPATH --allow-root

	# Displays the plugin name installed
	echo "Plugin $(basename "$file") related operation completed"

	# Moving data from plugin directory to installed plugin directory post installation
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
	# Calling the fuction to install the plugin
	localpluginupdate
    else
        # Calling WPCLI installation function to install WPCLI and then install plugin 
	wpcliinstall
        localpluginupdate
fi
