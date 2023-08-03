# Terraform AWS EKS Cluster with Calyptia Core

This Terraform configuration creates an Amazon EKS cluster, VPC, and deploys [Calyptia Core](https://calyptia.com/products/calyptia-core/) into the cluster.
The configuration is separated into modules for better organization and flexibility.

## Modules

- `vpc`: Creates a VPC and private subnets for the EKS cluster.
- `eks`: Creates the EKS cluster, worker nodes, and required resources.
- `calyptia_core`: Deploys Calyptia Core into the EKS cluster.

## Prerequisites

- Install Terraform: Follow
  the [official installation guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) to
  install the Terraform CLI on your machine.
- Set up an AWS account: [Create an AWS account](https://repost.aws/knowledge-center/create-and-activate-aws-account) if
  you don't have one already.
- Configure AWS CLI: Install and configure the [AWS Command Line Interface](https://aws.amazon.com/cli/) to connect your
  machine to your AWS account. Follow
  the [official installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and
  the [configuration guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) to complete this
  step.

## Creating an IAM User and Policy in AWS

To create an IAM user and policy for the Terraform scripts, follow these steps:

1. Sign in to the AWS Management Console.
2. Navigate to the IAM console.
3. In the navigation pane, click on "Users" and then click the "Add user" button.
4. Provide a username (e.g., terraform-user) and then click "Next".
5. Select "Attach policies directly" option and click on "Create policy" to open the policy creation in a new browser tab.
6. In the new tab, click on the "JSON" tab and paste the following policy

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "aps:CreateAlertManagerDefinition",
        "aps:CreateWorkspace",
        "aps:DeleteAlertManagerDefinition",
        "aps:DeleteWorkspace",
        "aps:DescribeAlertManagerDefinition",
        "aps:DescribeWorkspace",
        "aps:ListTagsForResource",
        "autoscaling:CreateAutoScalingGroup",
        "autoscaling:CreateOrUpdateTags",
        "autoscaling:DeleteAutoScalingGroup",
        "autoscaling:DeleteLifecycleHook",
        "autoscaling:DeleteTags",
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeLifecycleHooks",
        "autoscaling:DescribeTags",
        "autoscaling:PutLifecycleHook",
        "autoscaling:SetInstanceProtection",
        "autoscaling:UpdateAutoScalingGroup",
        "ec2:AllocateAddress",
        "ec2:AssociateRouteTable",
        "ec2:AttachInternetGateway",
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateEgressOnlyInternetGateway",
        "ec2:CreateInternetGateway",
        "ec2:CreateLaunchTemplate",
        "ec2:CreateNatGateway",
        "ec2:CreateNetworkAclEntry",
        "ec2:CreateRoute",
        "ec2:CreateRouteTable",
        "ec2:CreateSecurityGroup",
        "ec2:CreateSubnet",
        "ec2:CreateTags",
        "ec2:CreateVpc",
        "ec2:DeleteEgressOnlyInternetGateway",
        "ec2:DeleteInternetGateway",
        "ec2:DeleteLaunchTemplate",
        "ec2:DeleteNatGateway",
        "ec2:DeleteNetworkAclEntry",
        "ec2:DeleteRoute",
        "ec2:DeleteRouteTable",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteSubnet",
        "ec2:DeleteTags",
        "ec2:DeleteVpc",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAddresses",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeEgressOnlyInternetGateways",
        "ec2:DescribeImages",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeLaunchTemplateVersions",
        "ec2:DescribeLaunchTemplates",
        "ec2:DescribeNatGateways",
        "ec2:DescribeNetworkAcls",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeRouteTables",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSecurityGroupRules",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVpcAttribute",
        "ec2:DescribeVpcClassicLink",
        "ec2:DescribeVpcClassicLinkDnsSupport",
        "ec2:DescribeVpcs",
        "ec2:DetachInternetGateway",
        "ec2:DisassociateRouteTable",
        "ec2:DisassociateAddress",
        "ec2:ModifySubnetAttribute",
        "ec2:ModifyVpcAttribute",
        "ec2:ReleaseAddress",
        "ec2:RevokeSecurityGroupEgress",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:RunInstances",
        "eks:CreateAddon",
        "eks:CreateCluster",
        "eks:CreateNodegroup",
        "eks:DeleteAddon",
        "eks:DeleteCluster",
        "eks:DeleteFargateProfile",
        "eks:DeleteNodegroup",
        "eks:DescribeAddon",
        "eks:DescribeAddonVersions",
        "eks:DescribeCluster",
        "eks:DescribeNodegroup",
        "eks:TagResource",
        "eks:UpdateClusterVersion",
        "eks:DescribeCluster",
        "eks:ListUpdates",
        "elasticfilesystem:CreateFileSystem",
        "elasticfilesystem:CreateMountTarget",
        "elasticfilesystem:DeleteFileSystem",
        "elasticfilesystem:DeleteMountTarget",
        "elasticfilesystem:DescribeFileSystems",
        "elasticfilesystem:DescribeLifecycleConfiguration",
        "elasticfilesystem:DescribeMountTargetSecurityGroups",
        "elasticfilesystem:DescribeMountTargets",
        "emr-containers:CreateVirtualCluster",
        "emr-containers:DeleteVirtualCluster",
        "emr-containers:DescribeVirtualCluster",
        "events:DeleteRule",
        "events:DescribeRule",
        "events:ListTagsForResource",
        "events:ListTargetsByRule",
        "events:PutRule",
        "events:PutTargets",
        "events:RemoveTargets",
        "iam:AddRoleToInstanceProfile",
        "iam:AttachRolePolicy",
        "iam:CreateInstanceProfile",
        "iam:CreateOpenIDConnectProvider",
        "iam:CreatePolicy",
        "iam:CreateRole",
        "iam:CreateServiceLinkedRole",
        "iam:DeleteInstanceProfile",
        "iam:DeleteOpenIDConnectProvider",
        "iam:DeletePolicy",
        "iam:DeleteRole",
        "iam:DeleteRolePolicy",
        "iam:DetachRolePolicy",
        "iam:GetInstanceProfile",
        "iam:GetOpenIDConnectProvider",
        "iam:GetPolicy",
        "iam:GetPolicyVersion",
        "iam:GetRole",
        "iam:ListAttachedRolePolicies",
        "iam:ListInstanceProfilesForRole",
        "iam:ListPolicyVersions",
        "iam:ListRolePolicies",
        "iam:PassRole",
        "iam:RemoveRoleFromInstanceProfile",
        "iam:TagOpenIDConnectProvider",
        "iam:TagInstanceProfile",
        "iam:TagPolicy",
        "iam:TagRole",
        "iam:PutRolePolicy",
        "iam:GetRolePolicy",
        "iam:UpdateAssumeRolePolicy",
        "kms:CreateAlias",
        "kms:CreateKey",
        "kms:DeleteAlias",
        "kms:DescribeKey",
        "kms:EnableKeyRotation",
        "kms:GetKeyPolicy",
        "kms:GetKeyRotationStatus",
        "kms:ListAliases",
        "kms:ListResourceTags",
        "kms:PutKeyPolicy",
        "kms:ScheduleKeyDeletion",
        "kms:TagResource",
        "logs:CreateLogGroup",
        "logs:DeleteLogGroup",
        "logs:DescribeLogGroups",
        "logs:ListTagsLogGroup",
        "logs:PutRetentionPolicy",
        "logs:TagResource",
        "secretsmanager:CreateSecret",
        "secretsmanager:DeleteSecret",
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:PutSecretValue",
        "sqs:CreateQueue",
        "sqs:DeleteQueue",
        "sqs:GetQueueAttributes",
        "sqs:ListQueueTags",
        "sqs:SetQueueAttributes",
        "sqs:TagQueue",
        "sts:GetCallerIdentity"
      ],
      "Resource": "*"
    }
  ]
}
```

7. Click on "Next: Tags" and add tags if you prefer.
8. Click on "Next: Review" give the policy a name (e.g., terraform-policy), then click "Create policy".
9. Return to the "Add user" tab and click on the "Refresh" button next to the "Create policy" button.
10. Search for your newly created policy (e.g., terraform-policy) and select it, then click "Next: Tags".
11. Optionally, add any tags you'd like to associate with this user, then click "Next: Review".
12. Review the user details and click "Create user" to finalize the process.
13. In the navigation pane, click on "Users" and then click the above created user.
14. Navigate to the "Security Credentials" tab.
15. Scroll down to "Access keys" section and click on the "Create access key" button.
16. Select "Third-party service" option and confirm "I understand the above recommendation and want to proceed to create
    an access key." warning.
17. On the next page click "Create access key".
18. You'll be presented with the "Access key ID" and "Secret access key". Copy these credentials and store them
    securely, as you won't be able to access the "Secret access key" again.

**Important**: Do not share your "Access key ID" and "Secret access key" with anyone or commit them to your repository.

## Passing AWS Authentication Information to Terraform

To pass the AWS authentication information to Terraform, you have several options:

1. **Using Environment Variables**: Export the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables in
   your terminal before running Terraform commands:

```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
```

2. **Using the AWS CLI Configuration**: If you've already configured the AWS CLI with `aws configure`, Terraform will
   automatically use the default profile's credentials. If you have multiple profiles, you can set the `AWS_PROFILE`
   environment variable to specify which profile to use:

```bash
export AWS_PROFILE="your_aws
```

## Usage

1. Clone the repository:

```bash
git clone https://github.com/calyptia/terraform-aws-eks-calyptia-core.git
cd terraform-aws-eks-calyptia-core
```

2. Create a terraform.tfvars file in the root folder and define the required variables:

```hcl
cluster_name            = "my-eks-cluster"
vpc_cidr                = "10.0.0.0/16"
machine_type            = "t3.medium"
k8s_version             = "1.24"
node_count              = 1
calyptia_core_namespace = "calyptia"
service_account_name    = "calyptia-core"
calyptia_core_version   = "1.1.2"
calyptia_core_token     = "your-calyptia-core-token"
instance_name           = "my-instance"
```

3. Initialize Terraform:

```bash
terraform init
```

4. Plan and apply the Terraform configuration:

```bash
terraform plan
terraform apply
```

5. Configure KubeConfig

```bash
aws eks update-kubeconfig --region region-code --name my-cluster
```

6. To destroy the resources created by this configuration, run:

```bash
terraform destroy
```

## Variables

| Name                    | Description                                       | Default       | Required |
|-------------------------|---------------------------------------------------|---------------|----------|
| cluster_name            | Name of the EKS cluster                           |               | Yes      |
| vpc_cidr                | CIDR block for the VPC                            | 10.0.0.0/16   | Yes      |
| machine_type            | EC2 instance type for worker nodes                | t3.medium     | Yes      |
| k8s_version             | Kubernetes version for the EKS cluster            | 1.24          | Yes      |
| node_count              | Number of worker nodes in the EKS cluster         | 1             | Yes      |
| calyptia_core_namespace | Kubernetes namespace for Calyptia Core            | calyptia      | Yes      |
| service_account_name    | Kubernetes service account name for Calyptia Core | calyptia-core | Yes      |
| calyptia_core_version   | Version of Calyptia Core to be deployed           | 1.1.2         | Yes      |
| calyptia_core_token     | Calyptia Core authentication token                |               | Yes      |
| instance_name           | Name for the Calyptia Core instance               |               | Yes      |
| region                  | AWS region                                        | us-east-1     | Yes      |
