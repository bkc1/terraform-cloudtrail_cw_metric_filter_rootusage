# Terraform CloudWatch Metric Filters for Root Usage

This is a terraform example that deploys a Cloudwatch metric filter and alarm that notifies on when root usage is detected via CLoudtrail API logs.

## Prereq's

For the scope of this example, a Cloudtrail with CW logging group and an SNS topic must already be in place. Update the variables accordingly.
