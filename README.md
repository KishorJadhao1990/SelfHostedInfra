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