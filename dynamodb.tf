resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  # attribute {
  #   name = "TopScore"
  #   type = "N"
  # }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }
  tags = {
    Name        = "dynamodb-table-1"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id      = aws_vpc.Main.id
  service_name = "com.amazonaws.ca-central-1.dynamodb"
  #todo- Security group
  tags = { 
    "Name" = "dynamodb-vpc-endpoint"
  }
}

resource "aws_vpc_endpoint_route_table_association" "DynodB_RT" {
    route_table_id = aws_route_table.Fxlink_Private1_RT.id
    vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}