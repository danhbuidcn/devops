# default_nginx
- Triển khai Nginx trên 2 EC2 instances trên AWS bằng Ansible, sử dụng một playbook Ansible có sẵn từ Ansible Galaxy (kho lưu trữ các role)

- Chuẩn bị EC2 với key-pair
```
$ cd ~/.ssh/
$ ssh-keygen -t rsa // đặt tên id_rsa_ansible
$ cat id_rsa_ansible.pub // import key pairs vào keypairs của aws instance
$ ssh -i "id_rsa_ansible.pem" ec2-user@ec2_public_ip // test connect
```
- Chạy playbook

```
$ ansible-galaxy install nginxinc.nginx // cài đặt role từ ansible galaxy

$ ansible-playbook -i inventory.ini deploy_nginx.yml
$ ansible -i inventory.ini -m ping your_ec2_group_name // all: ping tới tất cả các host mà ansible sẽ connect
```
=> kết quả: chỉ có instance 1 hoạt động, instance 2 setup thất bại

# custom_nginx
- Triển khai và cấu hình một ứng dụng web đơn giản (ví dụ: Nginx) trên hai EC2 instances sử dụng Ansible và role tự định nghĩa 

- Chuẩn Bị EC2 Instances: như ở mục default_nginx
- Chạy playbook
```
$ ansible-playbook -i inventory/hosts.ini install_nginx.yml
```

