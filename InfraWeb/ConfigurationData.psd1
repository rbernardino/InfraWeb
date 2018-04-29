@{
  AllNodes = @(
    @{
      NodeName                    = '*'
      PsDscAllowDomainUser        = $true
      PsDscAllowPlainTextPassword = $true
    },
    @{
      NodeName        = 'web02dev'
      Purpose         = 'Web Server'
      OS              = '2008'
    },
    @{
      NodeName        = 'web01dev'
      Purpose         = 'Web Server'
      OS              = '2012'
    })
}
