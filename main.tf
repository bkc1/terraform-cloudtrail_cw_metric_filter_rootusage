# Specify the provider and access details
provider "aws" {
  region = var.aws_region
}

data "aws_sns_topic" "ops_email" {
  name = var.sns_email
}

resource "aws_cloudwatch_metric_alarm" "cloudtrail" {
  alarm_name                = "cloudtrail-RootAccountUsage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "RootAccountUsageCount"
  namespace                 = "CloudTrailMetrics"
  period                    = "300"
  statistic                 = "Sum"
  threshold                 = "1"
  treat_missing_data        = "notBreaching"
  alarm_description         = "Terraform-managed: This metric monitors root usage via cloudtrail logs"
  alarm_actions             = [data.aws_sns_topic.ops_email.arn]
  insufficient_data_actions = []
  ok_actions                = [data.aws_sns_topic.ops_email.arn]
}

resource "aws_cloudwatch_log_metric_filter" "cloudtrail" {
  name           = " RootAccountUsage"
  pattern        = "{ ($.userIdentity.type = Root) && ($.userIdentity.invokedBy NOT EXISTS) && ($.eventType != AwsServiceEvent) }"
  log_group_name = var.ct_loggroup_name
  metric_transformation {
    name      = "RootAccountUsageCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
  }
}

