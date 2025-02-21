# Terraform Modules Template

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pod_identity"></a> [pod\_identity](#module\_pod\_identity) | terraform-aws-modules/eks-pod-identity/aws | ~> 1.10 |
| <a name="module_secrets_manager_role"></a> [secrets\_manager\_role](#module\_secrets\_manager\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.52 |

## Resources

| Name | Type |
|------|------|
| [helm_release.ascp](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.release](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_affinity"></a> [affinity](#input\_affinity) | Affinity for Secrets Store CSI Driver pods. Prevents the CSI driver from being scheduled on virtual-kubelet nodes by default | `map(any)` | <pre>{<br/>  "nodeAffinity": {<br/>    "requiredDuringSchedulingIgnoredDuringExecution": {<br/>      "nodeSelectorTerms": [<br/>        {<br/>          "matchExpressions": [<br/>            {<br/>              "key": "type",<br/>              "operator": "NotIn",<br/>              "values": [<br/>                "virtual-kubelet"<br/>              ]<br/>            }<br/>          ]<br/>        }<br/>      ]<br/>    }<br/>  }<br/>}</pre> | no |
| <a name="input_ascp_chart_name"></a> [ascp\_chart\_name](#input\_ascp\_chart\_name) | Name of ASCP chart | `string` | `"secrets-store-csi-driver-provider-aws"` | no |
| <a name="input_ascp_chart_namespace"></a> [ascp\_chart\_namespace](#input\_ascp\_chart\_namespace) | Namespace to install the ASCP chart into | `string` | `"secrets-store-csi-system"` | no |
| <a name="input_ascp_chart_repository"></a> [ascp\_chart\_repository](#input\_ascp\_chart\_repository) | Helm repository for the ASCP chart | `string` | `"https://aws.github.io/secrets-store-csi-driver-provider-aws"` | no |
| <a name="input_ascp_chart_timeout"></a> [ascp\_chart\_timeout](#input\_ascp\_chart\_timeout) | Timeout to wait for the ASCP chart to be deployed. | `number` | `300` | no |
| <a name="input_ascp_chart_version"></a> [ascp\_chart\_version](#input\_ascp\_chart\_version) | Version of ASCP chart to install. Set to empty to install the latest version | `string` | `"0.3.11"` | no |
| <a name="input_ascp_image_repository"></a> [ascp\_image\_repository](#input\_ascp\_image\_repository) | Image repository of the ASCP | `string` | `"public.ecr.aws/aws-secrets-manager/secrets-store-csi-driver-provider-aws"` | no |
| <a name="input_ascp_image_tag"></a> [ascp\_image\_tag](#input\_ascp\_image\_tag) | Image tag of the ASCP | `string` | `"1.0.r2-80-g8244505-2025.02.10.18.44"` | no |
| <a name="input_ascp_node_selector"></a> [ascp\_node\_selector](#input\_ascp\_node\_selector) | Node selector for ASCP pods | `map(any)` | `{}` | no |
| <a name="input_ascp_pod_annotations"></a> [ascp\_pod\_annotations](#input\_ascp\_pod\_annotations) | Annotations for ASCP pods | `map(any)` | `{}` | no |
| <a name="input_ascp_pod_labels"></a> [ascp\_pod\_labels](#input\_ascp\_pod\_labels) | Labels for ASCP pods | `map(any)` | `{}` | no |
| <a name="input_ascp_priority_class_name"></a> [ascp\_priority\_class\_name](#input\_ascp\_priority\_class\_name) | Priority class name for ASCP pods | `string` | `"system-node-critical"` | no |
| <a name="input_ascp_release_name"></a> [ascp\_release\_name](#input\_ascp\_release\_name) | ASCP helm release name | `string` | `"csi-secrets-store-provider-aws"` | no |
| <a name="input_ascp_resources"></a> [ascp\_resources](#input\_ascp\_resources) | ASCP container rsources | `map(any)` | <pre>{<br/>  "limits": {<br/>    "cpu": "50m",<br/>    "memory": "100Mi"<br/>  },<br/>  "requests": {<br/>    "cpu": "50m",<br/>    "memory": "100Mi"<br/>  }<br/>}</pre> | no |
| <a name="input_ascp_tolerations"></a> [ascp\_tolerations](#input\_ascp\_tolerations) | Tolerations for ASCP pods | `list(map(string))` | `[]` | no |
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | Helm chart name to provision | `string` | `"secrets-store-csi-driver"` | no |
| <a name="input_chart_namespace"></a> [chart\_namespace](#input\_chart\_namespace) | Namespace to install the chart into | `string` | `"secrets-store-csi-system"` | no |
| <a name="input_chart_repository"></a> [chart\_repository](#input\_chart\_repository) | Helm repository for the chart | `string` | `"https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"` | no |
| <a name="input_chart_timeout"></a> [chart\_timeout](#input\_chart\_timeout) | Timeout to wait for the Chart to be deployed. | `number` | `300` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Version of Chart to install. Set to empty to install the latest version | `string` | `"1.4.8"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of Kubernetes Cluster | `string` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create the namespace if it does not exist | `bool` | `true` | no |
| <a name="input_enableSecretRotation"></a> [enableSecretRotation](#input\_enableSecretRotation) | Enable rotation for secrets | `bool` | `false` | no |
| <a name="input_external_secrets_create_permission"></a> [external\_secrets\_create\_permission](#input\_external\_secrets\_create\_permission) | Determines whether External Secrets has permission to create/delete secrets | `bool` | `false` | no |
| <a name="input_external_secrets_kms_key_arns"></a> [external\_secrets\_kms\_key\_arns](#input\_external\_secrets\_kms\_key\_arns) | List of KMS Key ARNs that are used by Secrets Manager that contain secrets to mount using External Secrets | `list(string)` | `[]` | no |
| <a name="input_external_secrets_secrets_manager_arns"></a> [external\_secrets\_secrets\_manager\_arns](#input\_external\_secrets\_secrets\_manager\_arns) | List of Secrets Manager ARNs that contain secrets to mount using External Secrets | `list(string)` | <pre>[<br/>  "arn:aws:secretsmanager:*:*:secret:*"<br/>]</pre> | no |
| <a name="input_external_secrets_ssm_parameter_arns"></a> [external\_secrets\_ssm\_parameter\_arns](#input\_external\_secrets\_ssm\_parameter\_arns) | List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets | `list(string)` | <pre>[<br/>  "arn:aws:ssm:*:*:parameter/*"<br/>]</pre> | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name of IAM role for controller | `string` | `""` | no |
| <a name="input_iam_role_type"></a> [iam\_role\_type](#input\_iam\_role\_type) | IAM Roles for Service Accounts `irsa` or `pod_identity` | `string` | `"pod_identity"` | no |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | Image repository for the Driver | `string` | `"registry.k8s.io/csi-secrets-store/driver"` | no |
| <a name="input_image_repository_crds"></a> [image\_repository\_crds](#input\_image\_repository\_crds) | Image repository for the CRDs | `string` | `"registry.k8s.io/csi-secrets-store/driver-crds"` | no |
| <a name="input_image_repository_liveness"></a> [image\_repository\_liveness](#input\_image\_repository\_liveness) | Image repository for the Liveness Probe | `string` | `"registry.k8s.io/sig-storage/livenessprobe"` | no |
| <a name="input_image_repository_registrar"></a> [image\_repository\_registrar](#input\_image\_repository\_registrar) | Image repository for the Registrar | `string` | `"registry.k8s.io/sig-storage/csi-node-driver-registrar"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | Image tag for the Driver and CRDs | `string` | `"v1.4.8"` | no |
| <a name="input_image_tag_liveness"></a> [image\_tag\_liveness](#input\_image\_tag\_liveness) | Image tag fo the LivenessProbe | `string` | `"v2.13.1"` | no |
| <a name="input_image_tag_registrar"></a> [image\_tag\_registrar](#input\_image\_tag\_registrar) | Image tag | `string` | `"v2.11.1"` | no |
| <a name="input_max_history"></a> [max\_history](#input\_max\_history) | Max History for Helm | `number` | `20` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace, where the service account want to create | `string` | `"default"` | no |
| <a name="input_node_selector"></a> [node\_selector](#input\_node\_selector) | Node selector for Secrets Store CSI Driver pods | `map(any)` | `{}` | no |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | OIDC Provider ARN for IRSA | `string` | n/a | yes |
| <a name="input_pod_annotations"></a> [pod\_annotations](#input\_pod\_annotations) | Annotations for Secrets Store CSI Driver pods | `map(any)` | `{}` | no |
| <a name="input_pod_labels"></a> [pod\_labels](#input\_pod\_labels) | Labels for Secrets Store CSI Driver pods | `map(any)` | `{}` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | Helm release name | `string` | `"secrets-store-csi-driver"` | no |
| <a name="input_resources_driver"></a> [resources\_driver](#input\_resources\_driver) | Driver Resources | `map(any)` | <pre>{<br/>  "limits": {<br/>    "cpu": "200m",<br/>    "memory": "200Mi"<br/>  },<br/>  "requests": {<br/>    "cpu": "50m",<br/>    "memory": "200Mi"<br/>  }<br/>}</pre> | no |
| <a name="input_resources_liveness"></a> [resources\_liveness](#input\_resources\_liveness) | Liveness Probe Resources | `map(any)` | <pre>{<br/>  "limits": {<br/>    "cpu": "100m",<br/>    "memory": "100Mi"<br/>  },<br/>  "requests": {<br/>    "cpu": "10m",<br/>    "memory": "100Mi"<br/>  }<br/>}</pre> | no |
| <a name="input_resources_registrar"></a> [resources\_registrar](#input\_resources\_registrar) | Registrar Resources | `map(any)` | <pre>{<br/>  "limits": {<br/>    "cpu": "100m",<br/>    "memory": "100Mi"<br/>  },<br/>  "requests": {<br/>    "cpu": "10m",<br/>    "memory": "100Mi"<br/>  }<br/>}</pre> | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | Name of service account to create. Not generated | `string` | `"csi-secrets-store-provider-aws"` | no |
| <a name="input_syncSecretEnabled"></a> [syncSecretEnabled](#input\_syncSecretEnabled) | Sync with kubernetes secrets | `bool` | `false` | no |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Tolerations for Secrets Store CSI Driver pods | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
<!-- END_TF_DOCS -->
