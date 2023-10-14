-------------------------------------------Agenda-----------------------------
- Tất cả mọi yêu cầu đến Kubernetes đều thông qua apiserver
- Chúng ta thực hiện lệnh gọi đến apiserver thông qua file yaml
- yaml bản chất là một kiểu thể hiện khác của JSON
- Apiserver chỉ hiểu input đầu vào dưới dạng JSON
- Khi thực hiện 'kubectl apply -f deployment.yaml' bản chất là chúng ta chuyển file yml thành file JSON. Dựa trên những thông tin trong file JSON thì Kubernetes sẽ gọi api tới apiserver để đưa cho apiserver những thông tin trong file JSON

- apiserver tạo ra những object(namespace, pod .v.v.) để thực hiện nhiệm vụ là thêm, xóa, sửa dữ liệu của object đó
- khi ta thực hiện câu lệnh 'kubetcl get ns --show-labels' bản chất là ta thực hiện một lệnh gọi api đến apiserver bằng JSON và kubernetes cũng trả về JSON. sau đó kubetcl sẽ đọc JSON trả về và hiển thị thành format hiển thị trên terminal


# Namespace:
- nhóm những resource, object để dễ quản lý
- default namespace: (có 3 cái và không xóa được) khi chúng ta tạo Pod, Service, Deployment.v.v. mà không chỉ định tên thì chúng sẽ được đặt trong default namespace
    + default: namespace mặc định cho hầu hết các tài nguyên
    + kube-public: chứa tài nguyên quản lý hệ thống của k8s, ví dụ Pods của các Controllers, DNS
    + kube-system: chứa pods chạy thành phần của control plane (master node) apiserver, kube-proxy, kube-scheduler, controller manager
- Dùng để phân môi trường

# Pods:
- Đơn vị nhỏ nhất của k8. có thể chứ 1 hoặc nhiều container. 
- Tất cả những container trong pod đêu chia sẻ chung network, một port, một ip, một volume, resource (ram, cpu)
- Các container trong pod có thể gọi với nhau thông qua local host vì cùng dùng chung network
- Hai container không thể nghe cùng một cổng.
- Các ứng dụng bên trong có thể lắng nghe cổng trên cùng một địa chỉ IP

# Labels:
- Dùng để dán nhãn resource trong k8s
- Được đánh theo cặp key-value
- Mục đích để dễ truy vấn và quản lý resource

# Selectors
- Dùng labels để truy vấn hoặc chọn object

# Services
- Cung cấp giải pháp về domain name cho những bên khác gọi vào để tương tác với pods
- Có 1 private IP ảo có thể gọi từ cluster
- Có DNS có thể phân giải service IP
- Bao gồm static cluster unique IP, static DNS name
- use case: 
    + ví dụ chúng ta có một ứng dụng có 10 pods, thì người dùng muốn gọi đến ứng dụng thì service sẽ cung cấp một endpoint duy nhất để người dùng gọi đến
    + mỗi lần pod chết đi và sinh ra sẽ có 1 IP mới hoàn toàn thì service vẫn gọi được đến pod đó (query thông qua label)
- có 4 loại service:
    + Cluster IP (default): dùng để các resource trong nội bộ k8s gọi đến (chỉ dùng trong nội bộ k8s)
    + Nodeport: mở port để bên ngoài có thể truy cập được vào service. cùng network mới gọi được
    + LoadBalancer: tương tự Node port, ngoài internet có thể gọi được
    + ExternalName: map từ một DNS đến 1 DNS
- cách gọi đế service <service name>.<namespace>.svc.cluster.local
 
## ClusterIp service
- Dịch vụ mạng bên trong cụm Kubernetes và chỉ có thể tiếp cận bên trong cụm K8S
- Cung cấp một địa chỉ IP clusterIP cố định cho phép các Pod bên trong cluster kết nối đến các dịch vụ thông qua ClusterIP
- Dùng để liên kết các Pod bên trong cluster với các dịch vụ và ứng dụng khác bên trong cluster. 
- Không được dùng để tiếp cận từ bên ngoài cluster

## Node port service
- Mở port để bên ngoài có thể truy cập được vào service thông qua cổng và địa chỉ IP của các worker node
- Tìm pods dựa vào selector (select theo label, select theo điều kiện and)
- Mở port từ 30000 -> 32767, port phải khác nhau
- Mở port trên tất cả các node (port giống nhau) (nodePort)
- User nằm cùng mạng với Nodeport mới có thể gọi được

