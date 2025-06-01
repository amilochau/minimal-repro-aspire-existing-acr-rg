@description('The location for the resource(s) to be deployed.')
param location string = resourceGroup().location

param containerRegistryName string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: containerRegistryName
}

output name string = containerRegistryName

output loginServer string = containerRegistry.properties.loginServer