#!/bin/bash
# Put this script in the cockpit-machines dir
# Usage: run_verify.sh $test_ip $browser(chromium or firefox) $result_dir

if [ $# == 3 ] ;then
	test_ip=$1
	browser=$2
	result_dir=$3

	#Create result dir like: cockpit-machines_242-1_RHEL-8.5.0-20210423.n.0
	rm -rf $result_dir
	mkdir -p $result_dir/$browser

	#Execute tests
	scripts=`ls test/check-machines-* | awk -F"/" '{print $2}'`
	for script in $scripts
	do
#		echo $script
		echo "Logfile:$result_dir/$browser/$script"
		TEST_BROWSER=$browser test/$script --machine $test_ip |& tee $result_dir/$browser/$script
	done

#	# Upload to nfs server, please update manually
#	scp -r $result_dir/ root@10.73.196.185:/var/www/html/results/iscsi/cockpit-machines/
#	#Result: http://10.73.196.185/results/iscsi/cockpit-machines/$result_dir/
else
        echo "You have not input the right agrs!"
	echo "Usage:run_verify.sh \$test_ip \$browser(chromium or firefox) \$result_dir"
fi
