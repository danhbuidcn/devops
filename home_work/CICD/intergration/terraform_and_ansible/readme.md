# Topic

1. Terraform -> EC2, DB
 
2. Build (Unit - Vtest + Sonar scan) and deploy code application -> EC2
 
3. Ansible Config
 
4. Deploy master data for DB

-------
# Example 1
Tích hợp terraform và ansible 
- Terraform: khai báo cấu trúc
    + AWS: tạo infrastructure với 1 VPC, 1 public subnet, Sercurity Group(allow SSH/ myIP nếu là https)
    + Terraform: Tạo 2 EC2 với SG đã tạo ở B1
- Asible: lập trình
    + Cài đặt nginx trên 2 EC2


- Tạo local key pair rồi import vào aws key pair
- Nếu thêm key pair sau khi đã apply thì ec2 sẽ bị xóa đi tạo lại
```
$ cd terraform
$ terraform init
$ terraform plan
$ terraform apply
$ terraform output

$ cd ../ansible
$ ansible -i inventory/hosts.ini -m ping all // call đến khi trả về success
$ ansible-playbook -i inventory/hosts.ini install_nginx.yml

$ cd ../terraform
$ terraform destroy
```



