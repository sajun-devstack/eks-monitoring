# create a cluster
resource "aws_eks_cluster" "main" {
  name = "devstack-monitoring"
  version = "1.27"

  role_arn = aws_iam_role.monitor.arn
  vpc_config {
    subnet_ids = [aws_subnet.one.id, aws_subnet.two.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.monitor-AmazonEKSClusterPolicy
  ]
}


resource "aws_eks_node_group" "eks_worker_nodes" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "my-worker-nodes"
  node_role_arn   = aws_iam_role.worker.arn
  # Identifiers of EC2 Subnets to associate with the EKS Node Group.
  subnet_ids      = [aws_subnet.one.id, aws_subnet.two.id]
  instance_types = ["t3.medium"]

  # Auto Scaling Group of Kubernetes worker nodes
  scaling_config {
    desired_size = 1   # Desired number of worker nodes
    max_size     = 2   # Maximum number of worker nodes
    min_size     = 1   # Minimum number of worker nodes
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.worker-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.worker-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.worker-CloudWatchAgentServerPolicy,
  ]
}