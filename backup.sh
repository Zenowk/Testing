#!/bin/bash
    
# This bash script is used to backup a user's home directory to /tmp/.
#Script based on 
#https://linuxconfig.org/bash-scripting-tutorial-for-beginners#h17-1-for-loop

function backup {
    
    if [ -z $1 ]; then
        user=$(whoami)
    else 
        if [ ! -d "/home/$1" ]; then
                echo "Requested $1 user home directory doesn't exist."
                exit 1
        fi
        user=$1
    fi 
    
    input=/home/$user
    output=/tmp/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz
    
    #Checks total number of files for a directory
    function total_files {
        find $1 -type f | wc -l
    }
    
    #Checks total number of directories for a directory
    function total_directories {
        find $1 -type d | wc -l
    }
    
    #Returns total number of directories found
    function total_archived_directories {
        tar -tzf $1 | grep  /$ | wc -l
    }
    
    #Returns total number of files found
    function total_archived_files {
        tar -tzf $1 | grep -v /$ | wc -l
    }
    
    tar -czf $output $input 2> /dev/null
    
    src_files=$( total_files $input )
    src_directories=$( total_directories $input )
    
    arch_files=$( total_archived_files $output )
    arch_directories=$( total_archived_directories $output )
    
    #Returns results to user
    echo "########## $user ##########"
    echo "Files to be included: $src_files"
    echo "Directories to be included: $src_directories"
    echo "Files archived: $arch_files"
    echo "Directories archived: $arch_directories"

    #if-else for repsonse to user stating completion or failure
    if [ $src_files -eq $arch_files ]; then
        echo "Backup of $input completed!"
        echo "Details about the output backup file:"
        ls -l $output
    else
        echo "Backup of $input failed!"
    fi
}
 
#for command to backup directories
for directory in $*; do
    backup $directory
done;


