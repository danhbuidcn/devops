# Sử dụng một base image, ví dụ Ubuntu
FROM ubuntu

# Cài đặt nginx
RUN apt-get update && apt-get install -y nginx

# Sao chép tệp HTML từ máy cục bộ vào container
COPY index.html /var/www/html/

# Expose cổng 80 để truy cập nginx
EXPOSE 80

# Khởi động nginx khi container được khởi chạy
CMD ["nginx", "-g", "daemon off;"]

