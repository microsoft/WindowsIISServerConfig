configuration BasicIISServer
{
    <#
        .DESCRIPTION
        Basic configuration for Windows IIS Server

        .EXAMPLE
        BasicIISServer -outpath c:\dsc\

        .NOTES
        This is the most basic configuration and does not take parameters or configdata
    #>
    
    Node localhost
    {
        # WindowsOptionalFeature is compatible with the Nano Server installation option
        WindowsFeature WebServer
        {
            Ensure  = 'Present'
            Name    = 'WebServer'
        }
    }
}
