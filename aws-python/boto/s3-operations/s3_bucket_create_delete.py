#https://github.com/wintun-devop
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
import boto3

#Place your access key here correctly
aws_access_key_id = ""
aws_secret_access_key = ""

awsS3Resource = boto3.resource('s3',
                        aws_access_key_id=aws_access_key_id,
                        aws_secret_access_key=aws_secret_access_key
                        )

def bucket_create(bucket_name,aws_region):
    bucket=awsS3Resource.create_bucket(
        Bucket=bucket_name,
        CreateBucketConfiguration={
        "LocationConstraint": aws_region}
    )
    print("Bucket has been created successfully")
    

def delete_bucket(bucket_name):
    bucket_to_delete=awsS3Resource.Bucket(bucket_name)
    bucket_to_delete.delete()
    print(f"Bucket {bucket_name} has been deleted.")


def main():
    delete_bucket("test-bucket-biz7777")
    #bucket_create("test-bucket-biz7777","ap-northeast-1")

if __name__=="__main__":
    main()




