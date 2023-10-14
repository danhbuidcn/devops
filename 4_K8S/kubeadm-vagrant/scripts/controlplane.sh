#!/bin/bash
echo "|x| Initializing cluster controlplane..."
echo "--------"

# Get IP of controlplane via network interface
IP_ADDR=$(ip addr show enp0s8 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

kubeadm init --apiserver-cert-extra-sans=controlplane --apiserver-advertise-address $IP_ADDR --pod-network-cidr=10.244.0.0/16

# Copy kubeconfig to default location within controlplane nodes. Change to ROOR user to easily interact with cluster
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Apply Networking Addons for Container Engine to assign Pod IP
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml 

# Untaint controlplane node to allow workload deployment. By default, it blocks all pod scheduled on controlplane
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# Generate a scripts for worker nodes to join this cluster. By default, vagrant mount directory containing Vagrantfile into the VM
cat <<EOT > /vagrant/worker.sh
echo "|x| Joining worker node"
$(kubeadm token create --print-join-command)
EOT