#cmd = Mixlib::ShellOut.new("ps -ef | grep tomcat |grep 8080 | grep -v grep  |awk '{print $2}'|wc -l")
#cmd.run_command
#temp = cmd.stdout
#pwp_pid = temp.delete("\n")
##ruby_block 'chek pwp' do
#if  cmd.run_command.stdout.to_i == 0 
#	Log.info('cate_rhel_tomcat::install Tomcat ==> pwp is not running')
#	#exit 1
#	else
#	cmd = Mixlib::ShellOut.new("kill -9 pwp_pid") 
##	3cmd.run_command 
##	temp = cmd.stdout
#ChefLog.info('Tomcat is running on {pwp_pid} is killed')
#end 
#end

cookbook_file '/tmp/jenkins_tomcat_war.sh' do
  source 'jenkins_tomcat_war.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'install-jenkins' do
  command 'sh /tmp/jenkins_tomcat_war.sh'
end
