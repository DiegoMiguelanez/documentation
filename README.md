<h1>Ansible Lab 1 - Installation and Inventory file basics</h1>
<ul>
<li>
Create VMs using vagrant and ssh to our control server
</li>
<li>
Copy /vagrant/hosts_file to /etc/hosts
</li>
<li>
Install ansible
</li>
<li>
Create an inventory file named hosts
</li>
<li>
Test out a command
</li>
<li>
Generate SSH Keys and copy to hosts
</li>
<li>
Test running ad-hoc commands to all hosts
</li>
<li>
Install python-simplejson module. This allows clients to be fully managed.
</li>
</ul>
<h3>Setup Vagrant and connect to ansible-control server</h3>


vagrant up <br>
 vagrant ssh ansible-control
<h3>Copy hosts file on ansible-control</h3>
cp /vagrant/hosts_file /etc/hosts 
<h3>Install Ansible</h3>
 sudo apt-get install ansible
<h3>Create a SSH key and copy to all servers</h3>
ssh-keygen <br>
ssh-copy-id localhost<br>
ssh-copy-id web01 && ssh-copy-id web02 && ssh-copy-id loadbalancer && ssh-copy-id db01
<h3>Run a ad-hoc command to the webstack group</h3>
ansible webstack -i hosts -m command -a hostname
<h3>Install python-simplejson</h3>
ansible all -i hosts -m command -a 'sudo apt-get -y install python-simplejson'



<h1>Ansible Lab 7 - Ansible Variables </h1>
Two types of variables. User set and "ansible facts".

<h2>Gather ansible facts, these are dynamic variables automatically gathered by ansible</h2>
Use setup module to gather facts about a system.
View the output and discovery any useful information
Use {{ ansible_facts['nodename'] }} for the nodename variable for the local host. Add this to the index.html file.
Use a loop to dynamically access the nodename of the two webservers. add this to the mysite configuration of nginx proxy server.
ansible -i hosts proxy -m setup >> ansible_facts.json
{{ ansible_facts['nodename'] }}

	{% for host in groups['webservers'] %}
        server {{ hostvars[host]['ansible_facts']['nodename'] }}:8000;
    {% endfor %}
<h2>Move user defined variables to a different location</h2>
Move your current variables into the group_vars/all variables
Add these variables to your nginx mysite configuration
Create host_vars folder and make a unique variable for web01
