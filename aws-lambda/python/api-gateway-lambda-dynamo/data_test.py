import json
from custom_encoder import CustomEncoder

# Testing Data
"""
def testing(body):
    return body

requestBody = {
"id":"23453222",
"productName":"Product A",
"price":3000    
}

a = testing(requestBody)
b = testing(json.dumps(requestBody,cls=CustomEncoder))

print(a)
print(type(a))
print(b)
print(type(b)) 

"""

# Testing Resources
""" 
tables_1 = ["table1","table2","table3"]

tables_2 = {"table1":"table1","table2":"table2","table3":"table3"}

tables = {
    "Books":"Books"
    }

print(type(tables_1))
print(tables_1[0])
print(type(tables_2))
print(tables_2["table1"])
print(tables["Books"]) 
"""

#Testing Dictionary data type
""" 
testDict = {}
testDict["id"]="234567"
testDict["id"]="234567"
testDict["bookName"]="Mastering Python Second Edition"
 """
def testingDictionary(a):
    testDec={}
    testDec.update(a)
    return testDec

myDict = testingDictionary({"id":"345566","bookName":"Mastering Python","Remark":"Good book"})
print(myDict)
    

    

