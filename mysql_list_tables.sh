#!/bin/bash

# ==== CONFIGURATION ====
NAMESPACE="default"
POD_NAME="mysql-6c46c9fc56-fl877"
MYSQL_USER="root"
MYSQL_PASSWORD="securepassword"
# ========================

# Get all databases except system ones
# DATABASES=$(kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
#     mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;")

DATABASES=$(kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -N -e \
    "SHOW DATABASES;" | grep -v -E "information_schema|mysql|performance_schema|sys")

echo "📂 Get database: $DATABASES"

for DB in $DATABASES; do
    echo "🔍 Tables in database: $DB"
    kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
        mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -D "$DB" -e "SHOW TABLES;"
    echo ""
done
