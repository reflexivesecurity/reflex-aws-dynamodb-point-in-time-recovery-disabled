module "cwe" {
  source      = "git::https://github.com/reflexivesecurity/reflex-engine.git//modules/cwe?ref=v2.1.3"
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
