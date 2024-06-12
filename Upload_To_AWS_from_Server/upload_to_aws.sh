#!/bin/bash
conda activate aws

#get the top folders:
for foldername in `cat topfolders.txt`; do

#change directory to the downloaded folder to prep it for upload
cd ${foldername}


#looks at all files in the top layer and moves them to a new folder
#called ${foldername}_toplayer in case any of the folders
#have a top layer with thousands of files.

mkdir ${foldername}_top_layer
for file in `ls -p | grep -v '/$'`; do
mv ${file} ${foldername}_top_layer/.
done

#all files in the top layer should now be in subfolders.

#looks at each subfolder to tar that
for subfolder in `ls -d */ | tr -d \\/`; do
#makes one tar file of the folder without zipping it
tar -cf ${subfolder}.tar ${subfolder}

#chat gpt generated code (with edits) to check if the tar creation was successful
# Function to check the tar file integrity
check_tar() {
    local tar_file="$1"

    if tar -tf "$tar_file" > /dev/null; then
        return 0
    else
        return 1
    fi
}

if check_tar "${subfolder}.tar"; then
    echo "Tar file created and verified successfully. Deleting original folder."
    rm -rf ${subfolder}
else
    echo "Tar file creation failed or the tar file is corrupted. Keeping the original folder."
fi

#end of chatgpt code
done

#checks to see if there are any non_tar directories or files left before uploading:
if ls -d */ > /dev/null; then
    echo "didnt work"
    folder_tarred=FALSE
else
    echo "did work"
    folder_tarred=TRUE
fi

#moves back out to upload to the whole folder
cd ../

#moves the folder to hawkinsdrive in aws
if test $folder_tarred == TRUE;
then
echo ${foldername} >> successful_folders.txt
aws s3 mv ${foldername}/ s3://hawkinsdrive/${foldername} --recursive
else
echo ${foldername} >> failed_folders.txt
fi
unset folder_tarred
done
