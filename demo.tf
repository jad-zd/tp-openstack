
# Réseau démo en double pile IPv4 et IPv6
# On crée le réseau
resource "openstack_networking_network_v2" "network_demo" {
  name = "network_demo"
  admin_state_up = "true"
}

# On crée le sous-réseau démo IPv4
resource "openstack_networking_subnet_v2" "subnet_demo_v4" {
  name = "subnet_demo_v4"
  network_id = "${openstack_networking_network_v2.network_double_pile.id}"
  ip_version = "4"
  cidr = "10.3.0.0/24"
  gateway_ip = "10.3.0.1"
  enable_dhcp = "true"
  dns_nameservers = ["8.8.8.8"]
  allocation_pool {
    start = "10.3.0.2"
    end = "10.3.0.254"
  }
}

# On crée le sous-réseau démo IPv6 en SLAAC
resource "openstack_networking_subnet_v2" "subnet_demo_v6" {
  name = "subnet_demo_v6"
  network_id = "${openstack_networking_network_v2.network_double_pile.id}"
  cidr = "fe80:4::/64"
  ip_version = "6"
  ipv6_address_mode = "slaac"
  ipv6_ra_mode = "slaac"
}

# On attache le sous-réseau IPv4 au routeur en créant une interface
resource "openstack_networking_router_interface_v2" "router_interface_demo_v4" {
  router_id = data.openstack_networking_router_v2.routerstonks.id
  subnet_id = "${openstack_networking_subnet_v2.subnet_demo_v4.id}"
}

# On attache le sous-réseau IPv6 en SLAAC au routeur en créant une interface
resource "openstack_networking_router_interface_v2" "router_interface_demo_v6" {
  router_id = data.openstack_networking_router_v2.routerstonks.id
  subnet_id = "${openstack_networking_subnet_v2.subnet_demo_v6.id}"
}

# On crée une instance cirros démo dans le réseau en double pile IPv4 et IPv6 SLAAC
resource "openstack_compute_instance_v2" "vm_demo" {
  name            = "vm_demo"
  image_id        = data.openstack_images_image_v2.cirros.id
  flavor_id       = data.openstack_compute_flavor_v2.tiny.id
  key_pair        = "${openstack_compute_keypair_v2.mykey.name}"
  security_groups = ["default", "default_ipv6"]
  network {
    name = "${openstack_networking_network_v2.network_demo.name}"
  }
}