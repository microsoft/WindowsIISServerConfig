
<#PSScriptInfo

.VERSION 0.1.0

.GUID a38fa39f-f93d-4cf4-9e08-fa8f880e6187

.AUTHOR Michael Greene

.COMPANYNAME Microsoft

.COPYRIGHT 

.TAGS DSCConfiguration

.LICENSEURI https://github.com/Microsoft/WindowsIISServerConfig/blob/master/LICENSE

.PROJECTURI https://github.com/Microsoft/WindowsIISServerConfig

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES
https://github.com/Microsoft/WindowsIISServerConfig/blob/master/README.md#releasenotes

.PRIVATEDATA 2016-Datacenter-Server-Core

#>

#Requires -Module @{modulename = 'xWebAdministration'; moduleversion = '1.19.0.0'}

<# 

.DESCRIPTION 
 PowerShell Desired State Configuration for deploying and configuring IIS Servers 

#> 

configuration BasicIISServer
{

Import-DscResource -ModuleName @{ModuleName = 'xWebAdministration';ModuleVersion = '1.19.0.0'}

WindowsFeature WebServer
    {
        Ensure  = 'Present'
        Name    = 'WebServer'
    }

    xWebSiteDefaults SiteDefaults
    {
        ApplyTo                 = 'Machine'
        LogFormat               = 'IIS'
        LogDirectory            = 'C:\inetpub\logs\LogFiles'
        TraceLogDirectory       = 'C:\inetpub\logs\FailedReqLogFiles'
        DefaultApplicationPool  = 'DefaultAppPool'
        AllowSubDirConfig       = 'true'
    }
}
