#!/bin/bash

machines=( "vagrant" "vagrant2" "vagrant3" )
common_route="/home/dbartus/code_infr_projects"

for i in "${machines[@]}"
do
    #Concatenate route to vagrant machine and store in temporary var
    vg_route="${common_route}/$i"
    
    #Start the Vagrant VM
    cd $vg_route && vagrant up
    
done
