# How to run

- Tạo file variable.tf để khai báo các biến: aws_access_key, aws_secret_key, aws_region, aws_availability_zone

$ terraform init > khởi tạo môi trường làm việc với terraform.

$ terraform plan > tạo một execution plan

$ terraform apply > thực hiện các thay đổi

$ terraform output > hiển thị thông tin resource

$ terraform destroy > xóa các resource được khai báo trong tfstate
