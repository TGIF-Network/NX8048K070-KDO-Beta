#!/bin/bash
##############################################################
# create run a script to simulate pressing Apply Changes     #
# in the Pi-Star Dashboard Configuration Page                #
#                                                            #
#                                                            #
# VE3RD                                         2025-03-24   #
##############################################################



#if [ -z "$1" ]; then
#  echo "syntax:   updatepi.sh <pi-star ssid or address> <password> "
#  exit
#fi

# Function to decode a Base64 string
decode_string() {
    local input="$1"
    echo -n "$input" | base64 -d
}



piAddress=$(hostname)

encrypted=$(cat /etc/pspass)

decrypted=$(decode_string "$encrypted")
#echo "$decrypted"

pw="$decrypted"
#echo "$piAddress:$pw"

#curl -X POST http://"$piAddress"/admin/configure.php  -u "pi-star:$pw" -d "action=save" -d "config=1"
curl -X POST http://"$piAddress"/admin/configure.php  -u "pi-star:$pw" -d "action=save" -d "config=1"  &> /dev/null

status=$?

if [ $status -eq 0 ]; then
  echo "Update Script Status = OK"
else
   echo "Update Script Status = Failed"
fi
