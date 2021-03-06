
#!/bin/bash
#Running Database scripts for WSO2-IS
echo "Running DB scripts for WSO2-IS..."

#Define parameter values for Database Engine and Version

DB_ENGINE='CF_DBMS_NAME'
DB_ENGINE_VERSION='CF_DBMS_VERSION'
WSO2_PRODUCT_VERSION='CF_PRODUCT_VERSION'
USE_CONSENT_DB=false

#Select product version
if [ $WSO2_PRODUCT_VERSION = "5.2.0" ]; then
    WSO2_PRODUCT_VERSION_SHORT=is520
elif [ $WSO2_PRODUCT_VERSION = "5.3.0" ]; then
    WSO2_PRODUCT_VERSION_SHORT=is530
elif [ $WSO2_PRODUCT_VERSION = "5.4.0" ]; then
    WSO2_PRODUCT_VERSION_SHORT=is540
elif [ $WSO2_PRODUCT_VERSION = "5.4.1" ]; then
    WSO2_PRODUCT_VERSION_SHORT=is541
elif [ $WSO2_PRODUCT_VERSION = "5.5.0" ]; then
    WSO2_PRODUCT_VERSION_SHORT=is550
    USE_CONSENT_DB=true
elif [ $WSO2_PRODUCT_VERSION = "5.6.0" ]; then
    WSO2_PRODUCT_VERSION_SHORT=is560
    USE_CONSENT_DB=true
elif [ $WSO2_PRODUCT_VERSION = "5.7.0" ]; then
    WSO2_PRODUCT_VERSION_SHORT=is570
    USE_CONSENT_DB=true
fi

#Run database scripts for given database engine and product version

if [[ $DB_ENGINE = "postgres" ]]; then
    # DB Engine : Postgres
    echo "Postgres DB Engine Selected! Running WSO2-IS $WSO2_PRODUCT_VERSION DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_postgres.sql
elif [[ $DB_ENGINE = "mysql" ]]; then
    # DB Engine : MySQL
    echo "MySQL DB Engine Selected! Running WSO2-IS $WSO2_PRODUCT_VERSION DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_mysql.sql
    fi
elif [[ $DB_ENGINE =~ 'oracle-se' ]]; then
    # DB Engine : Oracle
    echo "Oracle DB Engine Selected! Running WSO2-IS $WSO2_PRODUCT_VERSION DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_REG_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_REG_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_BPS_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_BPS_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_IDENTITY_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_IDENTITY_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_CONSENT_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_CONSENT_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "CREATE USER WSO2IS_REG_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_REG_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_REG_DB;" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "CREATE USER WSO2IS_BPS_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_BPS_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_BPS_DB;" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "CREATE USER WSO2IS_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_USER_DB;" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "CREATE USER WSO2IS_IDENTITY_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_IDENTITY_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_IDENTITY_DB;" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo "CREATE USER WSO2IS_CONSENT_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_CONSENT_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_CONSENT_DB;" >> /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle.sql
    echo exit | sqlplus64 WSO2IS_REG_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle_common.sql
    echo exit | sqlplus64 WSO2IS_BPS_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle_bps.sql
    echo exit | sqlplus64 WSO2IS_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle_common.sql
    echo exit | sqlplus64 WSO2IS_IDENTITY_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle_identity.sql
    if $USE_CONSENT_DB; then
        echo exit | sqlplus64 WSO2IS_CONSENT_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle_consent.sql
    else
        echo exit | sqlplus64 WSO2IS_CONSENT_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_oracle_common.sql
    fi
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]]; then
    # DB Engine : SQLServer
    echo "SQL Server DB Engine Selected! Running WSO2-IS $WSO2_PRODUCT_VERSION DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/is/$WSO2_PRODUCT_VERSION_SHORT/is_mssql.sql
fi
