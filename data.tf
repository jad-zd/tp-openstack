# Import the available flavors and images from the OpenStack cloud
data "openstack_compute_flavor_v2" "small" {
	name = "m1.small"
}

data "openstack_compute_flavor_v2" "tiny" {
	name = "m1.tiny"
}

data "openstack_images_image_v2" "debian" {
  name       = "debian"
  visibility = "public"
}

data "openstack_images_image_v2" "cirros" {
  name       = "cirros"
  visibility = "public"
}

# Import the available router from the OpenStack cloud
data "openstack_networking_router_v2" "routerstonks" {
	name = "routerstonks"
}

# Import the net6stonks network from the OpenStack cloud
data "openstack_networking_network_v2" "net6stonks" {
  name = "net6stonks"
}

data "openstack_networking_subnet_v2" "subnet6stonks" {
  name = "subnet6stonks"
}

# Import the initial network from the OpenStack cloud
data "openstack_networking_network_v2" "netstonks" {
  name = "netstonks"
}

data "openstack_networking_subnet_v2" "subnetstonks" {
  name = "subnetstonks"
}

# Import the initial cirros VM from the OpenStack cloud
data "openstack_compute_instance_v2" "vmstonks" {
  id = "b0dd8dc1-2900-4fa2-9f88-10f0aa7f8273"
}