resource "mongodbatlas_privatelink_endpoint" "atlaspl" {
  project_id    = var.atlasprojectid
  provider_name = "AWS"
  region        = var.zone1
}

resource "aws_vpc_endpoint" "ptfe_service" {
  provider           = aws.zone1
  vpc_id             = aws_vpc.primary.id
  service_name       = mongodbatlas_privatelink_endpoint.atlaspl.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.primary-az1.id, aws_subnet.primary-az2.id]
  security_group_ids = [aws_security_group.primary_default.id]
}
resource "mongodbatlas_privatelink_endpoint_service" "atlaseplink" {
  project_id          = mongodbatlas_privatelink_endpoint.atlaspl.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.atlaspl.private_link_id
  endpoint_service_id = aws_vpc_endpoint.ptfe_service.id
  provider_name       = "AWS"
}
