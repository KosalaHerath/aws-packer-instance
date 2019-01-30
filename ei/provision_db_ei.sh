
#!/bin/bash
#Running Database scripts for WSO2-EI
echo "Running DB scripts for WSO2-EI..."

#Define parameter values for Database Engine and Version

DB_ENGINE='CF_DBMS_NAME'
DB_ENGINE_VERSION='CF_DBMS_VERSION'
WSO2_PRODUCT_VERSION='CF_PRODUCT_VERSION'

#Run database scripts for given database engine and product version

if [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "6.1.1" ]]; then
    # DB Engine : Postgres | Product Version : 6.1.1
    echo "Postgres DB Engine Selected! Running WSO2-EI 6.1.1 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/ei/ei611/ei_postgres.sql
elif [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "6.4.0" ]]; then
    # DB Engine : Postgres | Product Version : 6.4.0
    echo "Postgres DB Engine Selected! Running WSO2-EI 6.4.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/ei/ei640/ei_postgres.sql
elif [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "6.1.0" ]]; then
    # DB Engine : Postgres | Product Version : 6.1.0
    echo "Postgres DB Engine Selected! Running WSO2-EI 6.1.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/ei/ei610/ei_postgres.sql
elif [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "6.2.0" ]]; then
    # DB Engine : Postgres | Product Version : 6.2.0
    echo "Postgres DB Engine Selected! Running WSO2-EI 6.2.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/ei/ei620/ei_postgres.sql
elif [[ $DB_ENGINE = "postgres" ]] && [[ $WSO2_PRODUCT_VERSION = "6.3.0" ]]; then
    # DB Engine : Postgres | Product Version : 6.3.0
    echo "Postgres DB Engine Selected! Running WSO2-EI 6.3.0 DB Scripts for Postgres..."
    export PGPASSWORD=CF_DB_PASSWORD
    psql -U CF_DB_USERNAME -h CF_DB_HOST -p CF_DB_PORT -d postgres -f /home/ubuntu/ei/ei630/ei_postgres.sql
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "6.1.1" ]]; then
    # DB Engine : MySQL | Product Version : 6.1.1
    echo "MySQL DB Engine Selected! Running WSO2-EI 6.1.1 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei611/ei_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei611/ei_mysql.sql
    fi
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "6.4.0" ]]; then
    # DB Engine : MySQL | Product Version : 6.4.0
    echo "MySQL DB Engine Selected! Running WSO2-EI 6.4.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei640/ei_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei640/ei_mysql.sql
    fi
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "6.1.0" ]]; then
    # DB Engine : MySQL | Product Version : 6.1.0
    echo "MySQL DB Engine Selected! Running WSO2-EI 6.1.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei610/ei_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei610/ei_mysql.sql
    fi
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "6.2.0" ]]; then
    # DB Engine : MySQL | Product Version : 6.2.0
    echo "MySQL DB Engine Selected! Running WSO2-EI 6.2.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei620/ei_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei620/ei_mysql.sql
    fi
elif [[ $DB_ENGINE = "mysql" ]] && [[ $WSO2_PRODUCT_VERSION = "6.3.0" ]]; then
    # DB Engine : MySQL | Product Version : 6.3.0
    echo "MySQL DB Engine Selected! Running WSO2-EI 6.3.0 DB Scripts for MySQL..."
    if [[ $DB_ENGINE_VERSION = "5.7" ]]; then
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei630/ei_mysql5.7.sql
    else
        mysql -u CF_DB_USERNAME -pCF_DB_PASSWORD -h CF_DB_HOST -P CF_DB_PORT < /home/ubuntu/ei/ei630/ei_mysql.sql
    fi
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.1.1" ]]; then
    # DB Engine : Oracle | Product Version : 6.1.1
    echo "Oracle DB Engine Selected! Running WSO2-EI 6.1.1 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei611/ei_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_INTEGRATOR_GOV_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_INTEGRATOR_GOV_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei611/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_INTEGRATOR_GOV_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_INTEGRATOR_GOV_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_INTEGRATOR_GOV_DB;" >> /home/ubuntu/ei/ei611/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_USER_DB;" >> /home/ubuntu/ei/ei611/ei_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei611/ei_oracle_user.sql
    echo exit | sqlplus64 WSO2EI_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei611/ei_oracle_user_db.sql
    echo exit | sqlplus64 WSO2EI_INTEGRATOR_GOV_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei611/ei_oracle_integrator_gov_db.sql
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.4.0" ]]; then
    # DB Engine : Oracle | Product Version : 6.4.0
    echo "Oracle DB Engine Selected! Running WSO2-EI 6.4.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei640/ei_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_INTEGRATOR_GOV_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_INTEGRATOR_GOV_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei640/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_INTEGRATOR_GOV_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_INTEGRATOR_GOV_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_INTEGRATOR_GOV_DB;" >> /home/ubuntu/ei/ei640/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_USER_DB;" >> /home/ubuntu/ei/ei640/ei_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei640/ei_oracle_user.sql
    echo exit | sqlplus64 WSO2EI_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei640/ei_oracle_user_db.sql
    echo exit | sqlplus64 WSO2EI_INTEGRATOR_GOV_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei640/ei_oracle_integrator_gov_db.sql
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.1.0" ]]; then
    # DB Engine : Oracle | Product Version : 6.1.0
    echo "Oracle DB Engine Selected! Running WSO2-EI 6.1.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei610/ei_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_INTEGRATOR_GOV_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_INTEGRATOR_GOV_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei610/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_INTEGRATOR_GOV_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_INTEGRATOR_GOV_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_INTEGRATOR_GOV_DB;" >> /home/ubuntu/ei/ei610/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_USER_DB;" >> /home/ubuntu/ei/ei610/ei_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei610/ei_oracle_user.sql
    echo exit | sqlplus64 WSO2EI_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei610/ei_oracle_user_db.sql
    echo exit | sqlplus64 WSO2EI_INTEGRATOR_GOV_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei610/ei_oracle_integrator_gov_db.sql
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.2.0" ]]; then
    # DB Engine : Oracle | Product Version : 6.2.0
    echo "Oracle DB Engine Selected! Running WSO2-EI 6.2.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei620/ei_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_INTEGRATOR_GOV_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_INTEGRATOR_GOV_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei620/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_INTEGRATOR_GOV_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_INTEGRATOR_GOV_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_INTEGRATOR_GOV_DB;" >> /home/ubuntu/ei/ei620/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_USER_DB;" >> /home/ubuntu/ei/ei620/ei_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei620/ei_oracle_user.sql
    echo exit | sqlplus64 WSO2EI_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei620/ei_oracle_user_db.sql
    echo exit | sqlplus64 WSO2EI_INTEGRATOR_GOV_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei620/ei_oracle_integrator_gov_db.sql
