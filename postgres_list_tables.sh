#!/bin/bash

# ==== Configuration ====
NAMESPACE="default"
POD_NAME="postgres-db-1"
DB_USER="postgres"
# =======================

# Get all databases, skip templates
DATABASES=$(kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    psql -U "$DB_USER" -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;" | tr -d ' ')

for DB in $DATABASES; do
    echo "🔍 Tables in database: $DB"
    kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
        psql -U "$DB_USER" -d "$DB" -c "\dt"
    echo ""
done
