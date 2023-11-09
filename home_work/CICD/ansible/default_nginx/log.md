


sau khi run `ansible-playbook -i inventory.ini deploy_nginx.yml` thì nhận được lỗi sau

```
PLAY [Deploy Nginx on EC2 Instances] *****************************************************************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************************************************************
The authenticity of host '13.215.179.9 (13.215.179.9)' can't be established.
ED25519 key fingerprint is SHA256:nwSIiqc6c8aXYrhbafkeB2XpkjQazx7Wh/FO1eHv+bY.
This key is not known by any other names
The authenticity of host '13.215.191.229 (13.215.191.229)' can't be established.
ED25519 key fingerprint is SHA256:ydS2KG+TiyOrKVa9SfENA49RSpGyBjWVIxQqkq7Gue0.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:5: [hashed name]
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
[WARNING]: Platform linux on host ec2-instance-1 is using the discovered Python interpreter at /usr/bin/python3.9, but future installation of another Python interpreter could change the
meaning of that path. See https://docs.ansible.com/ansible-core/2.15/reference_appendices/interpreter_discovery.html for more information.
ok: [ec2-instance-1]

fatal: [ec2-instance-2]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: Host key verification failed.", "unreachable": true}

TASK [nginxinc.nginx : Validate distribution and role variables] *************************************************************************************************************************
included: /home/thuongbv/.ansible/roles/nginxinc.nginx/tasks/validate/validate.yml for ec2-instance-1

TASK [nginxinc.nginx : Check whether you are using a supported NGINX distribution] *******************************************************************************************************
fatal: [ec2-instance-1]: FAILED! => {
    "assertion": false,
    "changed": false,
    "evaluated_to": false,
    "msg": "Your distribution, Amazon Linux 2023 (x86_64), is not supported by NGINX Open Source."
}
...ignoring

TASK [nginxinc.nginx : Check that 'nginx_setup' is an allowed value] *********************************************************************************************************************
ok: [ec2-instance-1] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [nginxinc.nginx : Check that 'nginx_branch' is an allowed value] ********************************************************************************************************************
ok: [ec2-instance-1] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [nginxinc.nginx : Check that 'nginx_install_from' is an allowed value] **************************************************************************************************************
ok: [ec2-instance-1] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [nginxinc.nginx : Set up prerequisites] *********************************************************************************************************************************************
included: /home/thuongbv/.ansible/roles/nginxinc.nginx/tasks/prerequisites/prerequisites.yml for ec2-instance-1

TASK [nginxinc.nginx : Install dependencies] *********************************************************************************************************************************************
included: /home/thuongbv/.ansible/roles/nginxinc.nginx/tasks/prerequisites/install-dependencies.yml for ec2-instance-1

TASK [nginxinc.nginx : (Alpine Linux) Install dependencies] ******************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : (Debian/Ubuntu) Install dependencies] *****************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : (Amazon Linux/CentOS/Oracle Linux/RHEL) Install dependencies] *****************************************************************************************************

ok: [ec2-instance-1]

TASK [nginxinc.nginx : (SLES) Install dependencies] **************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : (FreeBSD) Install dependencies using package(s)] ******************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : (FreeBSD) Install dependencies using port(s)] *********************************************************************************************************************
skipping: [ec2-instance-1] => (item=security/ca_root_nss) 
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Check if SELinux is enabled] **************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Configure SELinux] ************************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Set up signing keys] **********************************************************************************************************************************************
included: /home/thuongbv/.ansible/roles/nginxinc.nginx/tasks/keys/setup-keys.yml for ec2-instance-1

TASK [nginxinc.nginx : (Alpine Linux) Set up NGINX signing key URL] **********************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : (Alpine Linux) Download NGINX signing key] ************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : (Debian/Red Hat/SLES OSs) Set up NGINX signing key URL] ***********************************************************************************************************
ok: [ec2-instance-1]

TASK [nginxinc.nginx : (Debian/Ubuntu) Add NGINX signing key] ****************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : (Red Hat/SLES OSs) Add NGINX signing key] *************************************************************************************************************************
changed: [ec2-instance-1]

TASK [nginxinc.nginx : Install NGINX Open Source] ****************************************************************************************************************************************
included: /home/thuongbv/.ansible/roles/nginxinc.nginx/tasks/opensource/install-oss.yml for ec2-instance-1

TASK [nginxinc.nginx : Install NGINX from the official package repository] ***************************************************************************************************************
included: /home/thuongbv/.ansible/roles/nginxinc.nginx/tasks/opensource/install-redhat.yml for ec2-instance-1

TASK [nginxinc.nginx : (AlmaLinux/Amazon Linux/CentOS/Oracle Linux/RHEL/Rocky Linux) Configure NGINX repository] *************************************************************************
changed: [ec2-instance-1]

TASK [nginxinc.nginx : (AlmaLinux/Amazon Linux/CentOS/Oracle Linux/RHEL/Rocky Linux) Force Yum cache refresh] ****************************************************************************
ok: [ec2-instance-1]

TASK [nginxinc.nginx : (AlmaLinux/Amazon Linux/CentOS/Oracle Linux/RHEL/Rocky Linux) Install NGINX] **************************************************************************************
changed: [ec2-instance-1]

TASK [nginxinc.nginx : Install NGINX from the distribution's package repository] *********************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Install NGINX from source] ****************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Install NGINX in Unix systems] ************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Set up NGINX Plus license] ****************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Install NGINX Plus] ***********************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Install NGINX dynamic modules] ************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Remove NGINX Plus license] ****************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Modify systemd parameters] ****************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Trigger handlers if necessary] ************************************************************************************************************************************

RUNNING HANDLER [nginxinc.nginx : (Handler) Start/reload NGINX] **************************************************************************************************************************
changed: [ec2-instance-1]

RUNNING HANDLER [nginxinc.nginx : (Handler) Check NGINX] *********************************************************************************************************************************
ok: [ec2-instance-1]

RUNNING HANDLER [nginxinc.nginx : (Handler) Print NGINX error if syntax check fails] *****************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Debug NGINX output] ***********************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Configure logrotate for NGINX] ************************************************************************************************************************************
skipping: [ec2-instance-1]

TASK [nginxinc.nginx : Install NGINX Amplify] ********************************************************************************************************************************************
skipping: [ec2-instance-1]

PLAY RECAP *******************************************************************************************************************************************************************************
ec2-instance-1             : ok=19   changed=4    unreachable=0    failed=0    skipped=22   rescued=0    ignored=1   
ec2-instance-2             : ok=0    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0 
```