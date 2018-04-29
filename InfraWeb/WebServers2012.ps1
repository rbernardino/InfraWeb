Configuration WebServers2012
{

  Import-DscResource -ModuleName xNetworking
  Import-DscResource -ModuleName xComputerManagement

  Node $AllNodes.Where( { $_.Purpose -eq 'Web Server' -and $_.OS -eq '2012' }).NodeName
  {
    xDNSServerAddress 'DNSServerIP'
    {
      Address        = '172.16.1.4'
      AddressFamily  = 'IPv4'
      InterfaceAlias = 'Ethernet 2'
    }

    xComputer $NodeName
    {
      Name       = $NodeName
      Credential = $(Get-Credential mycompany\winadmin)
      DependsOn  = '[xDNSServerAddress]DNSServerIP'
      DomainName = 'mycompany.com'
    }
  }
}

WebServers2012 `
  -ConfigurationData "$PSScriptRoot\ConfigurationData.psd1" `
  -OutputPath "$PSScriptRoot\mofs"

Start-DscConfiguration `
		-Path "$PSScriptRoot\mofs" `
		-Verbose -Wait -Force
