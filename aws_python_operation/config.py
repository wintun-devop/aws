import os
from dotenv import load_dotenv
#to get to ensure from .env
load_dotenv(override=True)

aws_access_key=os.getenv("AWS_ACCESS_KEY")
aws_secret_key=os.getenv("AWS_SECRET_ACCESS_KEY")
aws_region=os.getenv("AWS_REGION")