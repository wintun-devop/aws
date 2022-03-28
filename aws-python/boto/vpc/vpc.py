#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#https://www.github.com/wintun-devop
"""    
It is required to assign correct access key id and secret key in order to run properly this python
script.Here,I use Tokyo(ap-northeast-1) region as an example.Be careful to assign correct zone and
here in this case,there is no zone with named "b" as ap-northeast-1a,ap-northeast-1c and
ap-northeast-1d on Tokyo region.
"""

import boto3

#Place your access key here correctly
aws_access_key_id = ""
aws_secret_access_key = ""
#Assign your aws infra region and zone correctly
aws_region="ap-northeast-1"
aws_az=["a","c","d"]



def create_aws_vpc():
    #Place your access key here correctly
    #aws_access_key_id = ""
    #aws_secret_access_key = ""
    #Assign your aws infra region and zone correctly
    #aws_region="ap-northeast-1"
    #aws_az=["a","c","d"]
    #resource method
    ec2=boto3.resource('ec2',region_name=aws_region,aws_access_key_id=aws_access_key_id,
                   aws_secret_access_key=aws_secret_access_key
                    )
    #client method
    ec2Client = boto3.client('ec2',region_name=aws_region,aws_access_key_id=aws_access_key_id,
                         aws_secret_access_key=aws_secret_access_key
                         )
    infra_vpc=ec2.create_vpc(CidrBlock="10.80.0.0/16")
    #assign tags for vpc
    infra_vpc.create_tags(Tags=[{"Key": "Name", "Value": "infra"},{"Key": "Project", "Value": "TrainingAndCertification"}])
    infra_vpc.wait_until_available()
    ec2Client.modify_vpc_attribute( VpcId = infra_vpc.id , EnableDnsSupport = { 'Value': True } )
    ec2Client.modify_vpc_attribute( VpcId = infra_vpc.id , EnableDnsHostnames = { 'Value': True } )
    print(infra_vpc.id)
    # create an internet gateway and attach it to VPC
    infra_igw = ec2.create_internet_gateway()
    infra_vpc.attach_internet_gateway(InternetGatewayId=infra_igw.id)
    print(infra_igw.id)
    # create a route table and a public route
    rt_public = infra_vpc.create_route_table()
    rt_public.create_tags(Tags=[{"Key": "Name", "Value": "infra_rt_public"},{"Key": "Project", "Value": "TrainingAndCertification"}])
    public_route = rt_public.create_route(DestinationCidrBlock='0.0.0.0/0', GatewayId=infra_igw.id)
    rt_private = infra_vpc.create_route_table()
    rt_private.create_tags(Tags=[{"Key": "Name", "Value": "infra_rt_private"},{"Key": "Project", "Value": "TrainingAndCertification"}])
    print(rt_public.id)
    print(rt_private.id)
    # create public subnets and associate it with public route table
    az_1="{}{}".format(aws_region,aws_az[0])
    public_subnet_1 = ec2.create_subnet(CidrBlock='10.80.0.0/24', VpcId=infra_vpc.id,AvailabilityZone=az_1)
    public_subnet_1.create_tags(Tags=[{"Key": "Name", "Value": "sub-1-public"}])
    rt_public.associate_with_subnet(SubnetId=public_subnet_1.id)
    print(public_subnet_1.id)
    az_2="{}{}".format(aws_region,aws_az[1])
    private_subnet_1 = ec2.create_subnet(CidrBlock='10.80.1.0/24', VpcId=infra_vpc.id,AvailabilityZone=az_2)
    private_subnet_1.create_tags(Tags=[{"Key": "Name", "Value": "sub-2-private"}])
    rt_private.associate_with_subnet(SubnetId=private_subnet_1.id)
    print(private_subnet_1.id)
    
def main():
    create_aws_vpc()
    
if __name__ == "__main__":
    main()
    
    
