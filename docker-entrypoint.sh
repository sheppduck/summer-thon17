#!/bin/sh

env
if [ -z ${HUB_SERVER} ];
	then echo "HUB_SERVER is unset"; 
	echo $HUB_SERVER
	export HUB_SERVER=localhost
else 
	echo "HUB_SERVER is set to '$HUBSERVER'"; 
fi

echo "HUB SERVER = $HUB_SERVER"

# set the BDS_JAVA_HOME (I Hope)
export BDS_JAVA_HOME=/scan.cli-4.0.0/jre
echo "BDS_JAVA_HOME is set to '$BDS_JAVA_HOME'"

# set BD_HUB_PASSWORD to blackduck
export BD_HUB_PASSWORD=blackduck
echo "BD_HUB_PASSWORD is set to '$BD_HUB_PASSWORD'"

# resolve the HUB NGINX container/IP
until nslookup $HUB_SERVER ; do echo "$HUB_WEBSERVER NOT RESOLVED " ; exit 3 ;  

done 

# lets download the scan client
echo "Downloading HUB scan client"
wget https://$HUB_SERVER:8443/download/scan.cli.zip --no-check-certificate

# now lets download the Protex BOM Import tool
echo "Downloading Protex BOM Import Tool"
wget https://$HUB_SERVER:8443/download/scan.protex.cli.zip --no-check-certificate

# time to unzip the tools
echo "Unzipping packages"
unzip scan.cli.zip
unzip scan.protex.cli.zip

# change DIR into the /bin of scan client
cd scan.cli-4.0.0/bin

# Turn this on to debug everything!
# set -x


function test_1 {
	
	echo "Lets scan some files"
        # Need to change the path to the scan.cli.sh once its known where it'll be installed
	sh ./scan.cli.sh --scheme https --host $HUB_SERVER --port 8443 --username sysadmin --project performance --release 1.0.0 --verbose /var/tmp/performance
	
}

# Turn this on then the container will exit if a command fails
# set -e

function test_2 {
	echo "Scan something else"
	#sh ./scan.cli.sh --scheme https --host $HUB_SERVER --port 443 --username sysadmin --project performance --release 1.0.0 --verbose /var/tmp/<some-other-set-of-files>
}

test_1

test_2

/bin/sh
