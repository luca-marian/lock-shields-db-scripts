#!/bin/bash

# ==== CONFIGURATION ====
NAMESPACE="default"
POD_NAME="postgres-db-1"
DB_USER="postgres"
DUMP_FILE="/tmp/all_dbs_dump.sql"
LOCAL_DEST="backup/postgres/all_dbs_dump.sql"
# ========================

echo "📦 Dumping all PostgreSQL databases from pod '$POD_NAME'..."

# Step 1: Create the full cluster dump inside the pod
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    pg_dumpall -U "$DB_USER" -f "$DUMP_FILE"

if [ $? -ne 0 ]; then
    echo "❌ Failed to dump all databases inside pod"
    exit 1
fi

# Step 2: Copy the dump file to local machine
kubectl cp "$NAMESPACE/$POD_NAME:$DUMP_FILE" "$LOCAL_DEST"

if [ $? -ne 0 ]; then
    echo "❌ Failed to copy dump file to local machine"
    exit 1
fi

# Step 3: Clean up the file inside the pod
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- rm -f "$DUMP_FILE"

echo "✅ All databases copied successfully to '$LOCAL_DEST'"
