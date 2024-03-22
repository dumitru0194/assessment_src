**The OS is almost configured except SSSD service.**


Clone this project to your system where you have docker installed
Enter in project directory and run "docker build -t myubuntu ."
After process is completed, run " docker run --privileged -it --name custom_ubuntu -p 8080:80 -p 444:443 -p 23:22 -p 6022:6022 -p 3309:3306 myubuntu "

Then you can verify the functionality by accessing those open ports: http:8080, https:444, ssh:23, sftp:6022, mysql:3309.

**Services Credentials:**
MySQL: root:root, test_user:test_user123 .
Linux user: myuser:1234 




**DM me on pintilied41@gmail.com if you encoutered some issues with running this Docker project.**
