



resource "aws_eks_cluster" "eks" {
  name      = "eks-${var.cluster-name}"
  role_arn  = aws_iam_role.cluster.arn
  version   = var.k8s_version
  enabled_cluster_log_types = var.cloudwatch ? ["api", "audit", "authenticator", "controllerManager", "scheduler"] : []
  
  vpc_config {
    security_group_ids = [aws_security_group.cluster.id]
    subnet_ids = [
      aws_subnet.private-a.id,
      aws_subnet.private-b.id,
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy
  ]
}
resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "eks-${var.cluster-name}-1"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      =  [
      aws_subnet.private-a.id,
      aws_subnet.private-b.id,
    ]
  instance_types  = [var.inst-type[0]] #todo fatma
  disk_size       = var.inst_disk_size

  scaling_config {
    desired_size = var.num-workers
    max_size     = var.max-workers
    min_size     = var.num-workers
  }

  remote_access {
    ec2_ssh_key = var.inst_key_pair
  }

  # This does not work although the docs say it should! See https://github.com/aws/containers-roadmap/issues/608
  tags = {
    "Name" = "eks-${var.cluster-name}-1"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_eks_node_group" "node2" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "eks-${var.cluster-name}-2"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      =  [
      aws_subnet.private-a.id,
      aws_subnet.private-b.id,
    ]
  instance_types  = [var.inst-type[1]] #todo fatma
  disk_size       = var.inst_disk_size

  scaling_config {
    desired_size = var.num-workers
    max_size     = var.max-workers
    min_size     = var.num-workers
  }

  remote_access {
    ec2_ssh_key = var.inst_key_pair
  }

  # This does not work although the docs say it should! See https://github.com/aws/containers-roadmap/issues/608
  tags = {
    "Name" = "eks-${var.cluster-name}-1"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
  ]
}