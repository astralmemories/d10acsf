#!/bin/bash

# Author: Leonardo Signorelli
# Emails: leonardo.signorelli@acquia.com, astralmemories@gmail.com
# Websites: astralmemories.com, freewebtools.net, codesnippets.freewebtools.net


# The Unlicense
# -------------
# This is free and unencumbered software released into the public domain.

# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.

# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

# For more information, please refer to <http://unlicense.org/>


# Instructions
# ------------
# 1 - Add/Copy this bash script to the root of your ACSF codebase folder (Next to the config, and docroot folders).
# 2 - Add your ACSF Application name to the acsf_app_name variable:
acsf_app_name="acquiatam2"
# 3 - Make this bash script executable with the following command:
#     chmod +x aliasgenerator.sh
# 4 - Execute this script with the following command:
#     ./aliasgenerator.sh
# 5 - Create a new Drush alias for an existing ACSF site and exit the script.
# 6 - Now you should be able to execute drush commands against the selected ACSF site with the following structure: 
#     drush @sitename.environment drush_command
# Example:
#     drush @yoursite.01live status
 

# Functions
create_new_site_alias () {

    echo "Make sure to enter the name of a site you already created in your ACSF account."
    echo "Example: If the ACSF URL assigned to your new site is site1.${acsf_app_name}.acsitefactory.com"
    echo "Enter site1"
    echo " "

    confirmation="novalue"
    while [ $confirmation != "y" ]
    do
        echo -e "Provide the name of the site you want to create a Drush alias: \c "
        read site_name
        echo " "
        echo -e "Is this site name correct?: \"$site_name\" (Yes/No/Cancel = y/n/c)"
        read confirmation

        if [ $confirmation == "c" ]; then
            # Exit the While loop
            break
        fi
    done

    if [ $confirmation == "c" ]; then
        echo " "
        echo "Cancel! Going back to the Main Menu..."
        echo " "
        # Cancel this function and go back to the Main Menu
        return
    fi

    # Generate the drush alias for this new site...
    echo " "
    echo "Generating the drush alias for $site_name.."

    # Go to  the sites folder inside the drush folder
    cd drush/sites/

    # Create a new yml file for this site
    echo "01dev:" > $site_name.site.yml
    echo "    uri: $site_name.dev-$acsf_app_name.acsitefactory.com" >> $site_name.site.yml
    echo "    host: ${acsf_app_name}01dev.ssh.enterprise-g1.acquia-sites.com" >> $site_name.site.yml
    echo "    options: {  }" >> $site_name.site.yml
    echo "    paths: { dump-dir: /mnt/tmp }" >> $site_name.site.yml
    echo "    root: /var/www/html/$acsf_app_name.01dev/docroot" >> $site_name.site.yml
    echo "    user: $acsf_app_name.01dev" >> $site_name.site.yml
    echo "    ssh: { options: '-p 22' }" >> $site_name.site.yml

    echo "01live:" >> $site_name.site.yml
    echo "    uri: $site_name.$acsf_app_name.acsitefactory.com" >> $site_name.site.yml
    echo "    host: ${acsf_app_name}01live.ssh.enterprise-g1.acquia-sites.com" >> $site_name.site.yml
    echo "    options: {  }" >> $site_name.site.yml
    echo "    paths: { dump-dir: /mnt/tmp }" >> $site_name.site.yml
    echo "    root: /var/www/html/$acsf_app_name.01live/docroot" >> $site_name.site.yml
    echo "    user: $acsf_app_name.01live" >> $site_name.site.yml
    echo "    ssh: { options: '-p 22' }" >> $site_name.site.yml

    echo "01test:" >> $site_name.site.yml
    echo "    uri: $site_name.test-$acsf_app_name.acsitefactory.com" >> $site_name.site.yml
    echo "    host: ${acsf_app_name}01test.ssh.enterprise-g1.acquia-sites.com" >> $site_name.site.yml
    echo "    options: {  }" >> $site_name.site.yml
    echo "    paths: { dump-dir: /mnt/tmp }" >> $site_name.site.yml
    echo "    root: /var/www/html/$acsf_app_name.01test/docroot" >> $site_name.site.yml
    echo "    user: $acsf_app_name.01test" >> $site_name.site.yml
    echo "    ssh: { options: '-p 22' }" >> $site_name.site.yml

    # Go back
    cd ../../

    echo " "
    echo "Ready! Going back to the Main Menu..."
    echo " "
}

# Splash screen
echo " "
echo " "
echo "              <------->"
echo "          <--------------->"
echo " <--------------------------------->"
echo " |       Drush Alias Generator     |"
echo " <--------------------------------->"
echo "          <--------------->"
echo "              <------->"

# Main Menu
selection="novalue"
while [ $selection != "2" ]
do
    echo " "
    echo "       |---------------------|"
    echo "       |      Main Menu      |"
    echo "       |---------------------|"
    echo "       | 1 - New Drush Alias |" 
    echo "       | 2 - Exit            |"
    echo "       |---------------------|"
    echo " "
    echo -e "Select a number from the Main Menu: \c "
    read selection

    case "$selection" in
        1)  echo " "
            echo "Selected: New Drush Alias"
            echo "-------------------------"
            echo " "
            # Call the function
            create_new_site_alias
           ;;
        2)  echo " "
            echo "Selected: Exit"
            echo "--------------"
           ;;
        *)  echo " "
            echo "Wrong Selection! Please try again..."
            echo " "
           ;;
    esac

done

echo " "
echo "Exiting this script..."
echo " "
