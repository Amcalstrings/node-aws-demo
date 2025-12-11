# output "cluster_name" {
#   value = module.eks.cluster_id
# }

output "ecr_repo_url" {
  value = aws_ecr_repository.app.repository_url
}

# output "kubeconfig-certificate-authority-data" {
#   value = module.eks.cluster_certificate_authority_data
# }

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_ca" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}