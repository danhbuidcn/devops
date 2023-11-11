# Setup jenkins on aws

```
sudo yum install epel-release -y
sudo yum install java-17-openjdk -y
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate
sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum update -y
sudo yum install jenkins -y
sudo systemctl status jenkins
sudo systemctl start jenkins
```

link: https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/












