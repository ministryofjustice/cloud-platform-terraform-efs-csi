# cloud-platform-terraform-efs-csi

EFS (NFS compatible) storage backend for Kubernetes

## Usage

See the [examples/](examples/) folder.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.24.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=4.24.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_efs_irsa"></a> [efs\_irsa](#module\_efs\_irsa) | github.com/ministryofjustice/cloud-platform-terraform-irsa | 1.0.3 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.efs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [helm_release.aws_efs](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_iam_policy_document.efs_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_cluster"></a> [eks\_cluster](#input\_eks\_cluster) | cluster name | `string` | n/a | yes |

## Outputs

No outputs.

<!--- END_TF_DOCS --->

## Tags

Some of the inputs are tags. All infrastructure resources need to be tagged according to the [MOJ techincal guidance](https://ministryofjustice.github.io/technical-guidance/standards/documenting-infrastructure-owners/#documenting-owners-of-infrastructure). The tags are stored as variables that you will need to fill out as part of your module.

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| application |  | string | - | yes |
| business-unit | Area of the MOJ responsible for the service | string | `mojdigital` | yes |
| environment-name |  | string | - | yes |
| infrastructure-support | The team responsible for managing the infrastructure. Should be of the form team-email | string | - | yes |
| is-production |  | string | `false` | yes |
| team_name |  | string | - | yes |

## Reading Material

Chart: https://kubernetes-sigs.github.io/aws-efs-csi-driver/index.yaml

Installation docs: https://github.com/kubernetes-sigs/aws-efs-csi-driver/tree/master/docs
