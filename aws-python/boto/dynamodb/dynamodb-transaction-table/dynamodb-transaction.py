#https://github.com/wintun-devop
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
#ref:https://boto3.amazonaws.com/v1/documentation/api/latest/guide/dynamodb.html
import boto3
import aws_config as awsdata

#resource method for dynamodb
ec2Resource=boto3.resource("dynamodb",region_name=awsdata.aws_region,aws_access_key_id=awsdata.aws_access_key,
                   aws_secret_access_key=awsdata.aws_secret_key
                    )

def create_table(table_name):
    #define datble to create using resource method
    tranactionTable=ec2Resource.create_table(
    TableName=table_name,
    KeySchema=[
        {
            "AttributeName": "transactionID",
            "KeyType": "HASH"
        },
        {
            "AttributeName": "transactionType",
            "KeyType": "RANGE"
        }
    ],
    AttributeDefinitions=[
        {
            "AttributeName": "transactionID",
            "AttributeType": "N"
        },
        {
            "AttributeName": "transactionType",
            "AttributeType": "S"
        },
    ],
    ProvisionedThroughput={
        "ReadCapacityUnits": 5,
        "WriteCapacityUnits": 5
    }
    )
    # Wait until the table exists.
    tranactionTable.wait_until_exists()
    print(f"Dynamodb table named {table_name}  has been created successfully!")

def create_items():
    table = ec2Resource.Table("transaction")
    table.put_item(
        Item={
            "transactionID":4,
            "transactionType":"haire-purchase"
        }
    )
    
    
    
    
def main():
    #place table name here
    #create_table("transaction")
    create_items()

    
if __name__ == "__main__":
    main()