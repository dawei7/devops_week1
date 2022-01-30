#!/bin/bash

# Instructions:
# In this task you need to create a backup script. The script should accept three parameters:
# the directory to backup; the compression algorithm to use (none, gzip, bzip, etc; see tar for details);the output file name.
# The resulting backup archive should be encrypted (see openssl enc for details).
# All output except errors should be suspended, all errors should be written to the error.log file instead of stderr.


#Positional Shell variables
INPUT=$1
COMPRESSION=$2
OUTPUT=$3

#c – create an archive file.
#x – extract an archive file.
#v – show the progress of the archive file.
#f – filename of the archive file.
#t – viewing the content of the archive file.
#j – filter archive through bzip2.
#z – filter archive through gzip.
#r – append or update files or directories to the existing archive files.
#W – Verify an archive file.
#wildcards – Specify patterns in UNIX tar comman

#Case compression algos
case $COMPRESSION in
  none )
    COMPRESSION_ALGO="cvf"
    OUTPUT+=".tar"
    ;;
  gzip )
    COMPRESSION_ALGO="cvzf"
    OUTPUT+=".tar.gz"
    ;;
  bzip )
    COMPRESSION_ALGO="cvjf"
    OUTPUT+=".tar.bz2"
    ;;
  * )
    echo "Please choose one of the following compression algorithms: none, gzip, bzip"
    ;;
esac

# archive with selected archive method; any errors have output in error.log
tar $COMPRESSION_ALGO $OUTPUT $INPUT 2>> error.log

# Change File name to .enc
ENC_OUTPUT="${OUTPUT}.enc"

# Encription with openssl enc; any errors have output in error.log
openssl enc -salt -aes-256-cbc -in $OUTPUT -out $ENC_OUTPUT 2>> error.log

# Remove compressed and not encrypted output; any errors have output in error.log
rm -d $OUTPUT 2>> error.log


# Test commands
# sh backup_script.sh ./hello_shell_script none hello_shell_script
# sh backup_script.sh ./hello_shell_script gzip hello_shell_script
# sh backup_script.sh ./hello_shell_script bzip hello_shell_script
