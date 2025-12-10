1) docker build -t ssh-server-ubuntu . 

2) docker run -v /var/run/docker.sock:/var/run/docker.sock -t ssh-server-ubuntu

3) another terminal

4) ansible-playbook nginx.yml -i my.hosts --extra-vars 'ansible_sudo_pass=root'

5) ansible-playbook docker.yml -i my.hosts --extra-vars 'ansible_sudo_pass=root'
if check docker is active failed repeat command xd