resource "aws_iam_role" "plx-user-management-deployment-roles" {
  provider              = aws.main
  name                  = "${local.lpa_roles_prefix}-lpa-user-management-deployment-role"
  force_detach_policies = "false"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowSpecificPrincipals",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::${var.github_runner_account_id}:role/${var.github_runner_role}",
            "arn:aws:iam::${var.artifacts_account_id}:role/aws-saas-platform-workflow-role",
            "arn:aws:iam::${var.role_deployment_account_id}:root"
          ]
        },
        "Action" : "sts:AssumeRole"
      },
      {
        "Sid" : "AllowOrganizationalPrincipalsWithConditions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "ForAllValues:StringLike" : {
            "aws:ResourceOrgPaths" : "o-bdqfcqvqx3/r-9d1y/${var.lpa_organization_ou}/*"
          },
          "ArnEquals" : {
            "aws:PrincipalArn" : [
              "arn:aws:iam::*:role/${var.deploying_role}",
              "arn:aws:iam::*:role/${var.lpa_human_role}"
            ]
          }
        }
      }
    ]
  })
  inline_policy {
    name = "${local.lpa_roles_prefix}-lpa-user-management-deployment-policy"
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "EC2Permissions",
          "Effect" : "Allow",
          "Action" : [
            "ec2:DescribeVpcs",
            "ec2:DisassociateRouteTable",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:AssociateRouteTable"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "LambdaPermissions",
          "Effect" : "Allow",
          "Action" : [
            "lambda:CreateFunction",
            "lambda:DeleteFunction",
            "lambda:TagResource",
            "lambda:PublishVersion",
            "lambda:DeleteEventSourceMapping",
            "lambda:GetAlias",
            "lambda:GetFunctionCodeSigningConfig",
            "lambda:UpdateFunctionCode",
            "lambda:GetFunctionConfiguration",
            "lambda:PutFunctionCodeSigningConfig",
            "lambda:RemovePermission",
            "lambda:InvokeFunctionUrl",
            "lambda:GetPolicy",
            "lambda:AddPermission",
            "lambda:GetFunction",
            "lambda:GetFunctionConcurrency",
            "lambda:DeleteLayerVersion",
            "lambda:CreateEventSourceMapping",
            "lambda:PublishLayerVersion",
            "lambda:ListVersionsByFunction",
            "lambda:GetLayerVersion",
            "lambda:AddLayerVersionPermission",
            "lambda:InvokeFunction",
            "lambda:GetFunctionUrlConfig",
            "lambda:UpdateFunctionEventInvokeConfig",
            "lambda:UpdateFunctionUrlConfig",
            "lambda:UpdateFunctionConfiguration"
          ],
          "Resource" : [
            "arn:aws:lambda:*:*:function:cwsyn-um-*",
            "arn:aws:lambda:*:*:layer:cwsyn-um-*",
            "arn:aws:lambda:*:*:layer:Synthetics:31",
            "arn:aws:lambda:*:*:layer:user-*",
            "arn:aws:lambda:*:*:function:user-*"
          ]
        },
        {
          "Sid" : "S3Permissions",
          "Effect" : "Allow",
          "Action" : [
            "s3:PutLifecycleConfiguration",
            "s3:GetBucketWebsite",
            "s3:GetReplicationConfiguration",
            "s3:PutObject",
            "s3:GetLifecycleConfiguration",
            "s3:GetBucketTagging",
            "s3:ListBucket",
            "s3:PutBucketTagging",
            "s3:GetBucketCors",
            "s3:DeleteBucket",
            "s3:GetBucketVersioning",
            "s3:ListAllMyBuckets",
            "s3:GetObjectVersion",
            "s3:CreateBucket",
            "s3:GetObjectAcl",
            "s3:GetBucketObjectLockConfiguration",
            "s3:DeleteObjectTagging",
            "s3:GetObject",
            "s3:PutBucketLogging",
            "s3:GetBucketLogging",
            "s3:GetAccelerateConfiguration",
            "s3:GetBucketPolicy",
            "s3:PutEncryptionConfiguration",
            "s3:GetEncryptionConfiguration",
            "s3:GetBucketRequestPayment",
            "s3:GetObjectTagging",
            "s3:GetBucketPublicAccessBlock",
            "s3:PutBucketPublicAccessBlock",
            "s3:GetBucketAcl",
            "s3:GetBucketLocation"
          ],
          "Resource" : [
            "arn:aws:s3:::saas-platform-artifacts-*-*",
            "arn:aws:s3:::saas-um-*",
            "arn:aws:s3:::aws-synthetics-*/v1-0/library.zip"
          ]
        },
        {
          "Sid" : "IAMPermissions",
          "Effect" : "Allow",
          "Action" : [
            "iam:PutRolePolicy",
            "iam:ListRolePolicies",
            "iam:GetRole",
            "iam:GetPolicy",
            "iam:DeleteRole",
            "iam:TagPolicy",
            "iam:GetRolePolicy",
            "iam:TagRole",
            "iam:ListInstanceProfilesForRole",
            "iam:PassRole",
            "iam:DeleteRolePolicy",
            "iam:ListRoles",
            "iam:CreatePolicy",
            "iam:UpdateRole",
            "iam:GetPolicyVersion",
            "iam:CreateRole",
            "iam:AttachRolePolicy",
            "iam:DetachRolePolicy",
            "iam:ListAttachedRolePolicies",
            "iam:DeletePolicy",
            "iam:ListPolicyVersions"
          ],
          "Resource" : [
            "arn:aws:iam::*:role/user-*",
            "arn:aws:iam::*:role/aws-saas-platform-api-gateway-cloudwatch-role",
            "arn:aws:iam::*:policy/user-*"
          ]
        },
        {
          "Sid" : "SNSPermissions",
          "Effect" : "Allow",
          "Action" : [
            "sns:UnSubscribe",
            "sns:ListTopics",
            "sns:GetTopicAttributes",
            "sns:ListTagsForResource",
            "sns:GetSubscriptionAttributes",
            "sns:DeleteEndpoint",
            "sns:DeleteTopic",
            "sns:SetTopicAttributes",
            "sns:Subscribe",
            "sns:ListSubscriptionsByTopic",
            "sns:CreateTopic"
          ],
          "Resource" : [
            "arn:aws:sns:*:*:*"
          ]
        },
        {
          "Sid" : "DynamoDBPermissions",
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:DeleteTable",
            "dynamodb:CreateTable",
            "dynamodb:Query",
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:Scan",
            "dynamodb:TagResource",
            "dynamodb:UpdateContinuousBackups",
            "dynamodb:TagResource",
            "dynamodb:DescribeTimeToLive",
            "dynamodb:DescribeContinuousBackups",
            "dynamodb:ListTagsOfResource",
            "dynamodb:PutItem",
            "dynamodb:DeleteItem",
            "dynamodb:UpdateItem",
            "dynamodb:ConditionCheckItem"
          ],
          "Resource" : [
            "arn:aws:dynamodb:*:*:table/users-*"
          ]
        },
        {
          "Sid" : "CloudwatchPermissions",
          "Effect" : "Allow",
          "Action" : [
            "cloudwatch:DeleteAlarms",
            "cloudwatch:DescribeAlarms",
            "cloudwatch:ListTagsForResource",
            "cloudwatch:DeleteDashboards",
            "cloudwatch:PutDashboard",
            "cloudwatch:GetDashboard",
            "cloudwatch:PutMetricAlarm"
          ],
          "Resource" : [
            "arn:aws:cloudwatch:*:*:user-*",
            "arn:aws:cloudwatch::*:dashboard/user-*",
            "arn:aws:cloudwatch:*:*:alarm:um-*"
          ]
        },
        {
          "Sid" : "EventsPermissions",
          "Effect" : "Allow",
          "Action" : [
            "events:RemoveTargets",
            "events:DescribeRule",
            "events:ListTagsForResource",
            "events:PutRule",
            "events:DeleteRule",
            "events:ListTargetsByRule",
            "events:TagResource",
            "events:PutTargets"
          ],
          "Resource" : [
            "arn:aws:events:*:*:rule/um-*",
            "arn:aws:events:*:*:rule/user-*"
          ]
        },
        {
          "Sid" : "LogsPermissions",
          "Effect" : "Allow",
          "Action" : [
            "logs:TagResource",
            "logs:CreateLogGroup",
            "logs:DescribeLogGroups",
            "logs:DeleteLogGroup",
            "logs:ListTagsLogGroup"
          ],
          "Resource" : [
            "arn:aws:logs:*:*:log-group:*"
          ]
        },
        {
          "Sid" : "SyntheticsPermissions",
          "Effect" : "Allow",
          "Action" : [
            "synthetics:DeleteCanary",
            "synthetics:CreateCanary",
            "synthetics:GetCanaryRuns",
            "synthetics:StopCanary",
            "synthetics:UpdateCanary",
            "synthetics:TagResource",
            "synthetics:ListTagsForResource",
            "synthetics:GetCanary",
            "synthetics:UntagResource",
            "synthetics:StartCanary"
          ],
          "Resource" : [
            "arn:aws:synthetics:*:*:canary:um-*"
          ]
        },
        {
          "Sid" : "SSMPermissions",
          "Effect" : "Allow",
          "Action" : [
            "ssm:ListTagsForResource",
            "ssm:GetParameter",
            "ssm:DeleteParameter",
            "ssm:DescribeParameters",
            "ssm:AddTagsToResource",
            "ssm:GetParameters",
            "ssm:PutParameter"
          ],
          "Resource" : [
            "arn:aws:ssm:*:*:*"
          ]
        },
        {
          "Sid" : "STSPermissions",
          "Effect" : "Allow",
          "Action" : [
            "sts:AssumeRole"
          ],
          "Resource" : [
            "arn:aws:sts::*:assumed-role/user-*",
            "arn:aws:sts::*:assumed-role/pltx-lpa-user-*"
          ]
        },
        {
          "Sid" : "ExecuteAPIPermissions",
          "Effect" : "Allow",
          "Action" : [
            "execute-api:Invoke"
          ],
          "Resource" : [
            "arn:aws:execute-api:*:*:*/*/*/user",
            "arn:aws:execute-api:*:*:*/*/*/health"
          ]
        },
        {
          "Sid" : "APIGatewayPermissions",
          "Effect" : "Allow",
          "Action" : [
            "apigateway:*"
          ],
          "Resource" : [
            "arn:aws:apigateway:*::/*"
          ]
        },
        {
          "Sid" : "AssumeRolePermissionsForWorkFlowManagement",
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Resource" : [
            "arn:aws:iam::${var.artifacts_account_id}:role/aws-saas-platform-workflow-role"
        ] }
      ]
    })
  }
}
