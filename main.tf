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
