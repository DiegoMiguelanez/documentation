#!/bin/bash

machines=( "vagrant" "vagrant2" "vagrant3" )
common_route="/home/dbartus/demoProjects"


if [[ $# -eq 0 ]]
then
    echo "Porfavor, Introduzca up o down como argumento"
    exit 0
fi


for i in "${machines[@]}"
do
    #Concatenate route to vagrant machine and store in temporary var
    vg_route="${common_route}/$i"
    
    if [[ $1 = "up" ]]
    then
    #Start the Vagrant VM
    cd $vg_route && vagrant up
    
    elif [[ $1 = "down" ]]
    then
    cd $vg_route && vagrant suspend
    
    else
    echo "Ha habido un error de argumentos"

    fi
done
