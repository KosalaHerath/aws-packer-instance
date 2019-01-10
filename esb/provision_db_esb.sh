
#!/bin/bash
#Running Database scripts for WSO2-ESB
echo "Running DB scripts for WSO2-ESB..."

#Define parameter values for Database Engine and Version

DB_ENGINE='CF_DBMS_NAME'
DB_ENGINE_VERSION='CF_DBMS_VERSION'
WSO2_PRODUCT_VERSION='CF_PRODUCT_VERSION'

#Run database scripts for given database engine and product version

if [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "4.9.0" ]]; then
    # DB Engine : Postgres | Product Version : 4.9.0
    echo "Postgres DB Engine Selected! Running WSO2-ESB 4.9.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/esb/esb490/esb_postgres.sql
elif [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "5.0.0" ]]; then
    # DB Engine : Postgres | Product Version : 5.0.0
    echo "Postgres DB Engine Selected! Running WSO2-ESB 5.0.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/esb/esb500/esb_postgres.sql
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "4.9.0" ]]; then
    # DB Engine : MySQL | Product Version : 4.9.0
    echo "MySQL DB Engine Selected! Running WSO2-ESB 4.9.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/esb/esb490/esb_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/esb/esb490/esb_mysql.sql
    fi
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "5.0.0" ]]; then
    # DB Engine : MySQL | Product Version : 5.0.0
    echo "MySQL DB Engine Selected! Running WSO2-ESB 5.0.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/esb/esb500/esb_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/esb/esb500/esb_mysql.sql
    fi
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "4.9.0" ]]; then
    # DB Engine : Oracle | Product Version : 4.9.0
    echo "Oracle DB Engine Selected! Running WSO2-ESB 4.9.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2ESB_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2ESB_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/esb/esb490/esb_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2ESB_CONFIG_GOV_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2ESB_CONFIG_GOV_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/esb/esb490/esb_oracle_user.sql
    echo "CREATE USER WSO2ESB_CONFIG_GOV_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2ESB_CONFIG_GOV_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2ESB_CONFIG_GOV_DB;" >> /home/ubuntu/esb/esb490/esb_oracle_user.sql
    echo "CREATE USER WSO2ESB_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2ESB_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2ESB_USER_DB;" >> /home/ubuntu/esb/esb490/esb_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/ESBDB @/home/ubuntu/esb/esb490/esb_oracle_user.sql
    echo exit | sqlplus64 WSO2ESB_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/ESBDB @/home/ubuntu/esb/esb490/esb_oracle_user_db.sql
    echo exit | sqlplus64 WSO2ESB_CONFIG_GOV_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/ESBDB @/home/ubuntu/esb/esb490/esb_oracle_config_gov_db.sql
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "5.0.0" ]]; then
    # DB Engine : Oracle | Product Version : 5.0.0
    echo "Oracle DB Engine Selected! Running WSO2-ESB 5.0.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2ESB_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2ESB_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/esb/esb500/esb_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2ESB_CONFIG_GOV_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2ESB_CONFIG_GOV_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/esb/esb500/esb_oracle_user.sql
    echo "CREATE USER WSO2ESB_CONFIG_GOV_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2ESB_CONFIG_GOV_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2ESB_CONFIG_GOV_DB;" >> /home/ubuntu/esb/esb500/esb_oracle_user.sql
    echo "CREATE USER WSO2ESB_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2ESB_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2ESB_USER_DB;" >> /home/ubuntu/esb/esb500/esb_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/ESBDB @/home/ubuntu/esb/esb500/esb_oracle_user.sql
    echo exit | sqlplus64 WSO2ESB_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/ESBDB @/home/ubuntu/esb/esb500/esb_oracle_user_db.sql
    echo exit | sqlplus64 WSO2ESB_CONFIG_GOV_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/ESBDB @/home/ubuntu/esb/esb500/esb_oracle_config_gov_db.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "4.9.0" ]]; then
    # DB Engine : SQLServer | Product Version : 4.9.0
    echo "SQL Server DB Engine Selected! Running WSO2-ESB 4.9.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/esb/esb490/esb_sql_server.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "5.0.0" ]]; then
    # DB Engine : SQLServer | Product Version : 5.0.0
    echo "SQL Server DB Engine Selected! Running WSO2-ESB 5.0.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/esb/esb500/esb_sql_server.sql
fi
