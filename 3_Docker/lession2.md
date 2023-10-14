# Network driver:

❖ User-defined bridge networks are best when you need multiple containers to communicate on the same Docker host. ( kết nối các container lại với nhau)
❖ Host networks are best when the network stack should not be isolated from the Docker host, but you want other aspects of the container to be isolated. (dùng khi container muốn kết nối với các dịch vụ khác trên máy host)
❖ Overlay networks are best when you need containers running on different Docker hosts to communicate, or when multiple applications work together using swarm services. (kết nối các container trên các host khác nhau, setup các container cluster)
❖ Macvlan networks are best when you are migrating from a VM setup or need your containers to look like physical hosts on your network, each with a unique MAC address. (expose 1 internal network để bên ngoài gọi vô các container)
❖ None network tách biệt, chỉ dùng trong container, không share network với service/ container nào khác
❖ Third-party network plugins allow you to integrate Docker with specialized network stacks. (cài thông qua docker network plugin. sau đó tạo như network bình thường)
❖  IPvlan : IPv4, IPv6
https://docs.docker.com/network/network-tutorial-standalone/



Volume là một cách để lưu trữ và quản lý dữ liệu hoặc tập tin của các container Docker một cách riêng lẻ và bên ngoài container gốc. Volumes được sử dụng để duy trì dữ liệu hoặc chia sẻ dữ liệu giữa các container và giữ cho dữ liệu tồn tại sau khi container đã bị xóa hoặc kết thúc.
https://docs.docker.com/storage/storagedriver/device-mapper-driver/



----
# phân tích 2 bridge networks một bridge default và 1 bridge do người dùng tạo:
- Bridge do user define thì phân giải DNS tự động giữa các container (do đó 2 container khác bridge có thể connect với nhau qua ip), còn bridge mặc định thì không.

