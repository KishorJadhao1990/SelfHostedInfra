# Dynamic Cloud Infra 
### Use case
- It was intended to create infra with resillient scaleable across multi AZs
- Create one VPC with 64 IPs CIDR block, and has 4 subnets.
- Both AZs has private and public subnets, Each of 16 reserve IPs.
- Auto scaling group of EC2 instances and traffic balance using ALB.
- Each EC2 has docker installed when instance created using user data script.
- Multiple EC2 instances are created in private subnets for high availablity.
- Deploy ALB in VPC level infra, map to instances using ASG and TG.

### Docker 
- Each instance has docker installed with user data script.
- Create postgres container and map to 5432 port with host.
- Deploy Application on EC2. Connect database using stored secrets


### Deployement working example
https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/refs/heads/main/docs/examples/2048/2048_full.yaml


### ALB installation guide
https://github.com/iam-veeramalla/aws-devops-zero-to-hero/blob/main/day-22/2048-app-deploy-ingress.md