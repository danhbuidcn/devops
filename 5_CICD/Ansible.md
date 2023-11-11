# Ansible
- Là công cụ mã nguồi mở dùng để tự động hóa quá trình quản lý hệ thống và triển khai ứng dụng 
- Hoạt động trên ngôn ngữ YAML để định nghĩa các nghiệm vụ và quy trình triển khai

~~initial insfrastructure setup~~ => manage infrastructure => initial application setup => Manage Applications

- Agentless:
    + Ansible là một công cụ agentless, có nghĩa là nó không yêu cầu cài đặt phần mềm nào trên máy chủ mục tiêu để quản lý
    + Ansible thực hiện SSH và WinRM để kết nối và thực hiện các nhiệm vụ từ xa
- Tiny learning curve:
    + Đề cập đến việc bắt đầu sử dụng và thực hiện các công việc cơ bản trong Ansible rất dễ dàng
    + Cú pháp trong Ansible dễ đọc, dễ viết, cộng đồng hỗ trợ mạnh mẽ

- SSH : giao thức mạng cho phép kết nối máy tính local với máy trên server
- Thiết lập SSH tới máy chủ trên cloud:
```
    $ ssh-keygen // sinh ra ssh key, nhập tên file là id_rsa_ansible
    $ cd ~/.ssh // lấy ra ssh public key vừa sinh ra
    $ vim .ssh/authorized_keys // vào màn hình console của instance trên cloud để chạy, dán ssh public key đã copy vào đây
    $ ssh -i .ssh/id_rsa_ansible user_name@ip // chạy dưới máy local
```

# Ansible Inventory
- Là một danh sách các máy chủ mà ansible quản lý
- Bao gồm các thông tin như địa chỉ IP, tên máy chủ, cổng SSH, người dùng SSH, mật khẩu, và nhiều thông tin khác về máy chủ
- Có thể group các host lại thành một nhóm
- Có thể có 2 định dạng hosts.ini hoặc host.yaml 

- Inventory parameters: 
    + Là các thông số được sử dụng trong inventory để cung cấp thông tin về máy chủ, nhóm máy chủ hoặc toàn bộ inventory
    + Một số thông số quan trọng:
        + ansible_host: xác định địa chỉ IP hoặc tên miền của máy chủ
        + ansible_port: xác định cổng SSH mà ansible sử dụng để kết nối đến máy chủ
        + ansible_user: xác định user ssh để kết nối đến remote host
        + ansible_private_key_file: đường dẫn đến private key
        + ansible_become: kích hoạt quyền trở thành một user khác (sudo)
        + ansible_become_pass: mật khẩu của user sudo


# Ansible-playbook
- Dùng để thực thi các task và quy trình được khai báo ở playbook
- Playbook là một tệp YAML chứa một loạt các task và cấu hình để đảm bảo hệ thống ở trạng thái mong muốn
- Roles được sử dụng để quản lý và tái sử dụng mã cấu hình, tạo ứng dụng và triển khai các task trên remote host
- Dictionary và simple key value 

```
// [hello, by, good]
- hello 
- bye
- good

---
// map/dictionary of key-value pairs
name: user_name
age: 30

---
// list/array of elements [element1, element2]

// element1
- name: user_name
  age: 30

// element2
- name: user_name2
  age: 32 

---
include_new_lines: |
    line1
    line2
=> print(include_new_lines) = "line1\nline2"

---
fold_newlines: >
    line1
    line2
=> print(fold_newlines) = "line1 line2"

```

# Ansible Galaxy 
- Kho lưu trữ các roles và playbook đã được xây dựng sẵn và chia sẻ bởi cộng đồng
- Cho phép tìm kiếm, tải về và sử dụng các roles và playbook có sẵn để giảm công sức phát triển và triển khai

# Ansible Tower
- Đã đổi tên thành Red Hat Ansible Automation Platform
- Giải pháp của Ansible cho việc quản lý, tự động hóa và theo dõi các quy trình triển khai và quản lý hệ thống
- Cung cấp giao diện web dễ sử dụng, quản lý xác thực, lịch trình tác vụ, báo cáo và theo dõi

---
Nếu có 100 remote host, vậy muốn cài đặt package hoặc software thì phải set ssh key cho 100 remote host có đúng không ?

- Bạn có thể tạo key-pair rồi gán cho 100 instance.
- Sử dụng file key.pem của để thực hiện ssh đến 100 instance như sau:

```
$ cd ~/.ssh/
$ ssh-keygen -t rsa // đặt tên id_rsa_ansible
$ cat id_rsa_ansible.pub // import key pairs vào keypairs của aws instance
$ ssh -i "id_rsa_ansible.pem" ec2-user@ec2_public_ip // test connect
```

---
# Tệp ansible.cfg dùng để tuy chỉnh và định hình ansible.
1. Cấu hình kết nối SSH
2. Cấu hình invertory
3. Thiết lập môi trường và biến
4. Quản lý cache
5. Cấu hình callback plugins
6. Quản lý thư mục và đường dẫn

---
# Cấu trúc thư mục 

```
ansible-project/
|-- ansible.cfg   //
|-- inventory.ini
|-- playbook.yml
|-- roles/
    |-- my_role/
    |   |-- defaults/
    |   |   |-- main.yml
    |   |-- files/
    |   |-- handlers/
    |   |   |-- main.yml
    |   |-- meta/
    |   |   |-- main.yml
    |   |-- tasks/
    |   |   |-- main.yml
    |   |-- templates/
    |   |-- tests/
    |   |   |-- inventory
    |   |   |-- test.yml
    |   |-- vars/
    |   |   |-- main.yml
    |-- another_role/
    |   |-- ...
```

- `ansible.cfg` cấu hình vị trí tệp inventory trỏ đến inventory.ini trong thư mục đã tạo
- `inventory.ini` cấu hinhg IP address, vị trí tệp private key để kết nối với remote host.
- `playbook.yml` cấu hình playbook name, remote hosts và role sẽ sử dụng

- `roles/my_role` và `roles/another_role`: thư mục chứa tên của role. Mỗi role được đặt trong một thư mục riêng biệt.
    + `defaults/main.yml`: chứa các giá trị mặc định cho các biến. Các giá trị này có thể bị ghi đè trong playbook.
    + `files/`: nơi để chứa các tệp tin cần copy đến máy chủ mục tiêu.
    + `handlers/main.yml`: chứa các handlers, các tác vụ sẽ được gọi bởi các tác vụ trong tasks khi có sự thay đổi.
    + `meta/main.yml`: chứa metadata về role, chẳng hạn như các phụ thuộc.
    + `tasks/main.yml`: chứa danh sách các nhiệm vụ mà role sẽ thực hiện.
    + `templates/`: chứa các mẫu (templates) cho các tệp cấu hình.
    + `tests/`: nơi để chứa các tệp và script kiểm thử.
    + `vars/main.yml`: chứa các biến được sử dụng trong role.


---
Các hướng xử lý khi practive với ansible
- Lên kế hoạch. có bao nhiêu resource, cần làm gì trên mỗi resource. 
- Thực hiện test với 1 remote host trước khi set up với group host
- Triển khai trên hệ thống gồm nhiều group host
