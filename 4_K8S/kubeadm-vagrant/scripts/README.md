# Kubeadm + Vagrant k8s cluster boostrap

- Install Vagrant 

- Init vagrant and create VM with bootstrap script (5m ~ 7m)
```sh
vagrant init
vagrant up
```

- Jump into controlplane
```sh
vagrant ssh controlplane-1
sudo su root
alias k=kubectl
kubectl get nodes -o wide
```

- Destroy VMs
```sh
vagrant destroy -f
```