variable "cluster_name" {
  description = "Name of Kubernetes Cluster"
  type        = string
}

variable "max_history" {
  description = "Max History for Helm"
  type        = number
  default     = 20
}

#########################################
# Secrets Store CSI Driver Chart Values
#########################################
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
  default     = "1.4.8"
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  type        = string
  default     = "secrets-store-csi-system"
}

variable "create_namespace" {
  description = "Create the namespace if it does not exist"
  type        = bool
  default     = true
}

variable "chart_timeout" {
  description = "Timeout to wait for the Chart to be deployed."
  type        = number
  default     = 300
}

variable "image_repository" {
  description = "Image repository for the Driver"
  type        = string
  default     = "registry.k8s.io/csi-secrets-store/driver"
}

variable "image_repository_crds" {
  description = "Image repository for the CRDs"
  type        = string
  default     = "registry.k8s.io/csi-secrets-store/driver-crds"
}

variable "image_tag" {
  description = "Image tag for the Driver and CRDs"
  type        = string
  default     = "v1.4.8"
}

variable "resources_driver" {
  description = "Driver Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "50m"
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
  default     = "registry.k8s.io/sig-storage/csi-node-driver-registrar"
}

variable "image_tag_registrar" {
  description = "Image tag"
  type        = string
  default     = "v2.11.1"
}

variable "resources_registrar" {
  description = "Registrar Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "10m"
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
  default     = "registry.k8s.io/sig-storage/livenessprobe"
}

variable "image_tag_liveness" {
  description = "Image tag fo the LivenessProbe"
  type        = string
  default     = "v2.13.1"
}

variable "resources_liveness" {
  description = "Liveness Probe Resources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "10m"
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

variable "pod_labels" {
  description = "Labels for Secrets Store CSI Driver pods"
  type        = map(any)
  default     = {}
}

variable "pod_annotations" {
  description = "Annotations for Secrets Store CSI Driver pods"
  type        = map(any)
  default     = {}
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

###########################
## ASCP Helm Chart Values
###########################
variable "ascp_release_name" {
  description = "ASCP helm release name"
  type        = string
  default     = "csi-secrets-store-provider-aws"
}

variable "ascp_chart_name" {
  description = "Name of ASCP chart"
  type        = string
  default     = "secrets-store-csi-driver-provider-aws"
}

variable "ascp_chart_repository" {
  description = "Helm repository for the ASCP chart"
  type        = string
  default     = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
}

variable "ascp_chart_version" {
  description = "Version of ASCP chart to install. Set to empty to install the latest version"
  type        = string
  default     = "0.3.11"
}

variable "ascp_chart_namespace" {
  description = "Namespace to install the ASCP chart into"
  type        = string
  default     = "secrets-store-csi-system"
}

variable "ascp_chart_timeout" {
  description = "Timeout to wait for the ASCP chart to be deployed."
  type        = number
  default     = 300
}

variable "ascp_image_repository" {
  description = "Image repository of the ASCP"
  type        = string
  default     = "public.ecr.aws/aws-secrets-manager/secrets-store-csi-driver-provider-aws"
}

variable "ascp_image_tag" {
  description = "Image tag of the ASCP"
  type        = string
  default     = "1.0.r2-80-g8244505-2025.02.10.18.44"
}

variable "ascp_node_selector" {
  description = "Node selector for ASCP pods"
  type        = map(any)
  default     = {}
}

variable "ascp_tolerations" {
  description = "Tolerations for ASCP pods"
  type        = list(map(string))
  default     = []
}

variable "ascp_resources" {
  description = "ASCP container rsources"
  type        = map(any)
  default = {
    requests = {
      cpu    = "50m"
      memory = "100Mi"
    }
    limits = {
      cpu    = "50m"
      memory = "100Mi"
    }
  }
}

variable "ascp_pod_labels" {
  description = "Labels for ASCP pods"
  type        = map(any)
  default     = {}
}

variable "ascp_pod_annotations" {
  description = "Annotations for ASCP pods"
  type        = map(any)
  default     = {}
}

variable "ascp_priority_class_name" {
  description = "Priority class name for ASCP pods"
  type        = string
  default     = "system-node-critical"
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

variable "namespace" {
  description = "Kubernetes namespace, where the service account want to create"
  type        = string
  default     = "default"
}

variable "iam_role_type" {
  description = "IAM Roles for Service Accounts `irsa` or `pod_identity`"
  type        = string
  default     = "pod_identity"

  validation {
    condition     = contains(["irsa", "pod_identity"], var.iam_role_type)
    error_message = "IAM Role type must be either `irsa` or `pod_identity`"
  }
}

variable "external_secrets_kms_key_arns" {
  description = "List of KMS Key ARNs that are used by Secrets Manager that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = []
}

variable "external_secrets_create_permission" {
  description = "Determines whether External Secrets has permission to create/delete secrets"
  type        = bool
  default     = false
}
