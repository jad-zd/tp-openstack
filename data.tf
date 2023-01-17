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