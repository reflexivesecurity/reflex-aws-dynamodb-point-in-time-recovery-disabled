""" Module for DynamoDBPointInTimeRecoveryDisabled """

import json
import os

import boto3
from reflex_core import AWSRule, subscription_confirmation


class DynamoDBPointInTimeRecoveryDisabled(AWSRule):
    """ A Reflex Rule for ensuring enablement of Point in Time Recovery for DynamoDB tables """

    client = boto3.client("dynamodb")

    def __init__(self, event):
        super().__init__(event)

    def extract_event_data(self, event):
        """ Extract required event data """
        self.table_name = event["detail"]["requestParameters"]["tableName"]

    def resource_compliant(self):
        """
        Determine if the resource is compliant with your rule.

        Return True if it is compliant, and False if it is not.
        """
        response = self.client.describe_continuous_backups(TableName=self.table_name)

        return (
            response["ContinuousBackupsDescription"]["PointInTimeRecoveryDescription"][
                "PointInTimeRecoveryStatus"
            ]
            == "ENABLED"
        )

    def remediate(self):
        """
        Fix the non-compliant resource so it conforms to the rule
        """
        self.client.update_continuous_backups(
            TableName=self.table_name,
            PointInTimeRecoverySpecification={"PointInTimeRecoveryEnabled": True},
        )

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        message = f"Point in Time Recovery was disabled for {self.table_name}. "
        if self.should_remediate():
            message += "It has been re-enabled."
        return message


def lambda_handler(event, _):
    """ Handles the incoming event """
    print(event)
    event_payload = json.loads(event["Records"][0]["body"])
    if subscription_confirmation.is_subscription_confirmation(event_payload):
        subscription_confirmation.confirm_subscription(event_payload)
        return
    rule = DynamoDBPointInTimeRecoveryDisabled(event_payload)
    rule.run_compliance_rule()