- Cho phép các ứng dụng bên ngoài cluster K8s tiếp cận với các node trong cluster thông qua một cổng IP cố định
- Khi bạn tạo NodePort service, K8s sẽ mở một cổng trên mỗi node và ánh sạ cổng này đến cổng mục tiêu của dịch vụ bên trong cluster 
- NodePort service thường được dùng khi bạn muốn tiếp cận ứng dụng từ bên ngoài cluster.

- Port: cổng của service
- targetPort: cổng mà ứng dụng trong Pod đang chạy
- nodePort: cổng trên node

- Cách hoạt động:
    + NodePort Allocation: 
        + Khi bạn tạo một NodePort Service trong Kubernetes
        + NodePort Service tạo một cổng (port) trên tất cả các Worker Nodes trong cụm.
        + Cổng này được chọn ngẫu nhiên từ 30000 đến 32767.

    + Forwarding Request: 
        + Khi một yêu cầu được gửi đến dịch vụ NodePort
        + NodePort gửi yêu cầu đến bất kì một Worker Node nào
        + Worker Node đó sẽ nhận yêu cầu và tiếp tục chuyển tiếp nó đến một Pod thông qua selector

    + Pod Selection: 
        + NodePort Service làm việc bằng cách sử dụng kube-proxy để chuyển tiếp yêu cầu đến Pod thích hợp. 
        + Kube-proxy chọn Pod dựa trên selector thông qua label

    + Cổng Pod: sau khi được chọn, yêu cầu được chuyển tiếp đến cổng của Pod

    + Thành Phần Network: Các thành phần mạng của Kubernetes (bao gồm iptables và kube-proxy) đảm bảo rằng yêu cầu từ bên ngoài cụm hoặc bên trong cụm có thể được chuyển tiếp đến Pod mục tiêu.

## Load Balancer service
- Là dịch vụ mở rộng của Nodeport service
- Khác NodePort là có public IP (để internet có thể gọi vào)

## External name
- Truy cập một dịch vụ bên ngoài K8S từ bên trong cụm K8S mà không thông qua cân bằng tải hoặc tường lửa

# Pod Template
- Là một template yaml của pod

# Resource model
- Cung cấp tài nguyên cho pods
- Request: yêu cầu lượng tài nguyên tối thiểu sử dụng cho resource
- Limited: lượng tài nguyên tối đa được dùng cho resource, vượt mức sẽ restart pod

# init container
- Trong pod có nhiều container

- Init container là một loại container đặc biệt trong một Pod trong cụm Kubernetes. 
- Chúng được thực thi trước khi các container chính trong Pod được khởi chạy.
- Mục đích chính của init container là chuẩn bị môi trường cho các container chính bên trong Pod
VD: chẳng hạn như tạo ra hoặc cấu hình dữ liệu, chạy các tác vụ chuẩn bị, tạo kết nối đến dịch vụ hoặc kiểm tra tính sẵn sàng trước khi ứng dụng bên trong container chính bắt đầu hoạt động.

- Init container không khởi động đồng thời với các container chính trong Pod và chỉ sau khi tất cả init container hoàn thành thành công, các container chính mới được khởi động.

- Init container là một tính năng quan trọng trong Kubernetes, giúp bạn quản lý các quá trình chuẩn bị và tiền xử lý trước khi ứng dụng bắt đầu hoạt động, giúp đảm bảo tính đúng đắn và sẵn sàng của ứng dụng.

# Job
- Tạo port thực hiện một nhiệm vụ nào đó
- Nếu thực hiện xong nhiệm vụ state sex được chuyển sang Terminated

# Cronjob
- Lên lịch cho các job
- Dùng mốc giờ UTC

# DaemonSet
- Đảm bảo tất cả các container có port được khai báo trong file yaml
- Có bao nhiêu node có có bấy nhiêu port
- Là một cách để chạy một bản sao của pod trên tất cả hoặc một số node
- Dựa trên số lượng node đang hoạt động để tạo pod
- Dùng để monitoring và log

# ReplicaSet
- Cách hoạt động:
    + Sử dụng selector để select các pods thông qua các label
    + Kube-controller manager sẽ định kì gọi đến replica set và kiểm tra số lượng
    + Kube-controller manager gọi đến kube-apiserver bảo thằng kube-scheduler tạo thêm node

- Đảm bảo số lượng mong muốn của pods đang hoạt động. 
- Các pod giống nhau và không được định danh.
- Tự động tạo mới pod nếu có pod chết.
- Có một list để selector định kì xem có bao nhiêu pod đang chạy và tạo mới pod nếu có pod có số lượng không như mong đợi.
- Quy định luôn số lượng pod

