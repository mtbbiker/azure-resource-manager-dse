New-AzureRmResourceGroup -Location "germanynortheast" -Name "TestDataStax-NE"
New-AzureRmResourceGroupDeployment -Name "TestDataStaxDeployment" -ResourceGroupName "TestDataStax-NE" -TemplateFile ".\mainTemplate.json" -TemplateParameterFile ".\mainTemplateParameters.json" -Verbose
