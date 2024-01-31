# Azure Firewall hub-and-spoke demo
## Overview and deployed resources

This template creates an Azure Firewall demonstration setup. The topology consists of a hub VNET with AZFW, two peered spokes with a VM in each, and a VNET simulating an on-premise location connected through S2SVPN. Bastion is deployed in each of the spoke and on-prem VNETs, to connect to the VMs without the need to for public ip's.
The Firewall is configured with rules permitting connectivity between the spoke VMs, and between the spokes and the on-prem VM.

The following resources are part of the solution:

+ **Azure Fiewall**
+ **VNET and VNET peering**: One Hub VNET, two Spoke VNETs peered to the Hub, one On-prem VNET
+ **Virtual Machines**: One in each Spoke and On-prem
+ **Bastion**: One in each Spoke and On-prem
+ **VPN Gateway with S2sVPN**: Between Hub and On-prem

## Deployment 

Click one of the "Deploy to Azure" buttons below or deploy the templates through Powershell or CLI. 

Remember to turn Windows Defender Firewall off manually on all VMs.

### Classic deployment of Firewall Standard
Deploys Standard SKU firewall, with rules implemented on the firewall.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmddazure%2F%2F101-azurefirewall-hub-spoke-demo%2Fmaster%2Fazuredeploy.json)


### Firewall Premium with Firewall Policy
Deploys Premium SKU firewall with Firewall Policy.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmddazure%2F%2F101-azurefirewall-hub-spoke-demo%2Fmaster%2Fazuredeploy.fwmanager.json)

## Network topology

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F101-azurefirewall-hub-spoke-demo%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.png"/>
</a>

![Topology](images/azfwdemo.png)


![Topology](images/topology.png)

## Explore

Log on to spokevm1.

Username:
```
AzureAdmin
```

Password:
```
Azfwdem01234
```

Open a command prompt as administrator, copy and run this script to the VM to generate traffic:
```
powershell -ExecutionPolicy Unrestricted Invoke-WebRequest -Uri https://raw.githubusercontent.com/mddazure/azurefirewall-hub-spoke-demo/master/loop.bat -OutFile 'C:\\Users\\AzureAdmin\\Desktop\\loop.bat'
```
This script:
- continuously accesses the web servers on the other VMs in the lab
- tries to access ipconfig.io with the Blacksun exploit to test IDPS
- accesses a website in the "weapons" category to test URL filtering 
```
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
```

