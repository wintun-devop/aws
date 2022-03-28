#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#https://www.github.com/wintun-devop
"""    
It is required to assign correct access key id and secret key in order to run properly this python
script.Here,I use Tokyo(ap-northeast-1) region as an example.Be careful to assign correct zone and
here in this case,there is no zone with named "b" as ap-northeast-1a,ap-northeast-1c and
ap-northeast-1d on Tokyo region.
"""
import boto3

#Place your access key and secret key here correctly
aws_access_key_id = ""
aws_secret_access_key = ""
#Assign your aws infra region and zone correctly
aws_region="ap-northeast-1"
aws_az=["ap-northeast-1a","ap-northeast-1c","ap-northeast-1d"]
vpc_cidr_block="10.80.0.0/16"
public_subnet_list=["10.80.0.0/24","10.80.1.0/24","10.80.2.0/24"]
api_subnet_list=["10.80.3.0/24","10.80.4.0/24","10.80.5.0/24"]
database_subnet_list=["10.80.6.0/24","10.80.7.0/24","10.80.8.0/24"]

def create_aws_vpc():
    #resource method
    ec2Resource=boto3.resource('ec2',region_name=aws_region,aws_access_key_id=aws_access_key_id,
                   aws_secret_access_key=aws_secret_access_key
                    )
    #client method
    ec2Client = boto3.client('ec2',region_name=aws_region,aws_access_key_id=aws_access_key_id,
                         aws_secret_access_key=aws_secret_access_key
                         )
    infra_vpc=ec2Resource.create_vpc(CidrBlock=vpc_cidr_block)
    #assign tags for vpc
    infra_vpc.create_tags(Tags=[{"Key": "Name", "Value": "infra"},{"Key": "Project", "Value": "TrainingAndCertification"}])
    infra_vpc.wait_until_available()
    ec2Client.modify_vpc_attribute( VpcId = infra_vpc.id , EnableDnsSupport = { 'Value': True } )
    ec2Client.modify_vpc_attribute( VpcId = infra_vpc.id , EnableDnsHostnames = { 'Value': True } )
    print(f"VPC {infra_vpc.id} has been created.")
    # create an internet gateway and attach it to VPC
    infra_igw = ec2Resource.create_internet_gateway()
    infra_vpc.attach_internet_gateway(InternetGatewayId=infra_igw.id)
    print(f"Internet gateway {infra_igw.id} has been created.")
    # create a route table and a public route
    rt_public = infra_vpc.create_route_table()
    rt_public.create_tags(Tags=[{"Key": "Name", "Value": "infra_rt_public"},{"Key": "Project", "Value": "TrainingAndCertification"}])
    public_route = rt_public.create_route(DestinationCidrBlock='0.0.0.0/0', GatewayId=infra_igw.id)
    rt_private = infra_vpc.create_route_table()
    rt_private.create_tags(Tags=[{"Key": "Name", "Value": "infra_rt_private"},{"Key": "Project", "Value": "TrainingAndCertification"}])
    print(f"Public route table {rt_public.id} has been created.")
    print(f"Private route table {rt_private.id} has been created.")
    #creation subnets accourding to availability zone index
    for az in aws_az:
        #collecting one index which can be used as index for subnet range
        count=aws_az.index(az)
        #creating puiblic subnets according to az list index
        public_subnet = ec2Resource.create_subnet(CidrBlock=public_subnet_list[count], VpcId=infra_vpc.id,AvailabilityZone=az)
        rt_public.associate_with_subnet(SubnetId=public_subnet.id)
        public_subnet_tag="sub-"+str(count+1)+"-public"
        public_subnet.create_tags(Tags=[{"Key": "Name", "Value": public_subnet_tag }])
        print(f"Public {public_subnet.id} has been created.")
        #creating middle api subnets according to az list index
        api_middle_subnet=ec2Resource.create_subnet(CidrBlock=api_subnet_list[count], VpcId=infra_vpc.id,AvailabilityZone=az)
        rt_private.associate_with_subnet(SubnetId=api_middle_subnet.id)
        api_middle_subnet_tag="sub-"+str(count+4)+"-api"
        api_middle_subnet.create_tags(Tags=[{"Key": "Name", "Value": api_middle_subnet_tag}])
        print(f"Api {api_middle_subnet.id} has been created.")
        #creating backend database subnets according to az list index
        db_backend_subnet=ec2Resource.create_subnet(CidrBlock=database_subnet_list[count], VpcId=infra_vpc.id,AvailabilityZone=az)
        rt_private.associate_with_subnet(SubnetId=db_backend_subnet.id)
        db_backend_subnet_tag="sub-"+str(count+7)+"-db"
        db_backend_subnet.create_tags(Tags=[{"Key": "Name", "Value": db_backend_subnet_tag}])
        print(f"Backend database {db_backend_subnet.id} has been created.")
    
def main():
    create_aws_vpc()
    
if __name__ == "__main__":
    main()
    
        
        
        
   
        
    