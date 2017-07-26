#!/bin/bash
#Installing Java, Tomcat and Jenkins
#Install JDK rpm 
if rpm -qa | grep jdk-8u92-linux-i586.rpm 2>&1 > /dev/null
	then 
		echo "JDK is already installed"
	else  
		rpm -i jdk-8u92-linux-i586.rpm
fi

#pre-install tomcat
sudo groupadd tomcat
getent passwd tomcat 
if [$? == 0]
	then 
		echo "Tomcat user already exist"
	else 
		sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
fi

#create a directory at /opt/tomcat
if [ -d "/opt/tomcat" ]
 then echo "tomcat directory present "
else 
	mkdir /opt/tomcat
fi

#Download the tomcat tar
cd /tmp && wget http://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.79/bin/apache-tomcat-7.0.79.tar.gz
# Extract it to the /opt/tomcat directory.
tar xf apache-tomcat-7.0.79.tar.gz -C /opt/tomcat/ --strip-components=1


#Download Jenkins is a 'war' file 
cd /opt/tomcat/webapp/
wget http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war


#Start Tomcat 
nohup /opt/tomcat/bin/startup.sh & 
##nohup for terminal protection and "&" will run process in background 

#Download jenkins-cli jar 
wget http://127.0.0.1:8080//jnlpJars/jenkins-cli.jar

#Install Plugin 
for Plugin_Name in git maven docker crowd 
do
java -jar /var/lib/jenkins/jenkins-cli.war -s http://127.0.0.1:8080/ install-plugin ${Plugin_Name}
done
