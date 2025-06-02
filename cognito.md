### Command
- Register User
```
aws cognito-idp sign-up --region {your-aws-region} --client-id {your-client-id} --username admin@example.com --password password123
```
- Confirm User
```
aws cognito-idp admin-confirm-sign-up --region {your-aws-region} --user-pool-id {your-user-pool-id} --username admin@example.com
```
- Token
```
aws cognito-idp admin-initiate-auth --region {your-aws-region} --cli-input-json file://auth.json
```
### Auth.json
```
{
    "UserPoolId": "{your-user-pool-id}",
    "ClientId": "{your-client-id}",
    "AuthFlow": "ADMIN_NO_SRP_AUTH",
    "AuthParameters": {
        "USERNAME": "admin@example.com",
        "PASSWORD": "password123"
    }
}
```
