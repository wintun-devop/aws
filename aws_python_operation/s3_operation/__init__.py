
import os,boto3,json
from dotenv import load_dotenv
from boto3.s3.transfer import S3UploadFailedError
from botocore.exceptions import ClientError
#to get to ensure from .env
load_dotenv(override=True)

access_key=os.getenv("AWS_ACCESS_KEY")
secret_key=os.getenv("AWS_SECRET_ACCESS_KEY")
region=os.getenv("AWS_REGION")

#s3 resource
s3_resource= boto3.resource("s3",
                        aws_access_key_id=access_key,
                        aws_secret_access_key=secret_key,
                        region_name=region
                        )

# Initialize S3 client instead of resource
s3_client = boto3.client("s3",
                         aws_access_key_id=access_key,
                         aws_secret_access_key=secret_key)

#list buckets
def list_buckets():
    try:
        resp =  list(s3_resource.buckets.all())
        # print("bucket_from_all_regions",resp)
        bucket = [bucket.name for bucket in resp]
        # print("bucket",bucket)
        json_output = json.dumps({"buckets": bucket}, indent=4)
        print("json",json_output)
        return {"bucket":json_output}
    except ClientError as e:
        print(str(e))
        raise e

#list bucket with associated region    
def list_buckets_with_regions():
    bucket_list = []
    try:
        for bucket in s3_resource.buckets.all():
           region = s3_resource.meta.client.get_bucket_location(Bucket=bucket.name)['LocationConstraint']
           # Default to us-east-1
           bucket_list.append({"name": bucket.name, "region": region if region else "us-east-1"})
        buckets=json.dumps({"buckets": bucket_list}, indent=4)
        print("backup",buckets)
        return {"result":buckets}
    except ClientError as e:
        print(str(e))
        raise e

#create bucket
def create_bucket(bucket_name):
    try:
        resp = s3_resource.create_bucket(
            Bucket=bucket_name,
            CreateBucketConfiguration={"LocationConstraint": region}
        )
        print("res",resp)
        return {}
    except ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "BucketAlreadyOwnedByYou":
            print(f"Bucket '{bucket_name}' already exists and is owned by you.")
            return {"message": f"Bucket '{bucket_name}' already exists."}
        elif error_code == "BucketAlreadyExists":
            print(f"Bucket '{bucket_name}' is already taken by another user.")
            return {"message": f"Bucket '{bucket_name}' is already in use by another account."}
        elif error_code == "IllegalLocationConstraintException":
            print(f"Bucket '{bucket_name}' is regional end-point missing error.")
            return {"message": f"Bucket '{bucket_name}' is regional end-point missing error."}
        else:
            print(f"Unexpected error: {str(e)}")
            raise e

#create bucket
def delete_bucket(bucket_name):
    try:
        resp = s3_resource.Bucket(bucket_name).delete()
        result = json.dumps({**resp}, indent=4)
        print("final_delete_result",result)
        return {**resp}
    except ClientError as e:
        error_code = e.response["Error"]["Code"]
        print("error_code",error_code)
        if error_code == "BucketNotEmpty":
            print(f"Bucket '{bucket_name}' is not empty and can not delete.")
            return {"message": f"Bucket '{bucket_name}' is not empty and can not delete."}
        else:
            print(f"Unexpected error: {str(e)}")
            raise e


def main():
    delete_bucket("8uufa")
    
if __name__ == "__main__":
    main()
        


    


""" 
https://docs.aws.amazon.com/code-library/latest/ug/python_3_s3_code_examples.html#basics
"""

        