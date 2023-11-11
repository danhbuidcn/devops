
xảy ra lỗi khi chạy `ansible-playbook -i inventory/hosts.ini install_nginx.yml`

```
PLAY [Install and configure Nginx] *******************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************
The authenticity of host '18.142.229.108 (18.142.229.108)' can't be established.
ED25519 key fingerprint is SHA256:DXsm/VyWn8OLwojjCo+Qmo7iEijNYwiCzR6a8ttxGfA.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? [WARNING]: Platform linux on host ec2-instance-1 is using the discovered Python interpreter at /usr/bin/python3.9, but future installation of another Python interpreter could change the
meaning of that path. See https://docs.ansible.com/ansible-core/2.15/reference_appendices/interpreter_discovery.html for more information.
ok: [ec2-instance-1]

fatal: [ec2-instance-2]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: Host key verification failed.", "unreachable": true}

TASK [./roles/webserver : Update APT cache] **********************************************************************************************************************************************


[WARNING]: Updating cache and auto-installing missing dependency: python3-apt
fatal: [ec2-instance-1]: FAILED! => {"changed": false, "cmd": "apt-get update", "msg": "[Errno 2] No such file or directory: b'apt-get'", "rc": 2, "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}

PLAY RECAP *******************************************************************************************************************************************************************************
ec2-instance-1             : ok=1    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
ec2-instance-2             : ok=0    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0  
```