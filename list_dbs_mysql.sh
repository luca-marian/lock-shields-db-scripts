#!/bin/bash

# ==== Configuration ====
NAMESPACE="default"
POD_NAME="mysql-6c46c9fc56-fl877"
MYSQL_USER="root"
MYSQL_PASSWORD="securepassword"
# =======================

# Step 1: List all schemas (databases)
echo "📂 Available schemas:"
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;"

# Step 2: Ask user to select schema
read -p "Enter the schema (database) name to list its tables: " DB_NAME

# Step 3: List tables in selected schema
echo "📋 Tables in database '$DB_NAME':"
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -D "$DB_NAME" -e "SHOW TABLES;"
