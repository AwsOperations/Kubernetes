sudo apt update

sudo apt install -y openjdk-17-jre

java -version
 
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update

sudo apt-get install jenkins

sudo systemctl enable --now jenkins

sudo systemctl start jenkins.service

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# # wait for jenkins start up
# response=""
# key=""
# while [ `echo $response | grep 'Authenticated' | wc -l` = 0 ]; do
#   key=`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
#   echo $key >> /tmp/status.txt
#   response=`sudo java -jar /var/cache/jenkins/war/WEB-INF/lib/cli-2.401.1.jar -s http://localhost:8080 who-am-i --username admin --password $key`
#   sudo echo $response
#   sudo echo "Jenkins not started, wait for 2s"
#   sleep 2
# done >> /tmp/status.txt
# echo "Jenkins started" >> /tmp/status.txt
# echo "Install Plugins" >> /tmp/status.txt

# sudo apt update
# sudo apt install openjdk-11-jre
# java -version
# openjdk version "11.0.12" 2021-07-20
# OpenJDK Runtime Environment (build 11.0.12+7-post-Debian-2)
# OpenJDK 64-Bit Server VM (build 11.0.12+7-post-Debian-2, mixed mode, sharing)
# curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
#     /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
#     https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
#     /etc/apt/sources.list.d/jenkins.list > /dev/null
# sudo apt update
# sudo apt-get install jenkins -y
# sudo systemctl enable jenkins
# sudo systemctl start jenkins
# sudo more /var/lib/jenkins/secrets/initialAdminPassword

# # install jenkins

# sudo apt update
# sudo apt install openjdk-11-jre
# java -version
# openjdk version "11.0.12" 2021-07-20
# OpenJDK Runtime Environment (build 11.0.12+7-post-Debian-2)
# OpenJDK 64-Bit Server VM (build 11.0.12+7-post-Debian-2, mixed mode, sharing)
# curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
#   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
#   https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
#   /etc/apt/sources.list.d/jenkins.list > /dev/null
# sudo apt-get update
# sudo apt-get install jenkins
# sudo apt-get update
# sudo apt-get install jenkins
# # sudo yum upgrade -y
# # sudo amazon-linux-extras install java-openjdk11 -y
# sudo apt-get install jenkins -y
# sudo systemctl enable jenkins
# sudo systemctl start jenkins
# sudo more /var/lib/jenkins/secrets/initialAdminPassword

# # install git
# sudo apt-get install git -y

# install terraform

# sudo yum install -y yum-utils
# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
# sudo yum -y install terraform

# install kubectl

# sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
# sudo chmod +x ./kubectl
# sudo mkdir -p $HOME/bin && sudo cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin


