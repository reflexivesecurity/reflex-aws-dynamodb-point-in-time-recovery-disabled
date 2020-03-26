module "reflex_aws_dynamodb_point_in_time_recovery_disabled" {
  source           = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe_lambda?ref=v0.5.4"
  rule_name        = "DynamoDBPointInTimeRecoveryDisabled"
  rule_description = "TODO: Provide rule description"

  event_pattern = <<PATTERN
# TODO: Provide event pattern
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
# TODO: Provide required lambda permissions policy
EOF



  queue_name    = "DynamoDBPointInTimeRecoveryDisabled"
  delay_seconds = 0

  target_id = "DynamoDBPointInTimeRecoveryDisabled"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}