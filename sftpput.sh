#!/bin/bash

# Load .env file
set -o allexport
source "$(dirname "$0")/.env"
set -o allexport

host="$1"
filename="$2"

case $host in
  test1)
    sshpass -p "$test1password" sftp -o PubkeyAuthentication=no hdsupply-test1@us-east-1.sftpcloud.io <<EOF
put -r "$path/$filename"
EOF
    ;;
  dev1)
    sshpass -p "$dev1password" sftp -o PubkeyAuthentication=no hdsupply-dev1@us-east-1.sftpcloud.io <<EOF
put -r "$path/$filename"
EOF
    ;;
  prod)
    sshpass -p "$prodpassword" sftp -o PubkeyAuthentication=no hdsupply-prod@us-east-1.sftpcloud.io <<EOF
put -r "$path/$filename"
EOF
    ;;
  *)
    echo "Invalid environment. Use test1, dev1, or prod."
    ;;
esac
