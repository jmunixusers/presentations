# NextCloud on AWS

1. Create EC2 instance
    1. Choose latest Ubuntu LTS image w/ any machine type
    2. Allow port 80 (HTTP) to your IP
    3. Launch instance and connect via SSH
    4. Run updates: `sudo apt update && sudo apt upgrade -y`
    5. Accept any defaults
2. Install NextCloud
    1. On Ubuntu: `sudo snap install nextcloud`
    2. Browse to your instance's public URL (may need to wait a few minutes)
    3. Create admin user and password
    4. Wait for initialization to finish
3. Set up desktop sync (optional)
    1. Download and install NextCloud app (if not already installed)
    2. Connect to your instance's public URL (use "http://")
    3. Initial connection may fail -- if so, retry with unsecured HTTP
    4. You may need to grant access to the client by logging in again
4. Set up external storage (optional)
    1. Enable "external storage support" plugin in NextCloud
    2. Add S3 permissions to your user in IAM if it doesn't already have them
        1. Create "s3" group (IAM -> Groups)
        2. Give it the "AmazonS3FullAccess" policy
        3. Add your user to the new group (IAM -> Users)
    3. Create Access key (IAM -> Users -> your user -> Security Credentials)
        1. Save Access key ID and secret access key
    4. Configure S3 external storage in NextCloud (Settings -> Administration -> External storages)
        1. Use "/" as folder name if you want all files to be stored in S3
        2. Pick a bucket name (do not create bucket in S3 first)
        3. Use Access key ID and secret access key from IAM
        4. Set region if desired
        5. Leave everything else at the defaults and click checkmark
        6. Add new files to external storage folder (may need to enable folder sync in client)
        7. Confirm new files are present in new S3 bucket
5. Set up permanent IP (optional)
    1. Allocate new Elastic IP and assign to your EC2 NextCloud instance
    2. Re-connect via SSH to new IP (previous step will kill old connection)
    3. Edit `/var/snap/nextcloud/current/nextcloud/config/config.php` and add your IP to `trusted_domains`
    4. Restart Apache: `sudo systemctl restart snap.nextcloud.apache.service`
6. Set up HTTPS (optional)
    1. Modify security settings for instance and enable HTTPS access to your instance
    2. If you have a domain pointed to your instance:
        1. Modify security settings for instance and enable HTTP and HTTPS from anywhere
        2. Enable HTTPS: `sudo nextcloud.enable-https lets-encrypt`
    3. Alternative, use self-signed cert: `sudo nextcloud.enable-https self-signed`

If you're using Google Cloud Platform:

1. Enable interoperability in Google Cloud settings
2. Create access key/secret
3. Create Google Cloud bucket
4. Configure S3 external storage in NextCloud
    1. Hostname: storage.googleapis.com

