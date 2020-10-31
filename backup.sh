#!/bin/bash
    
# This bash script is used to backup a user's home directory to /tmp/.
#Script based on 
#https://linuxconfig.org/bash-scripting-tutorial-for-beginners#h17-1-for-loop

function backup {
    #This if statement uses the -z bash option to check if the positional parameter
    #$1 contains any value. It returns true if the string $1 is 0. If it is, the $user
    #variable is initialized to the current user's name. The else-if block below checks
    #if the user's home directory exists. The ! negates the effect. So, if the directory
    #doesn't exist, an error message is printed. Then, the exit command is used to cause
    #termination of the script.
    
    #I think that this if and else-if block is interesting in that in bash a -z string
    #is used to return true if the string is null, which is an empty string. I also find
    #the -d and the ! in the else-if to be interesting in that -d is used in bash to check
    #if a user's directory exists and the ! negates the effect.
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
    
    #This if-else checks to see if the number of source files is equal to
    #the number of archived files. If they are, a backup is performed and
    #the directory, date and time are shown. If they are not equal, a message
    #is printed that the backup failed.
    
    #I find the syntax of this if statement to be interesting in that it uses
    #square brackets instead of parentheses, and that -eq is the conditional
    #to say equal to. Also, a semicolon is needed at the end of the if header.
    #All of these things make it different than Java.
    if [ $src_files -eq $arch_files ]; then
        echo "Backup of $input completed!"
        echo "Details about the output backup file:"
        ls -l $output
    else
        echo "Backup of $input failed!"
    fi
}
 
#for command to backup directories

#This for loop performs a backup function for every user directory supplied
#as an argument.

#I find this for loop interesting in that it requires a semicolon at the end
#of the header. This makes it stand out from Java.
for directory in $*; do
    backup $directory
done;


