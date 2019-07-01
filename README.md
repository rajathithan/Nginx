# Nginx
Nginx - automated server down configuration - Health check script


The health check script is used to check whether the upstream servers are up and running, this script will run on a continous loop and need to be configured after system startup.

If one of the upstream server is down , it will mark the server as down in the nginx config and restart the nginx server, it will again periodically monitor the health check of the servers and mark them back as healthy when they are reachable again. 
