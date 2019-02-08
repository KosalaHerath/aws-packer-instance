#!/bin/bash
# Run EI database scripts from generate databases.

# Define parameter values by aguments.
db_engine="$1"
db_engine_version="$2"
wso2_product_version="$3"
cf_db_username="$4"
cf_db_password="$5"
cf_db_host="$6"
cf_db_port="$7"

# Define path parameters
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

echo "Database script running process starting..."

# Create databases for EI
if [[ $db_engine = "postgres" ]]; then
    # DB Engine : Postgres
    export PGPASSWORD=$cf_db_password
		# Crete databases
    psql -U $cf_db_username -h $cf_db_host -p $cf_db_port -d postgres -f "$db_center_path/ei/ei_db_create_postgres.sql"
		# Crete tables for user database
		sed -i '1s/^/\\c WSO2EI_USER_DB;\n\n/' "$db_center_path/dbscripts/postgresql.sql"
		psql -U $cf_db_username -h $cf_db_host -p $cf_db_port -d postgres -f "$db_center_path/dbscripts/postgresql.sql"
    sed -i '1s/^/\\c WSO2EI_USER_DB;\n\n/' "$db_center_path/dbscripts/identity/postgresql.sql"
		psql -U $cf_db_username -h $cf_db_host -p $cf_db_port -d postgres -f "$db_center_path/dbscripts/identity/postgresql.sql"
		# Crete tables for reg database
		sed -i '1s/.*/\\c WSO2EI_INTEGRATOR_GOV_DB;/' "$db_center_path/dbscripts/postgresql.sql"
		psql -U $cf_db_username -h $cf_db_host -p $cf_db_port -d postgres -f "$db_center_path/dbscripts/postgresql.sql"
		sed -i '1s/.*/\\c WSO2EI_INTEGRATOR_GOV_DB;/' "$db_center_path/dbscripts/identity/postgresql.sql"
		psql -U $cf_db_username -h $cf_db_host -p $cf_db_port -d postgres -f "$db_center_path/dbscripts/identity/postgresql.sql"
elif [[ $db_engine = "mysql" ]]; then
    # DB Engine : MySQL
    echo "MySQL DB Engine Selected! Running WSO2-EI $wso2_product_version DB Scripts for MySQL..."
    if [[ $db_engine_version = "5.7" ]]; then
				# Crete databases
        mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/ei/ei_db_create_mysql5.7.sql"
				# Crete tables for user database
				sed -i '1s/^/USE WSO2EI_USER_DB;\n\n/' "$db_center_path/dbscripts/mysql5.7.sql"
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/dbscripts/mysql5.7.sql"
				sed -i '1s/^/USE WSO2EI_USER_DB;\n\n/' "$db_center_path/dbscripts/identity/mysql5.7.sql"
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/dbscripts/identity/mysql5.7.sql"
				# Crete tables for reg database
				sed -i '1s/.*/USE WSO2EI_INTEGRATOR_GOV_DB;/' "$db_center_path/dbscripts/mysql5.7.sql"
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/dbscripts/mysql5.7.sql"
				sed -i '1s/.*/USE WSO2EI_INTEGRATOR_GOV_DB;/' "$db_center_path/dbscripts/identity/mysql5.7.sql"
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/dbscripts/identity/mysql5.7.sql"
    else
				# Crete databases
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/ei/ei_db_create_mysql.sql"
				# Crete tables for user database
				sed -i '1s/^/USE WSO2EI_USER_DB;\n\n/' "$db_center_path/dbscripts/mysql.sql"
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/dbscripts/mysql.sql"
				sed -i '1s/^/USE WSO2EI_USER_DB;\n\n/' "$db_center_path/dbscripts/identity/mysql.sql"
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/dbscripts/identity/mysql.sql"
				# Crete tables for reg database
				sed -i '1s/.*/USE WSO2EI_INTEGRATOR_GOV_DB;/' "$db_center_path/dbscripts/mysql.sql"
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/dbscripts/mysql.sql"
        sed -i '1s/.*/USE WSO2EI_INTEGRATOR_GOV_DB;/' "$db_center_path/dbscripts/identity/mysql.sql"
				mysql -u $cf_db_username -p$cf_db_password -h $cf_db_host -P $cf_db_port < "$db_center_path/dbscripts/identity/mysql.sql"
    fi
