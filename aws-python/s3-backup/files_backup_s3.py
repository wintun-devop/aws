'''
#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
It should have enough s3 permission to copy files to s3 backup.
'''
import os,datetime,time

#define the current datetime data to make a folder
current_date_time = time.strftime('%m%d%Y-%H%M%S')
#define local path existing desired backup files and declare s3 backup name
local_path="/var/www/html/serverx/"
s3_backup_name="useastfnbackup"
copycmd="aws s3 cp --recursive " + local_path + " s3://" +s3_backup_name+ "/" + current_date_time + "/serverx/"
os.system(copycmd)
print("Files have been copied to {} successfully.".format(s3_backup_name))

