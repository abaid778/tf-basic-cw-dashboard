resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = var.dashboard_name

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "metric",
            "x": 0,
            "y": 1,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/ApplicationELB", "RequestCount", "LoadBalancer", "app/${var.alb_name}/6c594bae2c5dbb84", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "title": "LB Request Count - per minute",
                "period": 60,
                "stat": "Sum"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 1,
            "width": 9,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/ApplicationELB", "HTTPCode_Target_4XX_Count", "LoadBalancer", "app/${var.alb_name}/6c594bae2c5dbb84", { "region": "${var.region}" } ],
                    [ ".", "HTTPCode_Target_3XX_Count", ".", ".", { "region": "${var.region}" } ],
                    [ ".", "HTTPCode_ELB_4XX_Count", ".", ".", { "region": "${var.region}" } ],
                    [ ".", "HTTP_Redirect_Count", ".", ".", { "region": "${var.region}" } ],
                    [ ".", "HTTPCode_ELB_3XX_Count", ".", ".", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "title": "LB HTTP Responses - per minute",
                "period": 60,
                "stat": "Sum"
            }
        },
        {
            "type": "metric",
            "x": 15,
            "y": 1,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/ApplicationELB", "TargetResponseTime", "TargetGroup", "targetgroup/${var.target_group_name}/dc2ae16a9070b33d", "LoadBalancer", "app/${var.alb_name}/6c594bae2c5dbb84", { "region": "${var.region}", "stat": "Maximum" } ],
                    [ "...", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "period": 60,
                "stat": "Average"
            }
        },
        {
            "type": "text",
            "x": 0,
            "y": 14,
            "width": 21,
            "height": 1,
            "properties": {
                "markdown": "\n# RDS\n"
            }
        },
        {
            "type": "metric",
            "x": 21,
            "y": 1,
            "width": 3,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/ApplicationELB", "UnHealthyHostCount", "TargetGroup", "targetgroup/${var.target_group_name}/dc2ae16a9070b33d", "LoadBalancer", "app/${var.alb_name}/6c594bae2c5dbb84", { "region": "${var.region}" } ],
                    [ ".", "HealthyHostCount", ".", ".", ".", ".", { "region": "${var.region}" } ]
                ],
                "view": "singleValue",
                "stacked": true,
                "region": "us-east-1",
                "stat": "Sum",
                "period": 60,
                "title": "Health and Unhealthy host count"
            }
        },
        {
            "type": "text",
            "x": 0,
            "y": 0,
            "width": 24,
            "height": 1,
            "properties": {
                "markdown": "\n# LOAD BALANCER\n"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 8,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "ECS/ContainerInsights", "CpuUtilized", "ServiceName", "${var.ecs_service_name}", "ClusterName", "${var.ecs_cluster_name}", { "region": "${var.region}", "stat": "Average" } ],
                    [ "...", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "stat": "Maximum",
                "period": 300
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 8,
            "width": 9,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "ECS/ContainerInsights", "MemoryReserved", "ServiceName", "${var.ecs_service_name}", "ClusterName", "${var.ecs_cluster_name}", { "region": "${var.region}", "stat": "Average", "visible": false } ],
                    [ ".", "MemoryUtilized", ".", ".", ".", ".", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "period": 60,
                "stat": "Maximum"
            }
        },
        {
            "type": "metric",
            "x": 21,
            "y": 8,
            "width": 3,
            "height": 12,
            "properties": {
                "metrics": [
                    [ "ECS/ContainerInsights", "PendingTaskCount", "ServiceName", "${var.ecs_service_name}", "ClusterName", "${var.ecs_cluster_name}", { "region": "${var.region}" } ],
                    [ ".", "DeploymentCount", ".", ".", ".", ".", { "region": "${var.region}" } ],
                    [ ".", "RunningTaskCount", ".", ".", ".", ".", { "region": "${var.region}" } ],
                    [ ".", "DesiredTaskCount", ".", ".", ".", ".", { "region": "${var.region}" } ]
                ],
                "view": "singleValue",
                "stacked": false,
                "region": "us-east-1",
                "stat": "Sum",
                "period": 60,
                "title": "Task counts"
            }
        },
        {
            "type": "text",
            "x": 0,
            "y": 7,
            "width": 24,
            "height": 1,
            "properties": {
                "markdown": "\n# ECS\n"
            }
        },
        {
            "type": "metric",
            "x": 9,
            "y": 21,
            "width": 3,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.rds_instance_name}", { "region": "${var.region}" } ]
                ],
                "view": "singleValue",
                "stacked": false,
                "region": "us-east-1",
                "stat": "Sum",
                "period": 60,
                "title": "DB Connections"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 15,
            "width": 9,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/RDS", "ReadLatency", "DBInstanceIdentifier", "${var.rds_instance_name}", { "region": "${var.region}" } ],
                    [ ".", "WriteLatency", ".", ".", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "title": "Latencies",
                "period": 300,
                "stat": "Average"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 21,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/RDS", "NetworkReceiveThroughput", "DBInstanceIdentifier", "${var.rds_instance_name}", { "region": "${var.region}" } ],
                    [ ".", "NetworkTransmitThroughput", ".", ".", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "stat": "Average",
                "period": 300,
                "title": "Network Throughput"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 15,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${var.rds_instance_name}", { "region": "${var.region}", "stat": "Maximum" } ],
                    [ "...", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "stat": "Average",
                "period": 300
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 21,
            "width": 9,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.rds_instance_name}", { "region": "${var.region}" } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "us-east-1",
                "stat": "Sum",
                "period": 60,
                "title": "DB Connections"
            }
        }
    ]
}
 EOF
}