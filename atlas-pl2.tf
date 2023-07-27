resource "mongodbatlas_privatelink_endpoint" "atlaspl2" {
  project_id    = var.atlasprojectid
  provider_name = "AWS"
  region        = var.zone2
}
resource "aws_vpc_endpoint" "ptfe_service2" {
  provider = aws.zone2
  vpc_id             = aws_vpc.mongodb.id
  service_name       = mongodbatlas_privatelink_endpoint.atlaspl2.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.mongodb-az1.id, aws_subnet.mongodb-az2.id]
  security_group_ids = [aws_security_group.mongodb_default.id]
}
resource "mongodbatlas_privatelink_endpoint_service" "atlaseplink2" {
  project_id          = mongodbatlas_privatelink_endpoint.atlaspl2.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.atlaspl2.private_link_id
  endpoint_service_id = aws_vpc_endpoint.ptfe_service2.id
  provider_name       = "AWS"
}
