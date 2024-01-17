#!/bin/bash
        echo "If any command getting failed script will exit at the same stage"
        set -e
        echo "#Creating log file"
>/tmp/addhostlog.txt
        input_file="input_file.txt"
        if [ -f "$input_file" ]; then
        mapfile -t input_lines < "$input_file"
        cm_host="${lines[0]}"
        input_lines=("${lines[@]:1}")
        for line in "${input_lines[@]}"
        do
        host_name=$(echo "$line" | awk -F' ' '{print $1}')
        services=$(echo "$line" | awk -F' ' '{print $2}')
        echo "Hostname: $host_name"
        echo "Services: $services"
        echo "#Getting cloudera-manager repo file from the CM server"
        scp root@$cm_host:/etc/yum.repos.d/save/cloudera-manager.repo root@$host_name:/etc/yum.repos.d/
        echo "#Installing krb5-workstation krb5-libs pre-requisite"
        ssh root@$host_name "yum install krb5-workstation krb5-libs -y" >> /tmp/addhostlog.txt
	echo "#Copying Clouder manager-agent config file"
        scp root@$cm_host:/etc/cloudera-scm-agent/config.ini root@$host_name:/etc/cloudera-scm-agent/
        echo "#Starting cloudera-scm-agent"
        ssh root@$host_name "/bin/systemctl start cloudera-scm-agent.service" >> /tmp/addhostlog.txt
        sleep 100
        echo "#Checking cloudera-manager-agent status"
        ssh root@$host_name "/bin/systemctl status cloudera-scm-agent.service" >> /tmp/addhostlog.txt
        IFS=',' read -ra serviceArray <<< "$services"
        echo "Individual services:"
        for service in "${serviceArray[@]}"
         do
                svc1=$(echo $service | tr -d "{")
                svc2=$(echo $svc1 | tr -d "}")
                svc=$(echo $svc2 | cut -d ":" -f1)
                name=$(echo $svc2 | cut -d ":" -f2)
                role=$(echo $svc2 | cut -d ":" -f3)
                echo "$svc"
                echo "$name"
                echo "$role"
	echo "$host_name"
        echo "Getting api version from API" >> /tmp/addhostlog.txt
        apiversion=`curl http://$cm_host:7180/static/apidocs/ui/swagger.json | grep -i basePath |tr -d '"' | tr -d ',' | cut -d "/" -f3` >> /tmp/addhostlog.txt
        echo "Getting hostid from API" >> /tmp/addhostlog.txt
        host_id=`curl -X GET "http://$cm_host:7180/api/$apiversion/hosts/$host_name?view=full" -H "accept: application/json" --user vinavi2:vinavi2 | grep -i hostId | awk -F ": " '{print $2}' | tr -d '"' | tr -d ','` >> /tmp/addhostlog.txt
        echo "Getting clustername from API" >> /tmp/addhostlog.txt
        cluster_name=` curl -X GET "http://$cm_host:7180/api/$apiversion/hosts/$host_name?view=full" -H "accept: application/json" --user vinavi2:vinavi2 | grep -i clusterName | awk -F ": " '{print $2}' | tr -d '"' | tr -d ',' |tail -1` >> /tmp/addhostlog.txt
        echo "Adding roles to the hosts" >> /tmp/addhostlog.txt
	curl -X POST "http://$cm_host:7180/api/$apiversion/clusters/$cluster_name/services/$svc/roles" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"items\": [ { \"name\": \"$name\", \"type\": \"$role\", \"hostRef\": { \"hostId\": \"$host_id\" } } ] }" --user vinavi2:vinavi2 >> /tmp/addhostlog.txt
        echo "Starting all the role which is added"
        curl -X POST "http://$cm_host:7180/api/v54/cm/commands/hostsStartRoles" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"items\": [ \"$host_name\" ]}" --user vinavi2:vinavi2 >> /tmp/addhostlog.txt
        done
        echo "$host_name added succeefully to the cluster"
    done
else
    echo "Error: Input file '$input_file' not found."
fi