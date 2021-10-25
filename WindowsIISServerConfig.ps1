
<#PSScriptInfo

.VERSION 0.5.0

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

#Requires -Module @{modulename = 'xWebAdministration'; moduleversion = '3.2.0'},@{ModuleName = 'PSDscResources';ModuleVersion = '2.12.0.0'}

<# 

.DESCRIPTION 
 PowerShell Desired State Configuration for deploying and configuring IIS Servers 

#> 

configuration WindowsIISServerConfig
{

Import-DscResource -ModuleName @{ModuleName = 'xWebAdministration';ModuleVersion = '3.2.0'}
Import-DscResource -ModuleName @{ModuleName = 'PSDscResources';ModuleVersion = '2.12.0.0'}

    WindowsFeature WebServer
    {
        Ensure  = 'Present'
        Name    = 'Web-Server'
    }

    xWebSiteDefaults SiteDefaults
    {
        LogFormat               = 'IIS'
        LogDirectory            = 'C:\inetpub\logs\LogFiles'
        TraceLogDirectory       = 'C:\inetpub\logs\FailedReqLogFiles'
        DefaultApplicationPool  = 'DefaultAppPool'
        AllowSubDirConfig       = 'true'
        DependsOn               = '[WindowsFeature]WebServer'
        IsSingleInstance        = 'Yes'
    }

    xWebAppPoolDefaults PoolDefaults
    {
       ManagedRuntimeVersion = 'v4.0'
       IdentityType          = 'ApplicationPoolIdentity'
       DependsOn             = '[WindowsFeature]WebServer'
       IsSingleInstance      = 'Yes'
    }

    File WebContent
    {
        Ensure          = "Present"
        DestinationPath = 'C:\inetpub\wwwroot\default.htm'
        Contents        = @'
<html>
  <body>
    <p>This is a test page.</p>
  </body>
</html>
'@
        DependsOn       = '[xWebSiteDefaults]SiteDefaults'
    }

    xWebsite NewWebsite
    {
        Ensure          = 'Present'
        Name            = 'testSite'
        State           = 'Started'
        PhysicalPath    = 'C:\inetpub\wwwroot\'
        DefaultPage     = 'default.htm'
        DependsOn       = '[File]WebContent'
        BindingInfo     = MSFT_xWebBindingInformation
        {
            Protocol               = 'http'
            Port                   = '80'
            #CertificateStoreName  = 'MY'
            #CertificateThumbprint = 'BB84DE3EC423DDDE90C08AB3C5A828692089493C'
            IPAddress              = '*'
            #SSLFlags              = '1'
        }
    }
}
