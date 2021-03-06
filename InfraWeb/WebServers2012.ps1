Configuration WebServers2012
{

  Import-DscResource -ModuleName xComputerManagement

  Node $AllNodes.Where( { $_.Purpose -eq 'Web Server' -and $_.OS -eq '2012' }).NodeName
  {
    xComputer $NodeName
    {
      Name       = $NodeName
      Credential = $(Get-Credential mycompany\winadmin)
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
