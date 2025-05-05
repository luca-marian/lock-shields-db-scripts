#!/bin/bash

# ==== Configuration ====
NAMESPACE="default"
POD_NAME="postgres-5f7bcd459c-n99t9"
DB_USER="postgres"
DB_NAME="your-database"
# =======================

# Step 1: List all schemas
echo "📂 Available schemas:"
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    psql -U "$DB_USER" -c "\dn"

echo "📂 Available dbs in:"
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    psql -U "$DB_USER" -c "\l"

# Step 2: Ask user to select schema
read -p "Enter the schema name to list its tables: " SCHEMA_NAME

# Step 3: List tables in selected schema
# echo "📋 Tables in schema '$SCHEMA_NAME':"
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    psql -U "$DB_USER" -d "${SCHEMA_NAME}" -c "\dt"
