
#!/bin/bash
#Running Database scripts for WSO2-APIM
echo "Running DB scripts for WSO2-APIM..."

#Define parameter values for Database Engine and Version

DB_ENGINE='CF_DBMS'
DB_ENGINE_VERSION='CF_DBMS_VERSION'
WSO2_PRODUCT_VERSION='CF_PRODUCT_VERSION'

#Run database scripts for given database engine and product version

if [[[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "2.1.0" ]]]; then
    # DB Engine : Postgres | Product Version : 2.1.0
    echo "Postgres DB Engine Selected! Running WSO2-APIM 2.1.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/apim/apim210/apim_postgres.sql

elif [[[ $DB_ENGINE = "postgres" ]] && [[$WSO2_PRODUCT_VERSION = "2.6.0" ]]]; then
    # DB Engine : Postgres | Product Version : 2.1.0
    echo "Postgres DB Engine Selected! Running WSO2-APIM 2.6.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/apim/apim260/apim_postgres.sql

elif [[[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "2.1.0" ]]]; then
    # DB Engine : Postgres | Product Version : 2.1.0
    echo "MySQL DB Engine Selected! Running WSO2-APIM 2.1.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/apim/apim210/apim_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/apim/apim210/apim_mysql.sql
    fi
elif [[[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "2.6.0" ]]]; then
    # DB Engine : Postgres | Product Version : 2.1.0
    echo "MySQL DB Engine Selected! Running WSO2-APIM 2.6.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/apim/apim260/apim_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/apim/apim260/apim_mysql.sql
    fi
elif [[[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "2.1.0" ]]]; then
    # DB Engine : Postgres | Product Version : 2.1.0
    echo "Oracle DB Engine Selected! Running WSO2-APIM 2.1.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2AM_APIMGT_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2AM_APIMGT_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/apim/apim210/apim_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2AM_COMMON_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2AM_COMMON_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/apim/apim210/apim_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2AM_STAT_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2AM_STAT_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/apim/apim210/apim_oracle_user.sql
    echo "CREATE USER WSO2AM_COMMON_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2AM_COMMON_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2AM_COMMON_DB;" >> /home/ubuntu/apim/apim210/apim_oracle_user.sql
    echo "CREATE USER WSO2AM_APIMGT_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2AM_APIMGT_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2AM_APIMGT_DB;" >> /home/ubuntu/apim/apim210/apim_oracle_user.sql
    echo "CREATE USER WSO2AM_STAT_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2AM_STAT_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2AM_STAT_DB;" >> /home/ubuntu/apim/apim210/apim_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2AMDB @/home/ubuntu/apim/apim210/apim_oracle_user.sql
    echo exit | sqlplus64 WSO2AM_COMMON_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2AMDB @/home/ubuntu/apim/apim210/apim_oracle_common_db.sql
    echo exit | sqlplus64 WSO2AM_APIMGT_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2AMDB @/home/ubuntu/apim/apim210/apim_oracle_apimgt_db.sql
    mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/apim/apim260/apim_mysql.sql

elif [[[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "2.6.0" ]]]; then
    # DB Engine : Postgres | Product Version : 2.1.0
    echo "Oracle DB Engine Selected! Running WSO2-APIM 2.6.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2AM_APIMGT_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2AM_APIMGT_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/apim/apim260/apim_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2AM_COMMON_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2AM_COMMON_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/apim/apim260/apim_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2AM_STAT_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2AM_STAT_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/apim/apim260/apim_oracle_user.sql
    echo "CREATE USER WSO2AM_COMMON_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2AM_COMMON_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2AM_COMMON_DB;" >> /home/ubuntu/apim/apim260/apim_oracle_user.sql
    echo "CREATE USER WSO2AM_APIMGT_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2AM_APIMGT_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2AM_APIMGT_DB;" >> /home/ubuntu/apim/apim260/apim_oracle_user.sql
    echo "CREATE USER WSO2AM_STAT_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2AM_STAT_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2AM_STAT_DB;" >> /home/ubuntu/apim/apim260/apim_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2AMDB @/home/ubuntu/apim/apim260/apim_oracle_user.sql
    echo exit | sqlplus64 WSO2AM_COMMON_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2AMDB @/home/ubuntu/apim/apim260/apim_oracle_common_db.sql
    echo exit | sqlplus64 WSO2AM_APIMGT_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2AMDB @/home/ubuntu/apim/apim260/apim_oracle_apimgt_db.sql

elif [[[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "2.1.0" ]]]; then
    # DB Engine : Postgres | Product Version : 2.1.0
    echo "SQL Server DB Engine Selected! Running WSO2-APIM 2.1.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/apim/apim210/apim_sql_server.sql

elif [[[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "2.6.0" ]]]; then
    # DB Engine : Postgres | Product Version : 2.1.0
    echo "SQL Server DB Engine Selected! Running WSO2-APIM 2.6.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/apim/apim260/apim_sql_server.sql

fi
