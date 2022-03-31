
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#https://www.github.com/wintun-devop
#ref:https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds.html#RDS.Client.create_db_instance
import boto3


#Place your access key and secret key here correctly
aws_access_key_id = ""
aws_secret_access_key = ""
#Assign your aws infra region and zone correctly
aws_region="us-east-1"


#client method
ec2Client = boto3.client("rds",region_name=aws_region,aws_access_key_id=aws_access_key_id,
                         aws_secret_access_key=aws_secret_access_key
                         )

def create_subnet_group():
    db_subnet_group = ec2Client.create_db_subnet_group(DBSubnetGroupName="rds-subnets",DBSubnetGroupDescription="Custom subnet group for rds.",
                        SubnetIds=["subnet-0375ef7692d1c9fa2","subnet-0ca730d3bb05af4be","subnet-03f57ea3a5c6b5b72"],
                        Tags=[{"Key": "Name","Value": "RdsSubnets"},{"Key": "Project","Value": "TrainingAndCertification"}])
    print(db_subnet_group)


def create_rds_mysql():
    rds_mysql_instance = ec2Client.create_db_instance(AllocatedStorage=20,DBName="flaskapp1",
                        DBInstanceIdentifier="test-1-mysql",DBInstanceClass="db.t2.micro",
                        Engine="mysql",EngineVersion="8.0.28",MasterUsername="dbadmin",MasterUserPassword="Abc123Abc123",Port=3306,
                        VpcSecurityGroupIds=["sg-0d7af2e91cc611b82"],DBSubnetGroupName="rds-subnets",MultiAZ=False,
                        Tags=[{"Key": "Name","Value": "test-mysql-1"},{"Key": "Project","Value": "TrainingAndCertification"}])
    print(rds_mysql_instance)


def main():
    create_subnet_group()
    create_rds_mysql()

if __name__=="__main__":
    main()


