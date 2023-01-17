# Configure the OpenStack provider
terraform {
	required_providers {
	  openstack = {
	    source = "terraform-provider-openstack/openstack"
	    version = "=1.49.0"
	  }
	}
}

provider "openstack" {
    # This block remains empty
    # as we are using environment variables
    # from OpenStack RC file
}
