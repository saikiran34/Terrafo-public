# resource "aws_sqs_queue" "sqs_queue" {
#   name                              = var.sqs_name
#   visibility_timeout_seconds        = var.visibility_timeout_seconds
#   max_message_size                  = var.max_message_size
#   receive_wait_time_seconds         = var.receive_wait_time_seconds
#   # message_retention_seconds         = var.message_retention_seconds
#    # delay_seconds                     = var.delay_seconds
# }

# resource "aws_sqs_queue_policy" "my_sqs_policy" {
#   queue_url = aws_sqs_queue.sqs_queue.id
#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Id": "sqspolicy",
#   "Statement": [
#     {
#       "Sid": "First",
#       "Effect": "Allow",
#       "Principal": "*",
#       "Action": "SQS:*",
#       "Resource": "*"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_vpc_endpoint" "sqs"{
#   service_name        =  "com.amazonaws.ca-central-1.sqs"
#   private_dns_enabled = true
#   security_group_ids  = [aws_security_group.SQS.id]
#   subnet_ids          = [aws_subnet.privatesubnet1.id]
#   vpc_endpoint_type   = "Interface"
#   vpc_id              = aws_vpc.Main.id
#   tags = { 
#     "Name" = "sqs-vpc-endpoint"
#   }
# }

# #  resource "aws_vpc_endpoint_route_table_association" "SQS_RT" {
# #    route_table_id = aws_route_table.Fxlink_Private1_RT.id
# #    vpc_endpoint_id = aws_vpc_endpoint.sqs.id
# #  }
