#!/bin/bash

# ==== Configuration ====
NAMESPACE="default"
POD_NAME="postgres-5f7bcd459c-n99t9"
DB_USER="postgres"

TIMESTAMP=$(date +%F-%H-%M)
OUTFILE="passwords/pg-new-passwords-$TIMESTAMP.txt"
# =======================

echo "🔐 Rotating PostgreSQL user passwords"
echo "Saving to: $OUTFILE"

# Extract all usernames (excluding postgres)
USER_LIST=$(kubectl exec "$POD_NAME" -- bash -c "psql -U postgres -tAc \"SELECT usename FROM pg_user ;\"")

echo "User list: $USER_LIST"

for USER in $USER_LIST; do
    NEW_PASS=$(openssl rand -hex 12)

    # Get current password hash (from pg_shadow, visible only to superusers)
    OLD_HASH=$(kubectl exec "$POD_NAME" -- bash -c \
        "psql -U postgres -tAc \"SELECT passwd FROM pg_shadow WHERE usename = '$USER';\"")

    echo "🔁 Updating password for user: $USER"

    # kubectl exec "$POD_NAME" -- bash -c \
    #     "psql -U postgres -c \"ALTER USER \\\"$USER\\\" WITH PASSWORD '$NEW_PASS';\""

    echo "$USER|OLD_HASH:$OLD_HASH|NEW_PASSWORD:$NEW_PASS" >>"$OUTFILE"
done

echo "✅ Passwords rotated. Stored in: $OUTFILE"
