output "ebs_csi_role_arn" {
  value = var.enable_ebs_csi ? aws_iam_role.ebs_csi[0].arn : null
}

output "managed_addons" {
  value = {
    vpc_cni    = var.enable_vpc_cni
    kube_proxy = var.enable_kube_proxy
    coredns    = var.enable_coredns
    ebs_csi    = var.enable_ebs_csi
  }
}