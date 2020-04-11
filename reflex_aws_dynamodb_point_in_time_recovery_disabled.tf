module "reflex_aws_dynamodb_point_in_time_recovery_disabled" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.7"
  rule_name        = "DynamoDBPointInTimeRecoveryDisabled"
  rule_description = "A Reflex Rule for ensuring enablement of Point in Time Recovery for DynamoDB tables."

  event_pattern = <<PATTERN
{
  "source": [
    "aws.dynamodb"
  ],
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "detail": {
    "eventSource": [
      "dynamodb.amazonaws.com"
    ],
    "eventName": [
      "CreateTable",
      "UpdateContinuousBackups"
    ]
  }
}
PATTERN

  function_name   = "DynamoDBPointInTimeRecoveryDisabled"
  source_code_dir = "${path.module}/source"
  handler         = "reflex_aws_dynamodb_point_in_time_recovery_disabled.lambda_handler"
  lambda_runtime  = "python3.7"
  environment_variable_map = {
    SNS_TOPIC = var.sns_topic_arn,
    MODE      = var.mode
  }
  custom_lambda_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:DescribeContinuousBackups",
        "dynamodb:UpdateContinuousBackups"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF



  queue_name    = "DynamoDBPointInTimeRecoveryDisabled"
  delay_seconds = 0

  target_id = "DynamoDBPointInTimeRecoveryDisabled"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
