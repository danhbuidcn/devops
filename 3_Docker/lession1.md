-------------------------------------------Agenda-----------------------------

docker build -t my-nodejs-image .
docker tag my-nodejs-image your-repository/my-nodejs-image:latest

docker push your-repository/my-nodejs-image:latest
docker run -d -p 8080:8080 your-repository/my-nodejs-image:latest
curl http://localhost:8080

---
# Docker Host:
- Docker host là máy tính hoặc máy chủ vật lý hoặc ảo hóa mà Docker được cài đặt và chạy trên đó. 
- Docker host cung cấp môi trường để chạy các container Docker. 
- Container chia sẻ tài nguyên của Docker host, chẳng hạn như CPU, RAM, lưu trữ và mạng.

# Docker Engine: 
- Docker Engine là một nền tảng để tạo và quản lý container.
- Nó bao gồm Docker daemon, API Docker, và Docker CLI. 
- Docker daemon là một dịch vụ chạy trên Docker host, quản lý việc tạo, chạy và quản lý các container. 
- Docker CLI (Command Line Interface) là công cụ dòng lệnh cho phép người dùng tương tác với Docker Engine thông qua các lệnh. 
- API Docker cho phép các ứng dụng khác giao tiếp với Docker Engine.

# Docker Network: 
- Docker Network là một phần của Docker Engine quản lý mạng cho các container. 
- Nó cho phép container tương tác với mạng và với nhau. 
- Docker hỗ trợ nhiều loại mạng, bao gồm mạng mặc định, mạng giao tiếp giữa các container, và khả năng tạo mạng riêng.

# Docker Daemon: 
- Là dịch vụ quản lý Docker trên máy chủ.
- Docker daemon (hoặc Dockerd) là một dịch vụ nền chạy trên Docker host. 
- Nó là thành phần trung tâm của Docker Engine và quản lý các hoạt động của container.
- Docker daemon lắng nghe các yêu cầu từ Docker CLI hoặc ứng dụng khác thông qua API Docker, và sau đó thực hiện các nhiệm vụ như tạo, quản lý và chạy các container.
