#!/bin/bash 
#written by samson 09/07/16
source conf/setting.conf
source fuction/get_local_ver
source fuction/get_server_ver
source fuction/download_package
source fuction/log_stat
source fuction/update
ip=$(echo $ip | sed 's/\r//g')
host=$(echo $host | sed 's/\r//g')
passwd=$(echo $passwd | sed 's/\r//g')
supply_process=$(echo $supply_process | sed 's/\r//g')
user=$(echo $user | sed 's/\r//g')
wget_passwd=$(echo $wget_passwd | sed 's/\r//g')


for i in $supply_process
do
	echo \#\#$i >> log/`/bin/date +%F`_update.log
	get_local_ver $i
	if [[ ! $local_ver ]] ; then 
		echo "出错，无法获取本地版本信息"
		echo `/bin/date +%H:%M:%S` "无法获取本地版本信息" >> log/`/bin/date +%F`_update.log
		continue
	fi
	get_server_ver $host $i
	if [[ ! $server_ver ]] ; then 
		echo "出错，无法获取服务器版本信息"
		echo `date +%H:%M:%S` "无法获取服务器版本信息" >> log/`/bin/date +%F`_update.log
		continue
	else
		mysql -uroot -p$passwd -h localhost  -e "UPDATE updatedb.server_ver SET ver='$server_ver' WHERE name='$i';"
		server_ver=$(mysql -uroot -p$passwd -e "SELECT ver FROM updatedb.server_ver WHERE name='$i';" | sed -n '2p')
	fi
	download_package $i
	log_stat $wget_stat
	if [ $wget_stat == 0 ] ; then
		download_time=$(/bin/date +%F\ %H:%M:%S)
	fi
	if [ ! -f packages/$package_server ] ; then
		continue
		echo "找不到安装包" >> log/`/bin/date +%F`_update.log
	else
		update $package_server
		update_time=$(/bin/date +%F\ %H:%M:%S)
		#获取school_id
		school_id=$(mysql -uroot -p$passwd -h localhost -e "SELECT name FROM are_dis.zonekey_school WHERE url='http://$ip'" | sed -n '2p')
		#通过school_id/ip/name 获取id
		sql_server_id_check="SELECT id FROM updatedb.log WHERE school_id='$school_id' AND ip='$ip' AND name='$i'"
		server_check=$(mysql -uroot -p$passwd -h $host -e "$sql_server_id_check")
		if [[ $update_stat ]] && [ $update_stat == 0 ] ; then 
			#更新local数据库ver信息
			server_ver=$(mysql -uroot -p$passwd -e "SELECT ver FROM updatedb.server_ver WHERE name='$i';" | sed -n '2p')
			sql_update="UPDATE updatedb.local_ver SET ver='$server_ver' WHERE name='$i';"
			mysql -uroot -p$passwd -h localhost -e "$sql_update"
			#检查id是否为空，为空插入新数据，不为空则更新数据
			if [[ ! $server_check ]] ; then 
				sql_correct="INSERT INTO updatedb.log (school_id,name,ip,download_time,update_time,location_log) VALUES ('$school_id','$i','$ip','$download_time','$update_time','update complete');"
				mysql -uroot -p$passwd -h $host -e "$sql_correct"
			else
				server_id=$(mysql -uroot -p$passwd -h $host -e "$sql_server_id_check" | sed -n '2p')
				sql_update="UPDATE updatedb.log SET download_time='$download_time',update_time='$update_time',location_log='update complete' WHERE id='$server_id';"
				mysql -uroot -p$passwd -h $host -e "$sql_update"
			fi
		else
			#插入local错误日志
			sql_error="INSERT INTO updatedb.log (school_id,name,ip,download_time,update_time,location_log) VALUES ('$school_id','$i','$ip','$download_time','$update_time','update error');"
			mysql -uroot -p$passwd	-h localhost -e "$sql_error"
		fi
	fi
done

	
