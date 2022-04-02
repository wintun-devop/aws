#transactionId=2&type=rentel&amount=200 (api request sample)
import json

print("Loading Function")
def lambda_handler(event,context):
    #1.Parse out query string
    transactionId = event["queryStringParameters"]["transactionId"]
    transactionType = event["queryStringParameters"]["type"]
    transactionAmount = event["queryStringParameters"]["amount"]
    print(f"Transaction Id:{transactionId}-Transaction Type:{transactionType}-Transaction Amount:{transactionAmount}")
    #2.Body of the response object
    transactionResponse={}
    transactionResponse["transactionId"] = transactionId
    transactionResponse["type"] = transactionType
    transactionResponse["amount"] = transactionAmount
    transactionResponse["message"] = "Hello from lambda!"
    #3.construct the http response object
    responseObject={}
    responseObject["statusCode"] = 200
    responseObject["headers"] = {}
    responseObject["headers"]["Content-Type"] = "application/json"
    responseObject["body"]=json.dumps(transactionResponse)
    #4.Return the response object
    return responseObject