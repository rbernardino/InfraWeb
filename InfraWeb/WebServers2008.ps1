Configuration WebServers2008
{

  Import-DscResource -ModuleName xComputerManagement

  Node $AllNodes.Where( { $_.Purpose -eq 'Web Server' -and $_.OS -eq '2008' }).NodeName
  {

    xComputer $NodeName
    {
      Name       = $NodeName
      Credential = $(Get-Credential mycompany\winadmin)
      DomainName = 'mycompany.com'
    }
  }
}

WebServers2008 `
  -ConfigurationData "$PSScriptRoot\ConfigurationData.psd1" `
  -OutputPath "$PSScriptRoot\mofs"

Start-DscConfiguration `
		-Path "$PSScriptRoot\mofs" `
		-Verbose -Wait -Force
