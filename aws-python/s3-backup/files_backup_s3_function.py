'''
#http://mmuak.net
#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)
It should have enough s3 permission to copy files to s3 backup.
'''
import os,datetime,time
#define the current datetime data to make a folder
current_date_time = time.strftime('%m%d%Y-%H%M%S')
#define function with localpath which refers existing desired files to copy and backupname parameters
def backup_files_to_s3(local_path,s3_backup_name):
    copycmd = "aws s3 cp --recursive " + local_path + " s3://" +s3_backup_name+ "/" + current_date_time + "/serverx/"
    print("Backup is processing.....")
    os.system(copycmd)
    print("Files have been copied to {} successfully.".format(s3_backup_name))

backup_files_to_s3("/var/www/html/serverx/","useastfnbackup")
