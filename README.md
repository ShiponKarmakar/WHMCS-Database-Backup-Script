# WHMCS Database Backup Script

This script is used to back up a WHMCS database on a Linux server. It allows for secure storage of credentials, automated backup creation, and retention management of older backups.

## Features
- Automates the backup of a MySQL database used by WHMCS.
- Supports configurable backup retention for easy management of old backups.
- Uses a separate configuration file to keep sensitive information secure.
- Logs backup activities and cleanup operations.

## Prerequisites
- **MySQL Database**: Make sure you have access to the MySQL database you want to back up.
- **Bash Shell**: The script is designed to be executed in a Unix/Linux environment.
- **Permissions**: Ensure you have permissions to execute the script and write to the backup directory.

## Setup Instructions

### Step 1: Create a Secure Configuration File
1. Create a file named `db_config.sh` in a secure location (e.g., `/path/to/secure/db_config.sh`):
    ```bash
    # db_config.sh
    
    # Database configuration
    DB_NAME="your_database_name"         # Name of the database to back up
    DB_USER="your_database_username"     # Database username
    DB_PASSWORD="your_database_password" # Database password
    DB_HOST="localhost"                  # Database host (use 'localhost' if hosted locally)
    ```
2. Set the appropriate permissions to keep the configuration secure:
    ```bash
    chmod 600 /path/to/secure/db_config.sh
    ```

### Step 2: Edit the Backup Script
1. Update the `BACKUP_DIR` variable to the directory where backups should be saved.
2. Update the `source` line to point to your configuration file:
    ```bash
    source /path/to/secure/db_config.sh
    ```
3. Make sure the backup directory is writable and executable by the script.

### Step 3: Set Up a Cron Job
You can automate the backup process by adding a cron job. To do this:
1. Open the cron editor:
    ```bash
    crontab -e
    ```
2. Add the following line to run the backup daily at 2 AM:
    ```bash
    0 2 * * * /path/to/whmcs_backup_script.sh
    ```

## Usage
- Run the script manually with:
  ```bash
  bash /path/to/whmcs_backup_script.sh
  ```
- Make sure the script has executable permissions:
  ```bash
  chmod +x /path/to/whmcs_backup_script.sh
  ```

## Log File
The script maintains a log file (`backup.log`) in the backup directory. This log contains information about the success or failure of each backup operation and any cleanup actions.

## Security Considerations
- Store the configuration file (`db_config.sh`) in a secure location.
- The configuration file should have restricted permissions to prevent unauthorized access.

## Contact
If you have any questions or need assistance, feel free to contact me:
- **Email**: [shiponkormoker@gmail.com](mailto:shiponkormoker@gmail.com)

## License
This project is open source and available under the MIT License.

