###Drupal container to run our sites.

####Volumes
/www-files - shared storage between multiple front ends (NFS/AWS EFS)  
/etc/apache2/sites-enabled - site.conf to configure Apache for the site  

####Environment Variables
**Amazon SES Information (used by ssmtp)**  
SESmailhub - SMTP Server  
SESAuthUser - AWS SES IAM User  
SESAuthPass - AWS SES IAM Password  
**MySQL Information for website**  
MYSQL_SERVER - MySQL Server (IP or Hostname)  
MYSQL_DATABASE - MySQL Database Name  
MYSQL_USER - MySQL Username  
MYSQL_PASSWORD - MySQL Password  
**GitLab Server Info**  
GIT_REPO - https URL for Git Repo  
GIT_BRANCH - Branch to pull from  
GIT_HOSTS - HOSTS file entry, if needed (i.e. "10.10.3.20 gitlab.example.com"  
