break

#region Deploy the web servers
  $location = 'Southeast Asia'
  $resourceGroupName = 'dscLabWeb'
  $resourceDeploymentName = 'dscLabWeb-deployment'
  $templateFile = '.\AzRmTemplates\web.json'
  $templateParameterFile = '.\AzRmTemplates\web.dev.parameters.json'

  # You can use Azure Key Vault to store credentials and retrieve them in parameters.json
  $password = '<replace_w_your_pw>'
  $securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
  $additionalParams = New-Object -TypeName Hashtable
  $additionalParams['vmAdminPassword'] = $securePassword

  New-AzureRmJsonTemplateDeployment `
    -ResourceGroupName $resourceGroupName `
    -DeploymentName $resourceDeploymentName `
    -Location $location `
    -Path $templateFile `
    -TemplateParameterFile $templateParameterFile `
    -Verbose -Force `
    -AdditionalParams $additionalParams

  # Cleanup if needed
  Remove-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Force -Verbose
#endregion