elif [[ $DB_ENGINE =~ 'oracle-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.3.0" ]]; then
    # DB Engine : Oracle | Product Version : 6.3.0
    echo "Oracle DB Engine Selected! Running WSO2-EI 6.3.0 DB Scripts for Oracle..."
    # Create users to the required DB
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_USER_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_USER_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei630/ei_oracle_user.sql
    echo "DECLARE USER_EXIST INTEGER;"$'\n'"BEGIN SELECT COUNT(*) INTO USER_EXIST FROM dba_users WHERE username='WSO2EI_INTEGRATOR_GOV_DB';"$'\n'"IF (USER_EXIST > 0) THEN EXECUTE IMMEDIATE 'DROP USER WSO2EI_INTEGRATOR_GOV_DB CASCADE';"$'\n'"END IF;"$'\n'"END;"$'\n'"/" >> /home/ubuntu/ei/ei630/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_INTEGRATOR_GOV_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_INTEGRATOR_GOV_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_INTEGRATOR_GOV_DB;" >> /home/ubuntu/ei/ei630/ei_oracle_user.sql
    echo "CREATE USER WSO2EI_USER_DB IDENTIFIED BY CF_DB_PASSWORD;"$'\n'"GRANT CONNECT, RESOURCE, DBA TO WSO2EI_USER_DB;"$'\n'"GRANT UNLIMITED TABLESPACE TO WSO2EI_USER_DB;" >> /home/ubuntu/ei/ei630/ei_oracle_user.sql
    # Create the tables
    echo exit | sqlplus64 CF_DB_USERNAME/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei630/ei_oracle_user.sql
    echo exit | sqlplus64 WSO2EI_USER_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei630/ei_oracle_user_db.sql
    echo exit | sqlplus64 WSO2EI_INTEGRATOR_GOV_DB/CF_DB_PASSWORD@//CF_DB_HOST:CF_DB_PORT/WSO2EIDB @/home/ubuntu/ei/ei630/ei_oracle_integrator_gov_db.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.1.1" ]]; then
    # DB Engine : SQLServer | Product Version : 6.1.1
    echo "SQL Server DB Engine Selected! Running WSO2-EI 6.1.1 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/ei/ei611/ei_sql_server.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.4.0" ]]; then
    # DB Engine : SQLServer | Product Version : 6.4.0
    echo "SQL Server DB Engine Selected! Running WSO2-EI 6.4.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/ei/ei640/ei_sql_server.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.1.0" ]]; then
    # DB Engine : SQLServer | Product Version : 6.1.0
    echo "SQL Server DB Engine Selected! Running WSO2-EI 6.1.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/ei/ei610/ei_sql_server.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.2.0" ]]; then
    # DB Engine : SQLServer | Product Version : 6.2.0
    echo "SQL Server DB Engine Selected! Running WSO2-EI 6.2.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/ei/ei620/ei_sql_server.sql
elif [[ $DB_ENGINE =~ 'sqlserver-se' ]] && [[ $WSO2_PRODUCT_VERSION = "6.3.0" ]]; then
    # DB Engine : SQLServer | Product Version : 6.3.0
    echo "SQL Server DB Engine Selected! Running WSO2-EI 6.3.0 DB Scripts for SQL Server..."
    sqlcmd -S CF_DB_HOST -U CF_DB_USERNAME -P CF_DB_PASSWORD -i /home/ubuntu/ei/ei630/ei_sql_server.sql
fi
