resource "aws_lambda_function" "start_ec2_lambda" {
  filename      = "D:/Devops project/AWS_lambda/modules/lambda/start.zip" 
    function_name = "start"
  role          = var.role-arn
  handler       = "start.lambda_handler"
  runtime       = "python3.8"
}

resource "aws_lambda_function" "stop_ec2_lambda" {
  filename      = "D:/Devops project/AWS_lambda/modules/lambda/stop.zip" 
  function_name = "stop"
  role          = var.role-arn
  handler       = "stop.lambda_handler"
  runtime       = "python3.8"
}

resource "aws_lambda_function" "increase-decrease-lambda" {
  filename      = "D:/Devops project/AWS_lambda/modules/lambda/increase-decrease.zip" 
  function_name = "increase-decrease"
  role          = var.role-arn
  handler       = "increase-decrease.lambda_handler"
  runtime       = "python3.8"
}

resource "aws_cloudwatch_event_rule" "start_ec2_rule" {
  name                = "start_ec2_rule"
  schedule_expression = "cron(0 8 * * ? *)"
}


resource "aws_cloudwatch_event_target" "start_ec2_target" {
  rule      = aws_cloudwatch_event_rule.start_ec2_rule.name
  arn       = aws_lambda_function.start_ec2_lambda.arn
  target_id = "start_ec2_target"

  input = jsonencode({
    instance_id = "${var.instance-id}"
  })
}



resource "aws_cloudwatch_event_rule" "stop_ec2_rule" {
  name                = "stop_ec2_rule"
  schedule_expression = "cron(0 19 * * ? *)"


}


resource "aws_cloudwatch_event_target" "stop_ec2_target" {
  rule      = aws_cloudwatch_event_rule.stop_ec2_rule.name
  arn       = aws_lambda_function.stop_ec2_lambda.arn
  target_id = "stop_ec2_target"

  input = jsonencode({
    instance_id = "${var.instance-id}"
  })
}


resource "aws_lambda_function" "increase-decrease-lambda" {
  filename      = "D:/Devops project/AWS_lambda/modules/lambda/increase-decrease.zip" 
  function_name = "increase-decrease"
  role          = var.role-arn
  handler       = "increase-decrease.lambda_handler"
  runtime       = "python3.8"
}


resource "aws_cloudwatch_event_rule" "increase-decrease-rule" {
  name                = "increase-decrease-rule"
  schedule_expression = "cron(0 3 * * ? *)"


}


resource "aws_cloudwatch_event_target" "increase-decrease-target" {
  rule      = aws_cloudwatch_event_rule.increase-decrease-rule.name
  arn       = aws_lambda_function.increase-decrease-lambda.arn
  target_id = "increase-decrease-target"

  input = jsonencode({
    instanceId = "${var.instance-id}"
    time = "12" 
  })
}
