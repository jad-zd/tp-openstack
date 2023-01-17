# Imprimer les IPs des instances crées
output "ipv_vm_double_pile" {
  description = "IPv4 and IPv6 of the VM in the dual stack SLAAC network"
  value = [resource.openstack_compute_instance_v2.vm_double_pile.network[0].fixed_ip_v4,
           resource.openstack_compute_instance_v2.vm_double_pile.network[0].fixed_ip_v6 ]
}

output "ip_vm_dhcpstateless" {
  description = "IPv6 of the VM in the DHCPv6 stateless network"
  value = resource.openstack_compute_instance_v2.vm_dhcpstateless.network[0].fixed_ip_v6
}

output "ip_vm_dhcpstateful" {
  description = "IPv6 of the VM in the DHCPv6 stateful network"
  value = resource.openstack_compute_instance_v2.vm_dhcpstateful.network[0].fixed_ip_v6
}