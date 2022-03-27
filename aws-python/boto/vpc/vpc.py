import boto3

#resource method
ec2=boto3.resource('ec2')
infra_vpc=ec2.create_vpc(CidrBlock="10.80.0.0/16")
#assign tags for vpc
infra_vpc.create_tags(Tags=[{"Key": "Name", "Value": "infra"},{"Key": "Project", "Value": "TrainingAndCertification"}])
infra_vpc.wait_until_available()
#client method
ec2Client = boto3.client('ec2')
ec2Client.modify_vpc_attribute( VpcId = infra_vpc.id , EnableDnsSupport = { 'Value': True } )
ec2Client.modify_vpc_attribute( VpcId = infra_vpc.id , EnableDnsHostnames = { 'Value': True } )
# create an internet gateway and attach it to VPC
infra_igw = ec2.create_internet_gateway()
infra_vpc.attach_internet_gateway(InternetGatewayId=infra_igw.id)
# create a route table and a public route
rt_public = infra_vpc.create_route_table()
public_route = rt_public.create_route(DestinationCidrBlock='0.0.0.0/0', GatewayId=infra_igw.id)
rt_private = infra_vpc.create_route_table()
# create public subnets and associate it with public route table
public_subnet_1 = ec2.create_subnet(CidrBlock='10.80.0.0/24', VpcId=infra_vpc.id)
rt_public.associate_with_subnet(SubnetId=public_subnet_1.id)