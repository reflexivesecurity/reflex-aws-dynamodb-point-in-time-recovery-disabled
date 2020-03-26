# reflex-aws-dynamodb-point-in-time-recovery-disabled
A Reflex Rule for ensuring enablement of Point in Time Recovery for DynamoDB tables.

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
rules:
  - reflex-aws-dynamodb-point-in-time-recovery-disabled:
      version: latest
```

or add it directly to your Terraform:  
```
...

module "reflex-aws-dynamodb-point-in-time-recovery-disabled" {
  source           = "github.com/cloudmitigator/reflex-aws-dynamodb-point-in-time-recovery-disabled"
}

...
```

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/cloudmitigator/reflex-aws-dynamodb-point-in-time-recovery-disabled/blob/master/LICENSE) 
