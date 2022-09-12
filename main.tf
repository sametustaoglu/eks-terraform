# module "vpc" {
#   source = "./vpc"
# }

# module "compute" {
#     source = "./compute"
# }

# module "iam" {
#     source = "./iam"
# }
# module "sg" {
#     source = "./sg"
# }

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = "vpc-cni"
}

# resource "aws_eks_addon" "kube_proxy" {
#   cluster_name = aws_eks_cluster.eks.name
#   addon_name   = "kube_proxy"
#   addon_version = "v1.22.11-eksbuild.2"
# }

# resource "aws_eks_addon" "coredns" {
#   cluster_name = aws_eks_cluster.eks.name
#   addon_name   = "coredns"
#   addon_version = "v1.8.7-eksbuild.2"
# }

