module "cwe" {
  source      = "git::https://github.com/cloudmitigator/reflex-engine.git//modules/cwe?ref=v1.0.0"
  name        = "DynamodbPointInTimeRecoveryDisabled"
  description = "A Reflex Rule for ensuring enablement of Point in Time Recovery for DynamoDB tables."

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

}
