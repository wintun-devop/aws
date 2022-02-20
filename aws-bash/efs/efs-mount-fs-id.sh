#!/bin/bash

#https://github.com/wintun-devop(My github repo)

#https://www.youtube.com/channel/UCz9ebjc-_3t3p49gGpwyAKA (Please subscribe my channel.Thank You!)

#Assign correct efs file system id(Please make sure to correct efs file system id)
efs_file_system_id_1=fs-04367c0f9941c42d9

#Define mount point directory as your desired
efs_mount_point_1=/mnt/efs/fs2

#create mount point directory
mkdir -p "${efs_mount_point_1}"

#mounting efs on your desired mount point
mount -t efs "${efs_file_system_id_1}" "${efs_mount_point_1}"

#checking the efs mounting status
mount | grep -i nfs