elif [[ $db_engine =~ 'oracle-se' ]]; then
		# DB Engine : Oracle
		echo "Oracle DB Engine Selected! Running WSO2-EI $wso2_product_version DB Scripts for Oracle..."
		# Create users to the required DB
		echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> "$db_center_path/dbscripts/ei_oracle_user.sql"
		echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_INTEGRATOR_GOV_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_INTEGRATOR_GOV_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> "$db_center_path/dbscripts/ei_oracle_user.sql"

		echo "CREATE USER WSO2EI_USER_DB IDENTIFIED BY $cf_db_password;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_USER_DB;" >> "$db_center_path/dbscripts/ei_oracle_user.sql"
		echo "CREATE USER WSO2EI_INTEGRATOR_GOV_DB IDENTIFIED BY $cf_db_password;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_INTEGRATOR_GOV_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_INTEGRATOR_GOV_DB;" >> "$db_center_path/dbscripts/ei_oracle_user.sql"
		# Create the tables
		echo exit | sqlplus64 "$cf_db_username/$cf_db_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=$cf_db_host)(Port=$cf_db_port))(CONNECT_DATA=(SID=WSO2EIDB)))" @$db_center_path/dbscripts/ei_oracle_user.sql
		echo exit | sqlplus64 "WSO2EI_USER_DB/$cf_db_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=$cf_db_host)(Port=$cf_db_port))(CONNECT_DATA=(SID=WSO2EIDB)))" @$db_center_path/dbscripts/oracle.sql
    echo exit | sqlplus64 "WSO2EI_USER_DB/$cf_db_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=$cf_db_host)(Port=$cf_db_port))(CONNECT_DATA=(SID=WSO2EIDB)))" @$db_center_path/dbscripts/identity/oracle.sql
    echo exit | sqlplus64 "WSO2EI_INTEGRATOR_GOV_DB/$cf_db_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=$cf_db_host)(Port=$cf_db_port))(CONNECT_DATA=(SID=WSO2EIDB)))" @$db_center_path/dbscripts/oracle.sql
		echo exit | sqlplus64 "WSO2EI_INTEGRATOR_GOV_DB/$cf_db_password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=$cf_db_host)(Port=$cf_db_port))(CONNECT_DATA=(SID=WSO2EIDB)))" @$db_center_path/dbscripts/identity/oracle.sql
elif [[ $db_engine =~ 'sqlserver-se' ]]; then
    # DB Engine : SQLServer
    echo "SQL Server DB Engine Selected! Running WSO2-EI $wso2_product_version DB Scripts for SQL Server..."
		# Crete databases
    sqlcmd -S $cf_db_host -U $cf_db_username -P $cf_db_password -i "$db_center_path/ei/ei_db_create_sql_server.sql"
		# Crete tables for user database
		sed -i '1s/^/USE WSO2EI_USER_DB;\nGO\n\n/' "$db_center_path/dbscripts/mssql.sql"
		sqlcmd -S $cf_db_host -U $cf_db_username -P $cf_db_password -i "$db_center_path/dbscripts/mssql.sql"
		sed -i '1s/^/USE WSO2EI_USER_DB;\nGO\n\n/' "$db_center_path/dbscripts/identity/mssql.sql"
		sqlcmd -S $cf_db_host -U $cf_db_username -P $cf_db_password -i "$db_center_path/dbscripts/identity/mssql.sql"
		# Crete tables for reg database
		sed -i '1s/.*/USE WSO2EI_INTEGRATOR_GOV_DB;/' "$db_center_path/dbscripts/mssql.sql"
		sqlcmd -S $cf_db_host -U $cf_db_username -P $cf_db_password -i "$db_center_path/dbscripts/mssql.sql"
		sed -i '1s/.*/USE WSO2EI_INTEGRATOR_GOV_DB;/' "$db_center_path/dbscripts/identity/mssql.sql"
		sqlcmd -S $cf_db_host -U $cf_db_username -P $cf_db_password -i "$db_center_path/dbscripts/identity/mssql.sql"
fi
