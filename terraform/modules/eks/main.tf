resource "aws_iam_role" "eks_role" {
    name = "eks-cluster-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "eks.amazonaws.com"
            }
        }]
    }

    )
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
    role = aws_iam_role.eks_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "cluster" {
    name = var.cluster_name
    role_arn = aws_iam_role.eks_role.arn
    version = var.eks_version

    vpc_config {
        subnet_ids = var.subnet_ids
    }

    depends_on = [
        aws_iam_role_policy_attachment.eks_policy
    ]    
} 

resource "aws_iam_role" "node_role" {
    name = "eks-node-group-role"

    assume_role_policy = jsonencode ( { 
        Version = "2012-10-17"
        Statement = [{
            Effect = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
            Action = "sts:AssumeRole"
        }]
    })
}

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
    role = aws_iam_role.node_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
    role = aws_iam_role.node_role.name 
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "registry_policy" {
    role = aws_iam_role.node_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_node_group" "nodes" {
    cluster_name = aws_eks_cluster.cluster.name
    node_group_name = "hybrid-node-group"
    node_role_arn = aws_iam_role.node_role.arn

    ami_type = "AL2_x86_64"

    subnet_ids = var.subnet_ids
    version = var.eks_version
    
    scaling_config {
        desired_size = 2
        max_size     = 3
        min_size     = 1
    }

    instance_types = ["t3.medium"]

    depends_on = [
        aws_iam_role_policy_attachment.worker_node_policy,
        aws_iam_role_policy_attachment.cni_policy,
        aws_iam_role_policy_attachment.registry_policy
    ]
}
