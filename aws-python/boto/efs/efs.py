#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#https://www.github.com/wintun-devop
from itertools import count
import boto3

#Place your access key and secret key here correctly
aws_access_key_id = ""
aws_secret_access_key = ""
#Assign your aws infra region and zone correctly
aws_region="us-east-1"

#client method
awsClient = boto3.client("efs",region_name=aws_region,aws_access_key_id=aws_access_key_id,
                         aws_secret_access_key=aws_secret_access_key
                         )
subnet_ids=["subnet-08723523dfbc4ec3a","subnet-05d554164d7766b97","subnet-07bc6f6ef80c9740d"]
target_ips=["172.20.0.200","172.20.1.200","172.20.2.200"]
def create_efs():
    efs_file_system=awsClient.create_file_system(
        PerformanceMode="generalPurpose",
        Encrypted=True,
        ThroughputMode="bursting",
        Tags=[{"Key": "Name","Value": "test-efs-1"},{"Key": "Project","Value": "TrainingAndCertification"}]
    )
    efs_id=efs_file_system["FileSystemId"]
    print(efs_id)

def create_mount_target():
    for subnet in subnet_ids:
        count=subnet_ids.index(subnet)
        efs_mount_target=awsClient.create_mount_target(
                FileSystemId="fs-03e768f51b81a9c46",
                SubnetId=subnet_ids[count]
        )
        print(efs_mount_target)
    
def main():
    create_efs()
    #create_mount_target()

if __name__=="__main__":
    main()

                             