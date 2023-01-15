/*  */
const AWS = require('aws-sdk');
// aws resource region
AWS.config.update({region: 'ap-southeast-1'});
// define dynamodb resources
const dynamodb = new AWS.DynamoDB.DocumentClient();
// define table wit java script object
const tables={
    Inventories:"Inventories"
}

const healthPath='/health';
const productPath='/product';
const productsPath='/products';

exports.handler = async (event) => {
    console.log("Request Event",event);
    if(event.httpMethod === 'GET' && event.path === healthPath){
        const response = buildResponse(200,{"message":"API is working ok!"});
        return response;    
    }
    else if(event.httpMethod === 'GET' && event.path === productPath){
        const response =await getProduct(event.queryStringParameters.id);
        return response;    
    }
    else if(event.httpMethod === 'POST' && event.path === productPath){
        const response = await saveProduct(JSON.parse(event.body));
        return response;    
    }
    else if(event.httpMethod === 'PATCH' && event.path === productPath){
        const requestBody=JSON.parse(event.body);
        const response = await updateProduct(requestBody.id,
                                    requestBody.updateKey,
                                    requestBody.updateValue
                                    );
        return response;    
    }
    else if(event.httpMethod === 'DELETE' && event.path === productPath){
        const response = await deleteProduct(JSON.parse(event.body).id);
        return response;    
    }
    else if (event.httpMethod === 'GET' && event.path === productsPath){
        const response = await getProducts();
        return response;
    }
    else{
      const response = buildResponse(404,{"message":"Error 404 Resource not found."});
      return response;
    }
};

// create
const saveProduct = async (requestBody) =>{
    const params = {
        TableName:tables.Inventories,
        Item:requestBody
    };
    return await dynamodb.put(params).promise()
    .then( () => {
        const body = {
            Operation : 'Save',
            Message : 'Success',
            Item : requestBody
        }
        return buildResponse(200,body);
      },
      (error) => {
        console.error("Save Error",error);
      }
    );
};
// update
const updateProduct = async (id,updateKey,updateValue) =>{
    const params = {
        TableName: tables.Inventories,
        Key:{
            'id':id
        },
        UpdateExpression:`set ${updateKey}= :value`,
        ExpressionAttributeValues:{
            ':value':updateValue
        },
        returnValues:'UPDATE_NEW'
    };
    return await dynamodb.update(params).promise().then(
        (response)=> {
            const body = {
                Operation : 'Update',
                Message : 'Success',
                Item : response
            }
            return buildResponse(200,body);
        },
        (error)=>{
            console.error("Update Error",error); 
        }
    );
};
// delete
const deleteProduct = async (id) =>{
    const params = {
        TableName: tables.Inventories,
        Key:{
            "id":id
        },
        returnValues:'All_OLD'
    };
    return await dynamodb.delete(params).promise().then(
        (response) => {
          const body = {
              Operation : 'Delete',
              Message : 'Success',
              Item : response
          }
          return buildResponse(200,body);
        },
        (error) => {
          console.error("Delete Error",error);
        }  
    );
};
// get
const getProduct = async (id) =>{
    const params = {
        TableName: tables.Inventories,
        Key:{
            "id":id
        }
    };
    return await dynamodb.get(params).promise().then(
        (response) => {
            return buildResponse(200,response.Item);
        },
        (error) => {
            console.error("Read Query Error!",error)
        }
    );
};

// get many

const getProducts = async () =>{
    const params = {
      TableName: tables.Inventories      
  }
  const allProducts = await scanDynamoRecords(params,  []);
  const body = {
      products: allProducts
  }
  return buildResponse(200,body);
};

// scan record
const scanDynamoRecords = async (scanParams,itemArray) =>{
  try {
      const dynamoData = await dynamodb.scan(scanParams).promise();
      itemArray = dynamoData.Items;
      if (dynamoData.LastEvaluateKey){
          scanParams.ExclusiveStartKey = dynamoData.LastEvaluateKey;
          return await scanDynamoRecords(scanParams,itemArray);
      }
      return itemArray;
  } catch(error){
      console.error('You can do your custom error handling here',error);
  }
};

// build response
const buildResponse = (statusCode,body) =>{
    return {
        statusCode,
        headers:{
            "ContentType":"Application/Json"
        },
        body:JSON.stringify(body)
    }
};