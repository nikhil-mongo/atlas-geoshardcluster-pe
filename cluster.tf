resource "mongodbatlas_cluster" "cluster-test" {
  project_id               = var.atlasprojectid
  name                     = "cluster-geo-sharded"
  cloud_backup             = true
  num_shards = 1
  disk_size_gb = 180
  cluster_type             = "GEOSHARDED"

  # Provider Settings "block"
  provider_name               = "AWS"
  provider_instance_size_name = "M30"

  replication_specs {
    zone_name  = "Zone 1"
    num_shards = 2
    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 2
      priority        = 7
      read_only_nodes = 0
    }
    regions_config {
      region_name     = "US_WEST_2"
      electable_nodes = 2
      priority        = 6
      read_only_nodes = 0
    }
    regions_config {
      region_name     = "US_WEST_1"
      electable_nodes = 1
      priority        = 5
      read_only_nodes = 0
    }
  }

  replication_specs {
    zone_name  = "Zone 2"
    num_shards = 2
    regions_config {
      region_name     = "US_WEST_2"
      electable_nodes = 2
      priority        = 7
      read_only_nodes = 0
    }
    regions_config {
      region_name     = "US_EAST_1"
      electable_nodes = 2
      priority        = 6
      read_only_nodes = 0
    }
    regions_config {
      region_name     = "US_WEST_1"
      electable_nodes = 1
      priority        = 5
      read_only_nodes = 0
    }
  }
}