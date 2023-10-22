for /L %%x IN () DO (curl 192.168.1.4 
echo:
curl 192.168.2.4
echo:
curl 172.16.0.4
echo:
echo "this machine's ip address is "
curl -k -A "BlackSun" https://ipconfig.io/ip
echo:
curl -k https://www.colt.com
echo:
timeout /t 5) 