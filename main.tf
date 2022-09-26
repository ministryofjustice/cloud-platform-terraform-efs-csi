data "aws_iam_policy_document" "efs_doc" {
  statement {
    actions = [
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets",
      "ec2:DescribeAvailabilityZones",
      "sts:AssumeRoleWithWebIdentity"
    ]
    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "elasticfilesystem:CreateAccessPoint"
    ]
    resources = [
      "*",
    ]
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values = ["true"]
    }
  }

  statement {
    actions = [
      "elasticfilesystem:DeleteAccessPoint"
    ]
    resources = [
      "*",
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
      values = ["true"]
    }
  }
}

resource "aws_iam_policy" "efs_policy" {
  name        = "efs-csi-policy-${var.eks_cluster}"
  path        = "/cloud-platform/"
  policy      = data.aws_iam_policy_document.efs_doc.json
  description = "Policy for EFS CSI driver"
}

module "efs_irsa" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.0.3"

  eks_cluster      = var.eks_cluster
  namespace        = "kube-system"
  service_account  = "efs-csi-controller-sa"
  role_policy_arns = [aws_iam_policy.efs_policy.arn]
}

resource "helm_release" "aws_efs" {
  name       = "aws-efs-csi-driver"
  chart      = "aws-efs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver"
  namespace  = "kube-system"
  version    = "2.2.8"

  set {
    name  = "controller.serviceAccount.create"
    value = "false"
  }

  depends_on = [module.efs_irsa]
}