- Nếu một pod được tạo trước đó với label giống với replicaSet thì replicaSet sẽ không tạo lại pod mà sử dụng pod đã tạo sắn nên sẽ có trường hợp template của các pod có thể khác nhau.

# StatefulSet
- Giống replica set (đảm bảo số lượng mong muốn của pods đang hoạt động)
- replica set: các pod sẽ giống nhau
- statefule set: các con pod sẽ được định dang bằng index
    + pod sẽ có network, volume riêng
    + nếu pod 1 down thì 1 con pod mới sẽ được tạo và giữ nguyên volume, network, storage. bảo toàn những thứ mà pod 1 đang dùng

# Deployment
- Vừa thực hiện công việc của replica set vừa lưu trữ được những lần thay đổi của pod template
- deployment = replica set cộng thêm một số tính năng để quản lý chiến lược triển khai pod
- Cập nhật và quản lý thông qua pod-template-hash label
    + bất cứ khi nào thay đổi nội dung (vd: pod template) tức là đưa một input khác thì pod-template-hash sẽ đưa ra một hash khác
    + đưa một input giống thì pod-template-hash đưa ra hash giống với hash trước đó
- action:
    + khi tạo một deployment thì sẽ tạo 1 replica set, replica set sẽ tạo pod 
    + (pod có thể tự tạo hoặc tạo thông qua pod template trong replica set)
    + mỗi lần ta update pod template thì sẽ tạo ra một bản revisions khác, một bản replica set khác có id khác
    + nếu pod mới hoạt động không như mong muốn thì nó sẽ tự rollback để chạy bản trước đó
    + revisionHistoryLimit: số lượng tương tác trước của deployment mà có thể hoàn tác lại
- strategy: chiến lược
    + Recreate: xóa hết tất cả các pod mà không có hiệu lực nữa sau đó mới tạo các pod mới
    + RollingUpdate: thay thế tỪng phiên bản của ứng dụng bằng phiên bản mới một cách liền mạch
        + maxSurge: Tham số maxSurge là một phần của cấu hình của Kubernetes Deployment. Nó xác định số lượng Pod mới (phiên bản mới) được phép thêm vào trong quá trình cập nhật so với số lượng Pod gốc. Nó cho phép bạn quyết định mức độ tăng cường (surge) Pod mới trong quá trình cập nhật. 
        Ví dụ, nếu bạn đặt maxSurge là 1, có nghĩa rằng trong mỗi bước của quá trình cập nhật, Kubernetes sẽ thêm một Pod mới trước khi loại bỏ Pod cũ.

        + maxUnavailable: Tham số maxUnavailable cũng là một phần của cấu hình Deployment. Nó xác định số lượng Pod cũ (phiên bản cũ) được phép không sẵn sàng trong quá trình cập nhật. Nó cho phép bạn quyết định mức độ không sẵn sàng (unavailable) của Pod cũ trong quá trình cập nhật. 
        Ví dụ, nếu bạn đặt maxUnavailable là 1, có nghĩa rằng trong mỗi bước của quá trình cập nhật, Kubernetes sẽ cho phép một Pod cũ không sẵn sàng trước khi loại bỏ nó.

# Ingress
- Quản lý cách tiếp cận và điều hướng lưu lượng truy cập từ bên ngoài vào dịch vụ bên trong K8s cluster dựa trên các yêu cầu HTTP/HTTPS
- Thường được dùng để xác định cách truy cập các ứng dụng web hoặc API.
- Giống ALB

# Headless Service
- Cho phép các pod có địa chỉ IP riêng biệt trong cluster
- Thay vì cung cấp IP ảo, Headless Service tạo bản ghi DNS cho tên dịch vụ và trỏ trực tiếp đến địa chỉ IP của các Pod.
- Sử dụng khi muốn truy cập trực tiếp đến pod mà không thông qua cân bằng tải
- Phù hợp cho các trường hợp đặc biệt khi địa chỉ IP của các pod là quan trọng

# kind
- khai báo loại object

--------------------------
câu hỏi:
1.IP của Headless Service khác với IP riêng của pod như thế nào ?
- khi cả hai đều cung cấp địa chỉ IP riêng cho pod
=> Trả lời:
- IP của pod không độc lập để thằng khác gọi vô. 
- Muốn gọi đến pod thì phải gọi qua IP của service

- IP của Headless Service thì sẽ gọi thằng đến IP của pod 

2. sử dụng kind để tạo pod, khi get pod thì mục nodes của pod là none vậy lúc này pod sẽ được đặt ở đâu ?
- Kiểm tra resource trên node

