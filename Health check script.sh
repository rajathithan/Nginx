#! /bin/bash

# Define variables

pa1-down = 0
pa2-down = 0


# Continous Loop
while true;
do


  # Health check for upstream server-1
  nc -w 2 -z 192.168.1.1 8007
  if [ $? -eq 0 ] && [[ "$pa1-down" -ne 0 ]]
  then 
    # Mark upstream server-1 is healthy
    pa1-down = 0

    # update NGINX config
    sudo sed -i 's/server 192.168.1.1:8007 down/server 192.168.1.1:8007/g' /etc/nginx/sites-available/uat10-vhost
    if [ $? -eq 0]
    then
        echo "Successfully marked upstream server 1 as up in Nginx Config" > /tmp/palaltouptimecheck.log
    fi

    # Restart Nginx
    echo "Restarting the nginx service"
    echo "======================================================"
    sudo service nginx restart > /tmp/palaltouptimecheck.log
    echo "Nginx service status"
    echo "======================================================"
    sudo service nginx status > /tmp/palaltouptimecheck.log
  else
    # To prevent marking the server as down which is already down
    if [[ "$pa1-down" -ne 1 ]]
    then
        # Mark upstream server-1 is down
        pa1-down = 1

        # update NGINX config
        sudo sed -i 's/server 192.168.1.1:8007/server 192.168.1.1:8007 down/g' /etc/nginx/sites-available/uat10-vhost
        if [ $? -eq 0]
        then
            echo "Successfully marked upstream server 1 as down in Nginx Config" > /tmp/palaltouptimecheck.log
        fi

        # Restart Nginx
        echo "Restarting the nginx service"
        echo "======================================================"
        sudo service nginx restart > /tmp/palaltouptimecheck.log
        echo "Nginx service status"
        echo "======================================================"
        sudo service nginx status > /tmp/palaltouptimecheck.log
    fi
  fi

  # Health check for upstream server-2
  nc -w 2 -z 192.168.1.2 8007
  if [ $? -eq 0 ] && [[ "$pa2-down" -ne 0 ]]
  then
    # Mark upstream server-2 is healthy
    pa2-down = 0

    # update NGINX config
    sudo sed -i 's/server 192.168.1.2:8007 down/server 192.168.1.2:8007/g' /etc/nginx/sites-available/uat10-vhost
    if [ $? -eq 0]
    then
        echo "Successfully marked upstream server 2 as up in Nginx Config" > /tmp/palaltouptimecheck.log
    fi

    # Restart Nginx
    echo "Restarting the nginx service"
    echo "======================================================"
    sudo service nginx restart > /tmp/palaltouptimecheck.log
    echo "Nginx service status"
    echo "======================================================"
    sudo service nginx status > /tmp/palaltouptimecheck.log
  else
    # To prevent marking the server as down which is already down
    if [[ "$pa2-down" -ne 1 ]]
    then
        # Mark upstream server-2 is down
        pa2-down = 1

        # update NGINX config
        sudo sed -i 's/server 192.168.1.2:8007/server 192.168.1.2:8007 down/g' /etc/nginx/sites-available/uat10-vhost
        if [ $? -eq 0]
        then
            echo "Successfully marked upstream server 2 as down in Nginx Config" > /tmp/palaltouptimecheck.log
        fi

        # Restart Nginx
        echo "Restarting the nginx service"
        echo "======================================================"
        sudo service nginx restart > /tmp/palaltouptimecheck.log
        echo "Nginx service status"
        echo "======================================================"
        sudo service nginx status > /tmp/palaltouptimecheck.log
    fi
  fi


done
