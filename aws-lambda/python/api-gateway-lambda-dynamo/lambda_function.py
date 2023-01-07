import json,boto3,logging
from custom_encoder import CustomEncoder

# Python Logging Service
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# dynamo Resource
tables = {
    "Books":"Books"
    }
dynamoApi = boto3.resource("dynamodb")
Books = dynamoApi.Table(tables["Books"])

#assign api method and paths
getMethod="GET"
postMethod="POST"
pathMethod="PATCH"
deleteMethod="DELETE"
helathPath="/health"
#book table
bookPath="/book"
booksPath="/books"

def lambda_handler(event, context):
    logger.info(event)
    httpMethod = event['httpMethod']
    path = event['path']
    if httpMethod == getMethod and path == helathPath:
        response = buildResponse(200,{"message":"API is healthly and working ok."})
    # Books table
    elif httpMethod == getMethod and path == bookPath:
        response = getBook(event["queryStringParameters"]["id"])
    elif httpMethod == getMethod and path == booksPath:
        response = getBooks()
    elif httpMethod == postMethod and path == bookPath:
        response = insertBook(json.loads(event["body"]))
    elif httpMethod == pathMethod and path == bookPath:
        requestBody=json.loads(event["body"])
        response = updateBook(requestBody["id"],requestBody["updateKey"],requestBody["updateValue"])
    elif httpMethod == deleteMethod and path == bookPath:
        requestBody=json.loads(event["body"])
        response= deleteBook(requestBody["id"])
    else:
        response= buildResponse(404,"Page Not Found.")
    return response

# Insert 
def insertBook(requestBody):
    try:
        Books.put_item(Item=requestBody)
        body={
            "Operation": "Save",
            "Message": "Success",
            "Item" : requestBody
        }
        return buildResponse(201,body)
    except:
        logger.exception("Unknow Error!")
        
#Update        
def updateBook(id,updateKey,updateValue):
    try:
        response=Books.update_item(
            Key={
                "id": id
            },
            UpdateExpression="set %s = :value"% updateKey,
            ExpressionAttributeValues = {
                ":value":updateValue
            },
            ReturnValues="UPDATED_NEW"           
        )
        body={
            "Operation":"UPDATED",
            "Message": "SUCCESS",
            "UpdateAttributes":response
        }
        return buildResponse(200,body)
    except:
        logger.exception("Unknow Error!")
#delete
def deleteBook(id):
    try:
        response= Books.delete_item(
            Key={
                "id":id
            },
            ReturnValues="ALL_OLD"
        )
        body={
            "Operation":"DELETE",
            "Message":"SUCCESS",
            "deletedItem":response
        }
        return buildResponse(202,body)
    except:
        logger.exception("Unknow Error!")
# Get once
def getBook(id):
    try:
        response= Books.get_item(
            Key={
                "id":id,
            }
        )
        if "Item" in response:
            return buildResponse(200,response["Item"])
        else:
            return buildResponse(404,{"Message":"id: %s not found."%id})
    except:
        logger.exception("Unknow Error!")
#Get Many
def getBooks():
    try:
        response= Books.scan()
        result=response['Items']
        body={
            tables["Books"]:result
            }
        return buildResponse(200,body)
    except:
        logger.exception("Unknow Error!")

#Response Build 
def buildResponse(statusCode,body=None):
    response = {
        "statusCode":statusCode,
        "headers":{
            "Content-Type": "application/json",
            "Accesss-Control-Allow-Origin": "*"
        }
    }
    if body is not None:
        response["body"]=json.dumps(body,cls=CustomEncoder)
    return response