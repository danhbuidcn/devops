# Overview
- Terraform là một công cụ IaC, dùng để quản lý và triển khai hạ tầng máy chủ, mạng, lưu trữ và các tài nguyên khác trong môi trường đám mây.

initial insfrastructure setup => manage infrastructure => initial application setup => ~~Manage Applications~~

---

# Ưu điểm:

- Tự động hóa triển khai: tự động triển khai cơ sở hạ tầng bằng mã

- Đáng tin cậy và có khả năng tái sử dụng: mã terraform có thể được lưu lại và tái sử dụng

- Hỗ trợ nhiều nền tảng: gg cloud, aws, azure, vmware

- Truy vết và quản lý phiên bản: giúp theo dõi thay đổi trong cơ sở hạ tầng và quản lý phiên bảo của mã IaC.

- Cộng đồng lớn

- Tự động hóa toàn bộ quy trình

# Nhược điểm:

- Không có quyền truy cập sâu: terraform không cung cấp các tính năng tiên tiến để theo dõi và quản lý tài nguyên cụ thể trong môi trường cloud.

- Dễ bị xung đột tài nguyên nếu vừa tạo bằng mã IaC vừa tạo resource bằng Management Console.

# Key words

- terraform init: khỏi tạo môi trường làm việc với terraform.

- terraform plan : tạo một execution plan
    + Sử dụng provider để thực hiện plan và hiển thị các resource sẽ thay đổi. 
    + Tìm file terraform.tfstate để kiểm tra current state của cloud provide, nếu không thấy file thì trên cloud đang không có resource nào.

- terraform apply: thực hiện các thay đổi
    + apply các resource đã được khai báo. so sánh current sate với desired state để đưa ra các thay đổi.

- terraform output: hiển thị thông tin resource
   + key word - có cho phép ẩn/ hiện các thông tin nhạy cảm trong file .tf hay không. 
   + syntax - hiển thị output của attr file terraform

- terraform state: chứa thông tin về resource đã tạo chính là current state. ngăn ngừa conflic nếu có 2 người cùng thay đổi.

- terrform destroy: tìm đển file .tfstate để tìm các resource đang có và xóa hết các resource.

- Có 2 cách để cung cấp phần mềm trên instance :
  ▪ Xây dựng AMI tùy chỉnh của riêng mình và kết hợp phần mềm của bạn với hình ảnh
    ✔ Packer là một công cụ tuyệt vời để thực hiện việc này
  ▪ Một cách khác để khởi động các AMI được tiêu chuẩn hóa và sau đó cài đặt phần mềm bạn cần vào đó
    ✔ Sử dụng file uploads
    ✔ Sử dụng các công cụ tự động hóa như chef, puppet,  ansible
    ✔ Sử dụng remote exec

---

- remote state: quản lý vesion giống git.

- data source: truy cập thông tin về các tài nguyên tồn tại trong cloud mà bạn không quản lý. Dùng để cung cấp thông tin cho resource hoặc module khác

- resource: thể hiện một tài nguyên cụ thể trong hạ tầng như máy chủ ảo, mạng .v.v.

- template: một file hoặc chuỗi văn bản chứa mã terraform, sử dụng để tạo hoặc tùy chỉnh các tài nguyên.

---
Nếu bạn đã tạo sẵn một VPC với một subnet trên cloud và muốn sử dụng Terraform để tạo thêm hai subnet khác trong VPC đó, bạn cần sử dụng Terraform để quản lý các subnet mới bằng cách thêm chúng vào tệp cấu hình Terraform của bạn. Dưới đây là ví dụ về cách thêm hai subnet mới vào một VPC đã tồn tại trong Terraform :

```
# Khai báo provider (AWS)
provider "aws" {
  region = "us-east-1" # Thay thế vùng theo nhu cầu của bạn
}

# Khai báo ID của VPC đã tồn tại (thay thế "vpc-12345678" bằng ID thực tế của VPC)
data "aws_vpc" "existing_vpc" {
  id = "vpc-12345678" # ID của VPC đã tồn tại
}

# Tạo Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id                  = data.aws_vpc.existing_vpc.id
  cidr_block              = "10.0.3.0/24" # Điều chỉnh dải IP CIDR cho Subnet 1
  availability_zone       = "us-east-1a" # Thay thế khu vực AZ theo nhu cầu của bạn

  tags = {
    Name = "subnet-1"
  }
}

# Tạo Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id                  = data.aws_vpc.existing_vpc.id
  cidr_block              = "10.0.4.0/24" # Điều chỉnh dải IP CIDR cho Subnet 2
  availability_zone       = "us-east-1b" # Thay thế khu vực AZ theo nhu cầu của bạn

  tags = {
    Name = "subnet-2"
  }
}
```
