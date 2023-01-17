# IPv6 default security group with ICMPv6 and SSH
resource "openstack_networking_secgroup_v2" "default_ipv6" {
  name        = "default_ipv6"
  description = "default security group for IPv6"  
}

resource "openstack_networking_secgroup_rule_v2" "rule_icmpv6" {
  description = "allow icmpv6"
  direction   = "ingress"
  ethertype   = "IPv6"
  protocol    = "ipv6-icmp"
  remote_ip_prefix = "::/0"
  security_group_id = "${openstack_networking_secgroup_v2.default_ipv6.id}"
}

resource "openstack_networking_secgroup_rule_v2" "rule_ssh" {
  description = "allow ssh"
  direction   = "ingress"
  ethertype   = "IPv6"
  protocol    = "tcp"
  port_range_min = "22"
  port_range_max = "22"
  remote_ip_prefix = "::/0"
  security_group_id = "${openstack_networking_secgroup_v2.default_ipv6.id}"
}

# Réseau en double pile IPv4 et IPv6
# On crée le réseau
resource "openstack_networking_network_v2" "network_double_pile" {
  name = "network_double_pile"
  admin_state_up = "true"
}

# On crée le sous-réseau IPv4
resource "openstack_networking_subnet_v2" "subnet_double_v4" {
  name = "subnet_double_v4"
  network_id = "${openstack_networking_network_v2.network_double_pile.id}"
  ip_version = "4"
  cidr = "10.2.0.0/24"
  gateway_ip = "10.2.0.1"
  enable_dhcp = "true"
  dns_nameservers = ["8.8.8.8"]
  allocation_pool {
    start = "10.2.0.2"
    end = "10.2.0.254"
  }
}

# On crée le sous-réseau IPv6 en SLAAC
resource "openstack_networking_subnet_v2" "subnet_double_v6_slaac" {
  name = "subnet_double_v6_slaac"
  network_id = "${openstack_networking_network_v2.network_double_pile.id}"
  cidr = "fe80:1::/64"
  ip_version = "6"
  ipv6_address_mode = "slaac"
  ipv6_ra_mode = "slaac"
}

# On attache le sous-réseau IPv4 au routeur en créant une interface
resource "openstack_networking_router_interface_v2" "router_interface_double_v4" {
  router_id = data.openstack_networking_router_v2.routerstonks.id
  subnet_id = "${openstack_networking_subnet_v2.subnet_double_v4.id}"
}

# On attache le sous-réseau IPv6 en SLAAC au routeur en créant une interface
resource "openstack_networking_router_interface_v2" "router_interface_double_v6_slaac" {
  router_id = data.openstack_networking_router_v2.routerstonks.id
  subnet_id = "${openstack_networking_subnet_v2.subnet_double_v6_slaac.id}"
}

# Réseau en IPv6 en DHCPv6 stateless
# On crée le réseau IPv6 en DHCPv6 stateless
resource "openstack_networking_network_v2" "network_dhcpv6stateless" {
	name = "network_dhcpv6stateless"
  admin_state_up = "true"
}

# On crée le sous-réseau IPv6 en DHCPv6 stateless
resource "openstack_networking_subnet_v2" "subnet_dhcpv6stateless" {
  name = "subnet_dhcpv6stateless"
  network_id = "${openstack_networking_network_v2.network_dhcpv6stateless.id}"
  cidr = "fe80:3::/64"
  ip_version = "6"
  ipv6_address_mode = "dhcpv6-stateless"
  ipv6_ra_mode = "dhcpv6-stateless"
}

# On attache le sous-réseau IPv6 en DHCPv6 stateless au routeur en créant une interface
resource "openstack_networking_router_interface_v2" "router_interface_dhcpv6stateless" {
  router_id = data.openstack_networking_router_v2.routerstonks.id
  subnet_id = "${openstack_networking_subnet_v2.subnet_dhcpv6stateless.id}"
}

# Réseau en IPv6 en DHCPv6 stateful
# On crée le réseau IPv6 en DHCPv6 stateful
resource "openstack_networking_network_v2" "network_dhcpv6stateful" {
	name = "network_dhcpv6stateful"
  admin_state_up = "true"
}

# On crée le sous-réseau IPv6 en DHCPv6 stateful
resource "openstack_networking_subnet_v2" "subnet_dhcpv6stateful" {
  name = "subnet_dhcpv6stateful"
  network_id = "${openstack_networking_network_v2.network_dhcpv6stateful.id}"
  cidr = "fe80:2::/64"
  ip_version = "6"
  ipv6_address_mode = "dhcpv6-stateful"
  ipv6_ra_mode = "dhcpv6-stateful"
}

# On attache le sous-réseau IPv6 en DHCPv6 stateful au routeur en créant une interface
resource "openstack_networking_router_interface_v2" "router_interface_dhcpv6stateful" {
  router_id = data.openstack_networking_router_v2.routerstonks.id
  subnet_id = "${openstack_networking_subnet_v2.subnet_dhcpv6stateful.id}"
}