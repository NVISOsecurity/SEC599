# SEC599 Maintenance script for Kali DTF
# --------------------------------------
# Last update: 30 August 2019
# This script is used for emergency patches / updates in SEC599

# Issue description: A recent Defender update triggers on the following exact commandline combination: "privilege::debug sekurlsa::logonPasswords"
# Solution: Use PowerShell to avoid "privilege::debug" (PowerShell already has debug privilege)

