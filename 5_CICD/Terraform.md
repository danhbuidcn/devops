# Overview
- Terraform là một công cụ IaC, dùng để quản lý và triển khai hạ tầng máy chủ, mạng, lưu trữ và các tài nguyên khác trong môi trường đám mây.
Action:

initial insfrastructure setup => manage infrastructure => initial application setup

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

---

- remote state: quản lý vesion giống git.

- data source: truy cập thông tin về các tài nguyên tồn tại trong cloud mà bạn không quản lý.

- resource: thể hiện một tài nguyên cụ thể trong hạ tầng.

- template: một file hoặc chuỗi văn bản chứa mã terraform, sử dụng để tạo hoặc tùy chỉnh các tài nguyên.
