targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment that can be used as part of naming resource convention, the name of the resource group for your application will use this name, prefixed with rg-')
param environmentName string

@minLength(1)
@description('The location used for all deployed resources')
param location string

@description('Id of the user or app to assign application roles')
param principalId string = ''

param containerRegistryName string
@metadata({azd: {
  type: 'resourceGroup'
  config: {}
  }
})
param containerRegistryResourceGroupName string

var tags = {
  'azd-env-name': environmentName
}

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${environmentName}'
  location: location
  tags: tags
}

module containerAppEnvironment 'containerAppEnvironment/containerAppEnvironment.module.bicep' = {
  name: 'containerAppEnvironment'
  scope: rg
  params: {
    containerregistry_outputs_name: containerRegistry.outputs.name
    location: location
    userPrincipalId: principalId
  }
}
module containerRegistry 'containerRegistry/containerRegistry.module.bicep' = {
  name: 'containerRegistry'
  scope: resourceGroup(containerRegistryResourceGroupName)
  params: {
    containerRegistryName: containerRegistryName
    location: location
  }
}
