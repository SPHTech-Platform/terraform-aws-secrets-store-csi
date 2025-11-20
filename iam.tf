module "secrets_manager_role" {
  count = var.iam_role_type == "irsa" ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"
  version = "~> 6.0"

  name        = coalesce(var.iam_role_name, "${var.cluster_name}-sm-csi")
  description = "EKS Cluster ${var.cluster_name} Secret Manager CSI Driver role"

  attach_external_secrets_policy                     = true
  external_secrets_ssm_parameter_arns                = var.external_secrets_ssm_parameter_arns
  external_secrets_secrets_manager_arns              = var.external_secrets_secrets_manager_arns
  external_secrets_kms_key_arns                      = var.external_secrets_kms_key_arns
  external_secrets_secrets_manager_create_permission = var.external_secrets_create_permission

  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["${var.namespace}:${local.service_account_name}"]
    }
  }
}

module "pod_identity" {
  count = var.iam_role_type == "pod_identity" ? 1 : 0

  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "~> 2.0"

  name        = coalesce(var.iam_role_name, "${var.cluster_name}-sm-csi")
  description = "EKS Cluster ${var.cluster_name} Secret Manager CSI Driver Pod Identity Role"

  attach_external_secrets_policy        = true
  external_secrets_ssm_parameter_arns   = var.external_secrets_ssm_parameter_arns
  external_secrets_secrets_manager_arns = var.external_secrets_secrets_manager_arns
  external_secrets_kms_key_arns         = var.external_secrets_kms_key_arns
  external_secrets_create_permission    = var.external_secrets_create_permission

  association_defaults = {
    namespace       = var.namespace
    service_account = local.service_account_name
  }
}

moved {
  from = module.secrets_manager_role[0].aws_iam_policy.external_secrets[0]
  to   = module.secrets_manager_role[0].aws_iam_policy.this[0]
}

moved {
  from = module.secrets_manager_role[0].aws_iam_role_policy_attachment.external_secrets[0]
  to   = module.secrets_manager_role[0].aws_iam_role_policy_attachment.this[0]
}
