 #! /bin/bash
                sudo yum update -y
                sudo yum install -y httpd.x86_64
                sudo service httpd start
                sudo service httpd enable
                echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
    yum install java-1.8.0-openjdk-devel -y
    curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
    sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
    yum install -y jenkins
    systemctl start jenkins
    systemctl status jenkins
    systemctl enable jenkins



