#!/bin/bash

# ==== CONFIGURATION ====
NAMESPACE="default"
POD_NAME="postgres-5f7bcd459c-n99t9"
DB_NAME="farm"
DB_USER="postgres"
DUMP_FILE="/tmp/${DB_NAME}_dump.sql"
LOCAL_DEST="./${DB_NAME}_dump.sql"
# ========================

echo "📦 Dumping PostgreSQL database '$DB_NAME' from pod '$POD_NAME'..."

# Step 1: Create the dump inside the pod
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- \
    pg_dump -U "$DB_USER" -d "$DB_NAME" -F p -f "$DUMP_FILE"

if [ $? -ne 0 ]; then
    echo "❌ Failed to dump database inside pod"
    exit 1
fi

# Step 2: Copy dump file to local machine
kubectl cp "$NAMESPACE/$POD_NAME:$DUMP_FILE" "$LOCAL_DEST"

if [ $? -ne 0 ]; then
    echo "❌ Failed to copy dump file to local machine"
    exit 1
fi

# Step 3: Clean up the dump file inside the pod
kubectl exec -n "$NAMESPACE" "$POD_NAME" -- rm -f "$DUMP_FILE"

echo "✅ Database '$DB_NAME' copied successfully to '$LOCAL_DEST'"
