<#
PowerShell OneLiners
v1.0

Active Directory Powershell commands
https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617195(v=technet.10)

Exchange Server Powershell commands
https://docs.microsoft.com/en-us/powershell/exchange/exchange-server/exchange-management-shell?view=exchange-ps

Office 365 Powershell
https://docs.microsoft.com/en-us/office365/enterprise/powershell/manage-office-365-with-office-365-powershell

Execution example:
powershell.exe -ExecutionPolicy Bypass -File "C:\MyPowershell.ps1" -server "myserver"

Install-Module ImportExcel
#>

#Parameters/Arguments for the program
param(
    $server = "pc",
    $remoteserver = "server",
    $directory = "C:\Test",
    $opcondir = "C:\Program Files\OpConxps"
)

#Check PowerShell version
if($PSVersionTable.PSVersion.Major -lt 5)
{
    Write-Host "PowerShell Version" $PSVersionTable.PSVersion.Major
    Write-Host "Some examples may not work due to your Powershell Version!"    
}
else
{
    #Write-Host "Powershell version ok!"
}


#File/Directory Examples
#-----------------------
#Test-Path "$directory"                                                                    #Check to see if a path or file exists
#Get-ChildItem "$directory"                                                                #Gets items in a directory, -File or -Directory
#Get-ChildItem "$directory" | Export-Excel "$directory\Files.xlsx" -Show                   #Loads directory/file information to an Excel doc
#Import-Excel "$directory\Files.xlsx" | Where-Object{ $_.Name -like "*Test*" }             #Extracts information from an Excel doc
#Remove-Item "$directory\*"                                                                #Deletes item/s in a directory
#New-Item -ItemType Directory -path "$directory\NewFolder"                                 #Creates a new directory
#"Hello World!`r`nHope you enjoy the webinar." | Out-File "$directory\Test.txt"            #Creates a file with the text
#Get-Content "$directory\Test.txt" | Where-Object {$_ -like "*webinar*"} | Out-File "$directory\Test2.txt"   #Gets information from a file
#Compare-Object (gc "$directory\Test.txt") (gc "$directory\Test2.txt")                     #Compares the contents of 2 files
#Compress-Archive -Path "$directory\*.txt" -DestinationPath "$directory\SMAWebinar.zip"    #Create a zip file
#Expand-Archive -Path "$directory\SMAWebinar.zip" -DestinationPath "$directory" -Force     #Unzip archive file


#Managing/Monitoring resources
#-----------------------------
#Test-Connection -ComputerName $remoteserver -Count 1 -Quiet                                                               #Tests ping to a server/pc
#Test-NetConnection -ComputerName $server -Port 8080 -InformationLevel Detailed                                            #Tests ping and port connection
#(Get-WmiObject Win32_OperatingSystem).Properties | Export-Excel "$directory\OS.xlsx" -Show                                #Gets information about the OS
#[Math]::Round((Get-WmiObject Win32_LogicalDisk -ComputerName $server -Filter "DeviceID='c:'").FreeSpace / 1GB)            #Check free disk space in GB
#(Get-WmiObject Win32_PerfRawData_PerfOS_Memory -ComputerName $server).AvailableMbytes / 1000                              #Check free RAM in GB
#(Get-WmiObject -ComputerName $server Win32_Processor).LoadPercentage                                                      #Check CPU process time
#Get-Service -ComputerName $remoteserver -Name "SMA OpCon JORS for Microsoft"                                              #Checks the status of a service
#sc.exe "\\$remoteserver" "start" (Get-Service -ComputerName $remoteserver -DisplayName "SMA OpCon JORS for Microsoft").Name  #Changes the status of a service
#Get-Process | Where-Object { $_.ProcessName -like "SMA*" }                                                                   #Gets a process
#Invoke-Command -ComputerName $remoteserver -scriptblock {Get-Process | Where-Object { $_.ProcessName -like "SMA*" } }        #Runs a command on a remote machine
#Get-Process | Sort "ProcessName"                                                                                             #Sorts processes by memory usage
#Start-Process "Notepad"                                                                                                      #Starts notepad process
#Stop-Process -Name "Notepad"                                                                                                 #Stops a process


#OpCon Powershell options
#------------------------                        
#Invoke-Expression '& "$opcondir\MSLSAM\smaevalexp.exe" "[[DB]]"'                                                                      #Global Property
#Invoke-Expression '& "$opcondir\MSLSAM\smaevalexp.exe" "[[`$DATEMMDDYYYY (+1eom)]]"'                                                  #Date property for eom
#Invoke-Expression '& "$opcondir\MSLSAM\smaevalexp.exe" "[[TH.DEMO_OPCON]]"'                                                           #Threshold
#Invoke-Expression '& "$opcondir\MSLSAM\smaevalexp.exe" "[[=[[DB]]==\""opconxps\""]]"'                                                 #Check value of a property
#Invoke-Expression '& "$opcondir\MSLSAM\smaevalexp.exe" "[[JI.`$JOB STATUS.CURRENT.SMAUTILITY.SMA DATABASE BACKUP]]"'                  #Job status
#Invoke-Expression '& "$opcondir\MSLSAM\smaevalexp.exe" "[[MI.`$MACHINE OPER STATUS.LOCALHOST]]"'                                      #Agent status


#Event logs
#----------
#Get-EventLog -ComputerName "$remoteserver" -List
#Get-EventLog Application -ComputerName "$remoteserver" -newest 5
#Get-EventLog Application -newest 50 | Where-Object{ $_.Message -like "*SQL Server*" }


#Other
#-----
#Start-Sleep 5                           #Pauses for 5 seconds
#Get-Date -Format "MM/dd/yyyy"           #Gets the current days date in a particular format
#Exit 100                                #Useful for exit codes in OpCon
                                                                                                            