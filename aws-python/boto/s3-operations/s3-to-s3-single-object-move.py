import boto3,time

#Insert your access key id and secret key
aws_access_key_id = ""
aws_secret_access_key = ""

def move():
    current_date_time = time.strftime('%m%d%Y-%H%M%S')
    s3 = boto3.resource(
    's3',
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key
    )
    copy_source = {
    'Bucket': 'webs3server01',
    'Key': 'book.csv'
    }
    destination_file="book"+current_date_time+".csv"
    s3.meta.client.copy(copy_source, 'webs3server02', destination_file)
    client = boto3.client('s3')
    client.delete_object(Bucket=copy_source['Bucket'],Key=copy_source['Key'])
    
def main():
    move()

if __name__ == '__main__':
    main()