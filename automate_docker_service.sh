services=("profile-service" "dashboard-frontend" "gateway-service" "description-service" "homescreen-service" "auth-service" "search-service")

function getService(){
	service=$(yq '.services[] | .container_name ' docker-compose.yaml | fzf)
	return service
}
startProd() {
     docker-compose -f docker-compose.yml pull
     docker-compose up -d --force-recreate
}

if [ "$1" == "start:prod" ]
then
        startProd
fi

if [ "$1" == "stop" ]
then
    docker-compose stop
    docker-compose rm
fi

updateService() {
    read -p "Enter Service Name: " name_var
    echo "Pulling the service" $name_var
    pullService "$name_var"
}
pullService() {
   cd $1
   npm install
   git pull
   cd ..
   echo "Building the service" $1
   docker-compose build $1
   echo "Pushing image to docker for service" $1
   docker-compose push $1
   echo "Restarting the service" $1
   docker-compose up -d --force-recreate --no-deps $1
}

if [ "$1" == "update:service" ]
then
	echo $(getService)
	fi

startProd() {
     docker-compose -f docker-compose.yml pull
     docker-compose up -d --force-recreate
}

if [ "$1" == "start:prod" ]
then
        startProd
fi

if [ "$1" == "stop" ]
then
    docker-compose stop
    docker-compose rm
fi

updateService() {
    read -p "Enter Service Name: " name_var
    echo "Pulling the service" $name_var
    pullService "$name_var"
}
pullService() {
   cd $1
   npm install
   git pull
   cd ..
   echo "Building the service" $1
   docker-compose build $1
   echo "Pushing image to docker for service" $1
   docker-compose push $1
   echo "Restarting the service" $1
   docker-compose up -d --force-recreate --no-deps $1
}

if [ "$1" == "update:service" ]
then
	service=$(yq '.services[] | .container_name ' docker-compose.yaml | fzf)
     echo "Pulling the service" $service
     pullService "$service"
elif [ "$1" == "update:all:service" ]
then
     for name_var in ${services[@]}; do
        pullService "$name_var"
     done
fi
