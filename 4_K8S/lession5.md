-------------------------------------------Agenda-----------------------------
stateful: chết và chạy lại phụ thuộc vào thứ gì đó
stateless: thì ngược lại, chết và chạy lại thì không phụ thuộc vào thứ gì

# Volume
• Pod are ephemeral (dễ thay đổi) and stateless (pod chết và chạy lại không phụ thuộc vào bất cứ thứ gì)
• Volumes bring persistence to Pods
• Khối lượng Kubernetes tương tự khối lượng Docker nhưng được quản lý khác
• Tất cả container trong Pod đều có thể truy cập vào volume
• Các volume được liên kết với vòng đời của Pod
• Thư mục trong host được hiển thị dưới dạng volume
• Các volume có thể dựa trên nhiều loại phụ trợ lưu trữ khác nhau
• Một Pod có thể có một hoặc nhiều loại volumes kèm theo

=> lưu trữ dữ liệu và chia sẻ dữ liệu giữa các container trong một pod. Một volumes chỉ có thể gắn vào một pod độc quyền

# Type of volumes
- EmptyDir: 
    + EmptyDir là một thư mục trống được tạo trên node của cụm và được gắn vào Pod.
    + EmptyDir thường được sử dụng để lưu trữ dữ liệu tạm thời và sẽ bị xóa khi Pod bị xóa hoặc di chuyển.
    + EmptyDir bị xóa khi không có node nào đươc gán vào
    + Lưu trữ ở thư mục trong host, tất cả các pod có thể trao đổi với nhau thông qua EmptyDir.
    + Bị xóa khi node bị chết hết

- HostPath: 
    + HostPath cho phép truy cập vào một thư mục trên máy chủ node mà Pod đang chạy. Điều này có thể hữu ích để truy cập dữ liệu hoặc tài nguyên trên máy chủ node trực tiếp.
    + Tạo một thư mục ngoài host. container sẽ lưu path để tương tác với data ngoài host
    + Khi ghi data vào container data ngoài host cũng nhận được và ngược lại ghi data ngoài host thì trong container cũng nhận được
    + Khi pod chết và được tạo lại, dữ liệu trong HostPath không mất đi
    + Khi một pod được tạo trên một node khác, nó sẽ không thể truy cập dữ liệu trừ khi chia sẻ thư mục giữa các node
    + Dữ liệu bị mất khi node chứa dữ liệu bị hỏng hoặc được tạo lại

- PersistentVolume (PV): 
    + PV và PVC cho phép quản lý lưu trữ dữ liệu có thể tồn tại qua các vòng đời của Pod và không bị mất khi Pod bị xóa. 
    + Được sử dụng để quản lý lưu trữ dữ liệu một cách bền vững, phân vùng bộ nhớ cho volume của mình.
    + Độc lập với pod và không phụ thuộc vào vòng đời của pod. dữ liệu không mất đi khi pod bị xóa
    + Quản lý thông qua PersistentVolumeClaim

- PersistentVolumeClaim: được sử dụng để yêu cầu và đặt ổ đĩa dự phòng từ PersistentVolume.
- PersistentVolumeClaim: (PVC) là một yêu cầu để sử dụng PV. 3 cơ chế của PVC:
    + ReadWriteOnce: đọc/ghi 1 lần
    + ReadOnlyMany: đọc nhiều lần
    + ReadWriteMany: đọc ghi nhiều lần
- PersistentVolumeClaim - cách triển khai:
    + Static: admin phải đảm bảo phải có phân vùng bộ nhớ thật. admin tự tạo (VD: EBS volume)
    + Dynamic: tự cấu hình phân vùng thông qua storage class


- Mode volume:
    + Filesystem
    + Block


- Volume access modes: 
    + ReadWriteOnce -- ổ đĩa có thể được gắn dưới dạng đọc-ghi bởi một node duy nhất
    + ReadOnlyMany -- ổ đĩa có thể được gắn ở chế độ chỉ đọc bởi nhiều node
    + ReadWriteMany -- ổ đĩa có thể được gắn dưới dạng đọc-ghi bởi nhiều node
    + ReadWriteOncePod -- ổ đĩa có thể được gắn dưới dạng đọc-ghi bằng một Pod. Điều này chỉ được hỗ trợ cho khối lượng CSI và Kubernetes phiên bản 1.22+.

# Storage class
- Cung cấp cho admin một interface để define ra những class nào mà admin đã cấu hình tương tác tới.
- Định nghĩa cách lưu trữ nên được cung cấp và quản lý.
- Xác định các thuộc tính của lưu trữ như loại, cách sử dụng và cách triển khai
- Liên kết với PersistentVolumeClaims để giới hạn lưu trữ cho các ứng dụng

# ConfigMap
- ConfigMap và Secret: ConfigMap và Secret là các tài nguyên trong Kubernetes được sử dụng để lưu trữ cấu hình và thông tin bí mật, và chúng có thể được gắn vào Pod dưới dạng volumes để cung cấp cấu hình và thông tin bí mật cho các ứng dụng.

- NFS và iSCSI: Kubernetes cung cấp hỗ trợ cho việc sử dụng NFS (Network File System) và iSCSI (Internet Small Computer System Interface) để kết nối với các hệ thống lưu trữ từ xa hoặc qua mạng.

- GlusterFS và Ceph: GlusterFS và Ceph là hai hệ thống lưu trữ phân phối mở rộng và có thể được sử dụng làm volumes trong Kubernetes để cung cấp lưu trữ phân tán và đáng tin cậy.

- RBD (Rados Block Device): RBD là một dịch vụ lưu trữ dựa trên Ceph cho phép bạn sử dụng Ceph Block Device làm volumes trong Kubernetes.

- CSI (Container Storage Interface): CSI là một giao diện tiêu chuẩn cho việc tích hợp các nhà cung cấp lưu trữ bên ngoài với Kubernetes. CSI cho phép sử dụng nhiều loại lưu trữ từ nhiều nhà cung cấp khác nhau dưới dạng volumes trong Kubernetes.
