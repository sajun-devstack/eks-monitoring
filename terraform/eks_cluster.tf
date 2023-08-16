# create a cluster
resource "aws_eks_cluster" "devstack_monitoring" {
  name = "devstack_monitoring"
  version = "1.27"

  role_arn = aws_iam_role.monitor.arn
  vpc_config {
    subnet_ids = [aws_subnet.one.id, aws_subnet.two.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.monitor-AmazonEKSClusterPolicy
  ]
}