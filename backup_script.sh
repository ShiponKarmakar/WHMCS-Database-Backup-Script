#!/bin/bash

# Load database credentials from a secure file
source /path/to/secure/db_config.sh

# Backup configuration
BACKUP_DIR="/path/to/backup/directory"   # Path where backups will be saved
BACKUP_RETENTION_DAYS=15                   # Number of days to keep old backups

# Date format for backup file name
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.sql"

# Log file for errors and output
LOG_FILE="$BACKUP_DIR/backup.log"

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Create a new backup
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" -h "$DB_HOST" "$DB_NAME" > "$BACKUP_FILE"

# Check if the backup command succeeded
if [ $? -eq 0 ]; then
    echo "[$(date)] Backup successful: $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "[$(date)] Backup failed" >> "$LOG_FILE"
    exit 1
fi

# Compress the backup to save space
gzip "$BACKUP_FILE"

# Remove old backups (older than the retention period)
find "$BACKUP_DIR" -type f -name "backup_*.sql.gz" -mtime +$BACKUP_RETENTION_DAYS -exec rm -f {} \;

# Log cleanup result
if [ $? -eq 0 ]; then
    echo "[$(date)] Old backups cleaned up successfully." >> "$LOG_FILE"
else
    echo "[$(date)] Error cleaning up old backups." >> "$LOG_FILE"
    exit 1
fi
