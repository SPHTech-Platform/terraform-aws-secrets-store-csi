variable "cluster_name" {
  description = "Name of Kubernetes Cluster"
  type        = string
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "secrets-store-csi-driver"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  type        = string
  default     = "secrets-store-csi-driver"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  type        = string
  default     = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  type        = string
  default     = "1.2.2"
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  type        = string
  default     = "kube-system"
}

variable "chart_timeout" {
  description = "Timeout to wait for the Chart to be deployed."
  type        = number
  default     = 300
}

variable "max_history" {
  description = "Max History for Helm"
  type        = number
  default     = 20
}

########################
# Chart Values
########################

variable "image_repository" {
  description = "Image repository for the Driver"
  type        = string
  default     = "k8s.gcr.io/csi-secrets-store/driver"
}

variable "image_repository_crds" {
  description = "Image repository for the CRDs"
  type        = string
  default     = "k8s.gcr.io/csi-secrets-store/driver-crds"
}

variable "image_tag" {
  description = "Image tag for the Driver and CRDs"
  type        = string
  default     = "v1.2.2"
}

variable "resources_driver" {
  description = "Driver Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "200m"
      memory = "200Mi"
    }
    limits = {
      cpu    = "200m"
      memory = "200Mi"
    }
  }
}

variable "image_repository_registrar" {
  description = "Image repository for the Registrar"
  type        = string
  default     = "k8s.gcr.io/sig-storage/csi-node-driver-registrar"
}

variable "image_tag_registrar" {
  description = "Image tag"
  type        = string
  default     = "v2.5.0"
}

variable "resources_registrar" {
  description = "Registrar Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
}

variable "image_repository_liveness" {
  description = "Image repository for the Liveness Probe"
  type        = string
  default     = "k8s.gcr.io/sig-storage/livenessprobe"
}

variable "image_tag_liveness" {
  description = "Image tag fo the LivenessProbe"
  type        = string
  default     = "v2.6.0"
}

variable "resources_liveness" {
  description = "Liveness Probe Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "100m"
      memory = "100Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
}

variable "affinity" {
  description = "Affinity for Secrets Store CSI Driver pods. Prevents the CSI driver from being scheduled on virtual-kubelet nodes by default"
  type        = map(any)

  default = {
    nodeAffinity = {
      requiredDuringSchedulingIgnoredDuringExecution = {
        nodeSelectorTerms = [
          {
            matchExpressions = [
              {
                key      = "type"
                operator = "NotIn"
                values = [
                  "virtual-kubelet"
                ]
              }
            ]
          }
        ]
      }
    }
  }
}

variable "node_selector" {
  description = "Node selector for Secrets Store CSI Driver pods"
  type        = map(any)
  default     = {}
}

variable "tolerations" {
  description = "Tolerations for Secrets Store CSI Driver pods"
  type        = list(map(string))
  default     = []
}

variable "syncSecretEnabled" {
  description = "Sync with kubernetes secrets"
  type        = bool
  default     = false
}

variable "enableSecretRotation" {
  description = "Enable rotation for secrets"
  type        = bool
  default     = false
}

###########
## ASCP ###
###########

variable "ascp_manifest_url" {
  description = "ASCP YAML file in the GitHub repo deployment directory"
  type        = string
  default     = "https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml"
}

########################
# IAM Role
########################
variable "oidc_provider_arn" {
  description = "OIDC Provider ARN for IRSA"
  type        = string
}

variable "iam_role_name" {
  description = "Name of IAM role for controller"
  type        = string
  default     = ""
}

variable "iam_role_description" {
  description = "Description for IAM role for controller"
  type        = string
  default     = "Used by AWS Load Balancer Controller for EKS"
}

variable "iam_role_path" {
  description = "IAM Role path for controller"
  type        = string
  default     = ""
}

variable "iam_role_permission_boundary" {
  description = "Permission boundary ARN for IAM Role for controller"
  type        = string
  default     = ""
}

variable "iam_role_tags" {
  description = "Tags for IAM Role for controller"
  type        = map(string)
  default     = {}
}

variable "iam_role_policy" {
  description = "Override the IAM policy for the controller"
  type        = string
  default     = ""
}

##############
#### IRSC ####
##############
variable "service_account_name" {
  description = "Name of service account to create. Not generated"
  type        = string
  default     = "csi-secrets-store-provider-aws"
}

variable "external_secrets_ssm_parameter_arns" {
  description = "List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:ssm:*:*:parameter/*"]
}

variable "external_secrets_secrets_manager_arns" {
  description = "List of Secrets Manager ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = ["arn:aws:secretsmanager:*:*:secret:*"]
}

variable "create_default_irsa" {
  description = "Create default IRSA for service account"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Kubernetes namespace, where the service account want to create"
  type        = string
  default     = "default"
}
