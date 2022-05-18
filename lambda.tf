resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
    {
      "Action": "sts:AssumeRole",
		  "Principal": {
			  "Service": "lambda.amazonaws.com"
		  },
		  "Effect": "Allow",
		  "Sid": ""
	  }
  ]
}
EOF
}
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "index.js"
  output_path = "payload.zip"
}
resource "aws_lambda_function" "fxlink_controllambda" {
  filename         = "payload.zip"
  function_name    = "test_lambda"
  role             = aws_iam_role.iam_for_lambda_tf.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  vpc_config {
    subnet_ids         = [aws_subnet.privatesubnet1.id, aws_subnet.privatesubnet2.id, aws_subnet.privatesubnet2.id]
    security_group_ids = [aws_security_group.VPC_Security_group.id]
  }
  runtime = "nodejs14.x"
  environment {
    variables = {
      "Environment" = "${terraform.workspace}"
    }
  }
}


# resource "aws_lambda_function" "fxlink_lambda" {

#   filename      = "${path.module}/payload.zip"
#   function_name = "lambda_function_name"
#   role          = aws_iam_role.iam_for_lambda.arn
#   handler       = "lambda"

#   vpc_config {
#     subnet_ids         = [aws_subnet.privatesubnet1.id, aws_subnet.privatesubnet2.id]
#     security_group_ids = [aws_security_group.VPC_Security_group.id]
#   }

#   source_code_hash = filebase64sha256("${path.module}/payload.zip")

#   runtime = "nodejs14.x"

#   environment {
#     variables = {
#         "Environment" = "${terraform.workspace}"
#     }
#   }
# }


# resource "aws_iam_policy" "policy_lambda" {

#  name         = "aws_iam_policy_for_terraform_aws_lambda_role"
#  path         = "/"
#  description  = "AWS IAM Policy for managing aws lambda role"
#  policy = <<EOF
# {
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": [
#        "ec2:CreateNetworkInterfaces",
#        "ec2:DescribeNetworkInterfaces",
#        "logs:CreateLogGroup",
#        "logs:CreateLogStream",
#        "logs:PutLogEvents"
#      ],
#      "Resource": "*",
#      "Effect": "Allow"
#    }
#  ]
# }
# EOF
# }

resource "aws_iam_role_policy_attachment" "attach_role" {
  role       =  aws_iam_role.iam_for_lambda_tf.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}


