# NextCloud on AWS

1. Create EC2 instance
    1. Choose latest Ubuntu LTS image
    2. Allow port 80 to your IP
    3. Launch instance and connect via SSH
    4. Run updates: `sudo apt update && sudo apt upgrade -y`
    5. Accept any defaults
2. Install NextCloud
    1. On Ubuntu: `sudo snap install nextcloud`
    2. Browse to your instance's public URL
    3. Create admin user and password
3. Set up desktop sync (optional)
    1. Download and install NextCloud app (if not already installed)
    2. Initial connection will fail -- retry with unsecured HTTP
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
        4. Leave everything else at the defaults
        5. Confirm files are present in new S3 bucket
5. Request and allocate elastic IP (optional)
6. TODO: set up HTTPS (optional, requires domain)

If you're using Google Cloud Platform:

1. Enable interoperability in Google Cloud settings
2. Create access key/secret
3. Create Google Cloud bucket
4. Configure S3 external storage in NextCloud
    1. Hostname: storage.googleapis.com

