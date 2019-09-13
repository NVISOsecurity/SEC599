# SEC599 Maintenance script for Kali DTF
# --------------------------------------
# Last update: 30 August 2019
# This script is used for emergency patches / updates in SEC599

# Issue description: A recent Defender update triggers on the following exact commandline combination: "privilege::debug sekurlsa::logonPasswords"
# Solution: Use PowerShell to avoid "privilege::debug" (PowerShell already has debug privilege)

/usr/bin/wget -O /root/Desktop/CTF/4-movetowin01-INITIAL.sh https://raw.githubusercontent.com/NVISO-BE/SEC599/master/4-movetowin01-INITIAL.sh
/usr/bin/wget -O /root/Desktop/CTF/4-movetowin01-FINAL.sh https://raw.githubusercontent.com/NVISO-BE/SEC599/master/4-movetowin01-FINAL.sh

/usr/bin/wget -O /root/Desktop/CTF/5-movetowin02-INITIAL.sh https://raw.githubusercontent.com/NVISO-BE/SEC599/master/5-movetowin02-INITIAL.sh
/usr/bin/wget -O /root/Desktop/CTF/5-movetowin02-FINAL.sh https://raw.githubusercontent.com/NVISO-BE/SEC599/master/5-movetowin02-FINAL.sh

/usr/bin/wget -O /root/Desktop/CTF/6-movetodc-INITIAL.sh https://raw.githubusercontent.com/NVISO-BE/SEC599/master/4-movetodc-INITIAL.sh
/usr/bin/wget -O /root/Desktop/CTF/6-movetodc-FINAL.sh https://raw.githubusercontent.com/NVISO-BE/SEC599/master/6-movetodc-FINAL.sh
