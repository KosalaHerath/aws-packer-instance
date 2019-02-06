
#!/bin/bash
#Running Database scripts for WSO2-IS
echo "Running DB scripts for WSO2-IS..."

#Define parameter values for Database Engine and Version

DB_ENGINE='CF_DBMS_NAME'
DB_ENGINE_VERSION='CF_DBMS_VERSION'
WSO2_PRODUCT_VERSION='CF_PRODUCT_VERSION'

#Run database scripts for given database engine and product version

if [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "5.2.0" ]]; then
    # DB Engine : Postgres | Product Version : 5.2.0
    echo "Postgres DB Engine Selected! Running WSO2-IS 5.2.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/is/is520/is_postgres.sql
elif [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "5.3.0" ]]; then
    # DB Engine : Postgres | Product Version : 5.3.0
    echo "Postgres DB Engine Selected! Running WSO2-IS 5.3.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/is/is530/is_postgres.sql
elif [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "5.7.0" ]]; then
    # DB Engine : Postgres | Product Version : 5.7.0
    echo "Postgres DB Engine Selected! Running WSO2-IS 5.7.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/is/is570/is_postgres.sql
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "5.2.0" ]]; then
    # DB Engine : MySQL | Product Version : 5.2.0
    echo "MySQL DB Engine Selected! Running WSO2-IS 5.2.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/is/is520/is_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/is/is520/is_mysql.sql
    fi
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "5.3.0" ]]; then
    # DB Engine : MySQL | Product Version : 5.3.0
    echo "MySQL DB Engine Selected! Running WSO2-IS 5.3.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/is/is530/is_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/is/is530/is_mysql.sql
    fi
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "5.7.0" ]]; then
    # DB Engine : MySQL | Product Version : 5.7.0
    echo "MySQL DB Engine Selected! Running WSO2-IS 5.7.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/is/is570/is_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/is/is570/is_mysql5.7.sql
    fi
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "5.2.0" ]]; then
    # DB Engine : Oracle | Product Version : 5.2.0
    echo "Oracle DB Engine Selected! Running WSO2-IS 5.2.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_REG_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_REG_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_BPS_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_BPS_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_IDENTITY_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_IDENTITY_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_CONSENT_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_CONSENT_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "CREATE USER WSO2IS_REG_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_REG_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_REG_DB;" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "CREATE USER WSO2IS_BPS_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_BPS_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_BPS_DB;" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "CREATE USER WSO2IS_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_USER_DB;" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "CREATE USER WSO2IS_IDENTITY_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_IDENTITY_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_IDENTITY_DB;" >> /home/ubuntu/is/is520/is_oracle.sql
    echo "CREATE USER WSO2IS_CONSENT_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_CONSENT_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_CONSENT_DB;" >> /home/ubuntu/is/is520/is_oracle.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is520/is_oracle.sql
    echo exit | sqlplus64 WSO2IS_REG_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is520/is_oracle_common.sql
    echo exit | sqlplus64 WSO2IS_BPS_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is520/is_oracle_bps.sql
    echo exit | sqlplus64 WSO2IS_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is520/is_oracle_common.sql
    echo exit | sqlplus64 WSO2IS_IDENTITY_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is520/is_oracle_identity.sql
    echo exit | sqlplus64 WSO2IS_CONSENT_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is520/is_oracle_common.sql
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "5.3.0" ]]; then
    # DB Engine : Oracle | Product Version : 5.3.0
    echo "Oracle DB Engine Selected! Running WSO2-IS 5.3.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_REG_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_REG_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_BPS_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_BPS_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_IDENTITY_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_IDENTITY_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_CONSENT_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_CONSENT_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "CREATE USER WSO2IS_REG_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_REG_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_REG_DB;" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "CREATE USER WSO2IS_BPS_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_BPS_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_BPS_DB;" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "CREATE USER WSO2IS_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_USER_DB;" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "CREATE USER WSO2IS_IDENTITY_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_IDENTITY_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_IDENTITY_DB;" >> /home/ubuntu/is/is530/is_oracle.sql
    echo "CREATE USER WSO2IS_CONSENT_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_CONSENT_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_CONSENT_DB;" >> /home/ubuntu/is/is530/is_oracle.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is530/is_oracle.sql
    echo exit | sqlplus64 WSO2IS_REG_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is530/is_oracle_common.sql
    echo exit | sqlplus64 WSO2IS_BPS_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is530/is_oracle_bps.sql
    echo exit | sqlplus64 WSO2IS_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is530/is_oracle_common.sql
    echo exit | sqlplus64 WSO2IS_IDENTITY_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is530/is_oracle_identity.sql
    echo exit | sqlplus64 WSO2IS_CONSENT_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is530/is_oracle_common.sql
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "5.7.0" ]]; then
    # DB Engine : Oracle | Product Version : 5.7.0
    echo "Oracle DB Engine Selected! Running WSO2-IS 5.7.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_REG_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_REG_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_BPS_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_BPS_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_IDENTITY_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_IDENTITY_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2IS_CONSENT_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2IS_CONSENT_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "CREATE USER WSO2IS_REG_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_REG_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_REG_DB;" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "CREATE USER WSO2IS_BPS_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_BPS_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_BPS_DB;" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "CREATE USER WSO2IS_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_USER_DB;" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "CREATE USER WSO2IS_IDENTITY_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_IDENTITY_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_IDENTITY_DB;" >> /home/ubuntu/is/is570/is_oracle.sql
    echo "CREATE USER WSO2IS_CONSENT_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2IS_CONSENT_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2IS_CONSENT_DB;" >> /home/ubuntu/is/is570/is_oracle.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is570/is_oracle.sql
    echo exit | sqlplus64 WSO2IS_REG_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is570/oracle_common.sql
    echo exit | sqlplus64 WSO2IS_BPS_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is570/oracle_bps.sql
    echo exit | sqlplus64 WSO2IS_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is570/oracle_common.sql
    echo exit | sqlplus64 WSO2IS_IDENTITY_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is570/oracle_identity.sql
    echo exit | sqlplus64 WSO2IS_CONSENT_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2ISDB @/home/ubuntu/is/is570/oracle_consent.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "5.2.0" ]]; then
    # DB Engine : SQLServer | Product Version : 5.2.0
    echo "SQL Server DB Engine Selected! Running WSO2-IS 5.2.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/is/is520/is_mssql.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "5.3.0" ]]; then
    # DB Engine : SQLServer | Product Version : 5.3.0
    echo "SQL Server DB Engine Selected! Running WSO2-IS 5.3.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/is/is530/is_mssql.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "5.7.0" ]]; then
    # DB Engine : SQLServer | Product Version : 5.7.0
    echo "SQL Server DB Engine Selected! Running WSO2-IS 5.7.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/is/is570/is_mssql.sql
fi
