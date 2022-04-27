#https://github.com/wintun-devop
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
import boto3

#creat bucket by resource method
def bucket_create(bucket_name,bucket_region):
    #Place your access key here correctly
    aws_access_key_id = ""
    aws_secret_access_key = ""
    aws_region = "us-east-1"
    awsS3Resource = boto3.resource('s3',
                        aws_access_key_id=aws_access_key_id,
                        aws_secret_access_key=aws_secret_access_key,
                        region_name=aws_region
                        )
    
    if bucket_region == aws_region:
        #create bucket in s3 default location(us-east-1) and no need LocationConstraint
        bucket=awsS3Resource.create_bucket(
        Bucket=bucket_name
        )
        print(f"{bucket} has been created in {bucket_region}.")
    else:
        #create bucket in s3 non-default location(us-east-1) and required LocationConstraint
        location={"LocationConstraint": bucket_region}
        bucket=awsS3Resource.create_bucket(
        Bucket=bucket_name,
        CreateBucketConfiguration=location
        )
        print(f"{bucket} has been created in {bucket_region}.")
    
def delete_bucket(bucket_name):
    #Place your access key here correctly
    aws_access_key_id = ""
    aws_secret_access_key = ""
    awsS3Resource = boto3.resource("s3",
                        aws_access_key_id=aws_access_key_id,
                        aws_secret_access_key=aws_secret_access_key
                        )
    #Try  and Except for error control
    try:
        
        bucket_to_delete=awsS3Resource.Bucket(bucket_name)
        bucket_to_delete.delete()
        print(f"Bucket {bucket_name} has been deleted.")
    except:
        print(f"Bucket {bucket_name} is not empty.Please make sure to be empty for delete bucket.")

def main():
    #delete_bucket("biz-abc-static")
    bucket_create("biz-abc-static","us-east-1")
    bucket_create("biz-abc-static-replica","ap-northeast-1")

if __name__ == "__main__":
    main()
    
    
    