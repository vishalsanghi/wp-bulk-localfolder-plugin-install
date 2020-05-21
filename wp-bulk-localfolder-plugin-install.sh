#!/bin/bash
# Author: Vishal Dilip Sanghi
# Install WordPress Bulk Plugin Installation from local folder on a Debian/Ubuntu VPS
# Created on: 21st May 2020
# Last Updated on: 21st May 2020

# Wordpress Installation Path
WPPATH=<your-wordpress-installation-path>

# WPI CLI Installation File Name
FILE=wp-cli.phar

# Local Plugin Path
pluginpath=<path-to-store-plugins>

# Installed Local Plugin Path
ipluginpath=<path-to-move-installed-plugins>

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

if [ -f "$FILE" ]
    then
        localpluginupdate
    else
        wpcliinstall
        localpluginupdate
fi
