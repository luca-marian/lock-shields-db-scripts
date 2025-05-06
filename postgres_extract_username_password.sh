#!/bin/bash

# ==== Configuration ====
NAMESPACE="default"
POD_NAME="postgres-5f7bcd459c-n99t9"
DB_USER="postgres"
# =======================

DB_NAME="farm"
TABLE_NAME="account"
OUTPUT_FILE="current_passwords/pg-userlist-$TABLE_NAME-$(date +%F-%H-%M).txt"

kubectl exec "$POD_NAME" -- bash -c \
    "psql -U postgres -d $DB_NAME -tAc \"SELECT username || ':' || password_hash FROM $TABLE_NAME;\"" \
    >"$OUTPUT_FILE"

echo "✅ Extracted user list saved to $OUTPUT_FILE"
