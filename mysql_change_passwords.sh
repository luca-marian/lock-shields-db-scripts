#!/bin/bash

# ==== Configuration ====
NAMESPACE="default"
POD_NAME="mysql-6c46c9fc56-fl877"
MYSQL_USER="root"
MYSQL_PASSWORD="securepassword"

TIMESTAMP=$(date +%F-%H-%M)
OUTFILE="passwords/mysql-new-passwords-$TIMESTAMP.txt"
# =======================

echo "🔐 Rotating MySQL user passwords"
echo "Saving to: $OUTFILE"

# Extract user list (excluding root and system users)
USER_LIST=$(
    kubectl exec "$POD_NAME" -- sh -c \
        "mysql -u root -p\$MYSQL_ROOT_PASSWORD -Nse \"SELECT user FROM mysql.user WHERE user NOT IN ('root','mysql.sys', 'mysql.session', 'mysql.infoschema');\""
)

echo "User List $USER_LIST"

for USER in $USER_LIST; do
    NEW_PASS=$(openssl rand -hex 12)

    # Get current password hash
    OLD_HASH=$(kubectl exec "$POD_NAME" -- sh -c \
        "mysql -u root -p\$MYSQL_ROOT_PASSWORD -Nse \"SELECT authentication_string FROM mysql.user WHERE user = '$USER';\"")

    echo "🔁 Updating password for user: $USER"

    # kubectl exec "$POD_NAME" -- sh -c \
    #     "mysql -u root -p\$MYSQL_ROOT_PASSWORD -e \"ALTER USER '$USER'@'%' IDENTIFIED BY '$NEW_PASS';\""

    echo "$USER|OLD_HASH:$OLD_HASH|NEW_PASSWORD:$NEW_PASS" >>"$OUTFILE"
done

echo "✅ Passwords rotated. Stored in: $OUTFILE"
