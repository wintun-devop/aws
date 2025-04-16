
import os,boto3,json
from dotenv import load_dotenv
from boto3.s3.transfer import S3UploadFailedError
from botocore.exceptions import ClientError
#to get to ensure from .env
load_dotenv(override=True)

access_key=os.getenv("AWS_ACCESS_KEY")
secret_key=os.getenv("AWS_SECRET_ACCESS_KEY")
region=os.getenv("AWS_REGION")

s3_client_resource= boto3.resource("s3",
                                   aws_access_key_id=access_key,
                        aws_secret_access_key=secret_key
                        )

def list_buckets():
    try:
        resp =  list(s3_client_resource.buckets.all())
        # print("bucket_from_all_regions",resp)
        bucket = [bucket.name for bucket in resp]
        # print("bucket",bucket)
        json_output = json.dumps({"buckets": bucket}, indent=4)
        print("json",json_output)
        return {"bucket":json_output}
    except ClientError as e:
        print(str(e))
        raise e
    
def main():
    list_buckets()
    
if __name__ == "__main__":
    main()
        


    


""" 
https://docs.aws.amazon.com/code-library/latest/ug/python_3_s3_code_examples.html#basics
"""

        