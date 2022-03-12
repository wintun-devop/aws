#https://github.com/wintun-devop
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
import boto3

def move_multiple_object():
    #Place your access key here correctly
    aws_access_key_id = ""
    aws_secret_access_key = ""

    #place your source and destination backet name and folder path(prefix)
    source_backet_name="webs3server01"
    source_prefix="sourcefolder/"
    destination_backet_name="webs3server02"
    destination_prefix="descfolder/"
    s3 = boto3.resource('s3',
                        aws_access_key_id=aws_access_key_id,
                        aws_secret_access_key=aws_secret_access_key
    )
    source_bucket=s3.Bucket(source_backet_name)
    destination_bucket=s3.Bucket(destination_backet_name)
    for object in source_bucket.objects.filter(Prefix=source_prefix):
        object_in_source={
                'Bucket': source_backet_name,
                'Key': object.key
            }
        #exchange to destination preifx
        object_in_temp=object.key.replace(source_prefix, destination_prefix)
        object_in_destination=destination_bucket.Object(object_in_temp)
        #cut and clear the source directory
        object_in_destination.copy(object_in_source)
        object.delete()
    #recreate orginal directory
    s3 = boto3.client('s3',
                      aws_access_key_id=aws_access_key_id,
                        aws_secret_access_key=aws_secret_access_key
    )
    s3.put_object(Bucket=source_backet_name, Key=source_prefix)

     
def main():
    move_multiple_object()
    
if __name__ == "__main__":
    main()
    
    
