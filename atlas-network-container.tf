resource "mongodbatlas_network_container" "zone1" {
    project_id       = var.atlasprojectid
    atlas_cidr_block = "192.168.232.0/21"
    provider_name    = "AWS"
    region_name      = "US_EAST_1"
}
resource "mongodbatlas_network_container" "zone2" {
    project_id       = var.atlasprojectid
    atlas_cidr_block = "192.168.241.0/21"
    provider_name    = "AWS"
    region_name      = "US_EAST_2"
}
resource "mongodbatlas_network_container" "zone3" {
    project_id       = var.atlasprojectid
    atlas_cidr_block = "192.168.248.0/21"
    provider_name    = "AWS"
    region_name      = "US_WEST_2"
}
