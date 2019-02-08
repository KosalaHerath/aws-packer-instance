
#!/bin/bash
# Select the give wso2 product and database management system. Then run the
# launcher files that related to given ifiormation.

# Define parameter values by replacing strings.
db_engine='CF_DBMS_NAME'
db_engine_version='CF_DBMS_VERSION'
wso2_product='CF_PRODUCT_NAME'
wso2_product_version='CF_PRODUCT_VERSION'
cf_db_username='CF_DB_USERNAME'
cf_db_password='CF_DB_PASSWORD'
cf_db_host='CF_DB_HOST'
cf_db_port='CF_DB_PORT'

# Path prameters
wso2_product_path="/etc/puppet/code/environments/production/modules/installers/files"
db_center_path="/home/ubuntu/dbcenter"

# Regular Colors
red_font='\033[0;31m'          # Red
green_font='\033[0;32m'        # Green
no_color_font='\033[0m'        # No Color

# An error exit function
error_exit()
{
	echo -e "$1" 1>&2
  exit 1
}

echo "Database generating process starting..."

# Copy product database scripts
unzip -q "$wso2_product_path/$wso2_product-$wso2_product_version.zip" -d "$db_center_path/tmp/" || error_exit "${red_font}Error occured during unziping product package. Abort process...${no_color_font}"
[ -d "$db_center_path/dbscripts" ] && rm -r "$db_center_path/dbscripts"
cp -r "$db_center_path/tmp/$wso2_product-$wso2_product_version/dbscripts" "$db_center_path/" || error_exit "${red_font}Error occured during copying database scripts. Abort process...${no_color_font}"
echo -e "${green_font}Product database scripts are copied${no_color_font}" && rm -r "$db_center_path/tmp/"

# Select given wso2 product and run database scripts.
if [[ $wso2_product = "wso2am" ]]; then
    bash "$db_center_path/apim_db_generator.sh" $db_engine $db_engine_version $wso2_product_version $cf_db_username $cf_db_password $cf_db_host $cf_db_port
elif [[ $wso2_product = "wso2ei" ]]; then
    bash "$db_center_path/ei_db_generator.sh" $db_engine $db_engine_version $wso2_product_version $cf_db_username $cf_db_password $cf_db_host $cf_db_port
elif [[ $wso2_product = "wso2is" ]]; then
    bash "$db_center_path/is_db_generator.sh" $db_engine $db_engine_version $wso2_product_version $cf_db_username $cf_db_password $cf_db_host $cf_db_port
elif [[ $wso2_product = "wso2esb" ]]; then
    bash "$db_center_path/esb_db_generator.sh" $db_engine $db_engine_version $wso2_product_version $cf_db_username $cf_db_password $cf_db_host $cf_db_port
else
    error_exit "${red_font}Received product name is not available. Abort process...${no_color_font}"
fi

echo -e "Process finished"
