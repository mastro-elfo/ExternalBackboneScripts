' Start external programs:
CreateObject("Wscript.Shell").Run "ip_sniffer.bat loop", 0, False
CreateObject("Wscript.Shell").Run "disk_quota.bat loop", 0, False
