# summer-thon17
This project attempts to:
Create a new Docker Container (Dockerfile)
	Container Start and pull CentOS (done)
	Install bind utils for nslookup (done)
	Install wget (done)
	Copy into the container:
			Test script (done)
			Source Code to scan (done)
			Protex BOMs (done)
			TODO: An Exported container (as a tar ball)
		
docker-entryppoint.sh
	Parameterized $HUB_SERVER (Done)
	Link to nginx Hub container and Stress test container for network communication (Done)
	Once Hub is discovered, Download, extract, and install Linux scan-client (Done)
	Download and extract the protex BOM Import tool (Done)
Parameterized tests
		1. Scan performance source archives (Done)
		2. Import Bom (TODO - stretch)
		3. Scan  a container that’s been exported to a tar ball (TODO, try to get done for Monday?)	

Performance Source Archives:  You're going to need the performnance files located at https://blackducksoftware.sharefile.com/d-se7167205872408c9
Copy the performance/* to your local system such that the command within the Dockerfile:
COPY ./performance/artifacts/* /var/tmp/performance/
Will execute successfully and copies the DIRs and all files from your local system to /var/tmp/performance within the test container.  Feel free to modify the COPY command as needed.

To build  and run the container (and drop into shell inside the stress container:
docker build -t testhack . #; docker run -t -i --network hub_default --link <hub-nginx_CONTAINER ID>:hub_webserver_1 -e "HUB_SERVER=hub_webserver_1" testhack /bin/sh

e.g.
docker build -t testhack . #; docker run -t -i --network hub_default --link ac403453ded9:hub_webserver_1 -e "HUB_SERVER=hub_webserver_1" testhack /bin/sh

Just run the conatiner:
docker run -t -i --network hub_default --link <hub-nginx_CONTAINER ID>:hub_webserver_1 -e "HUB_SERVER=hub_webserver_1" testhack /bin/sh

e.g.
docker run -t -i --network hub_default --link ac403453ded9:hub_webserver_1 -e "HUB_SERVER=hub_webserver_1" testhack /bin/sh
