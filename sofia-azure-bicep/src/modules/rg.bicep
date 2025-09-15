targetScope = 'subscription'

@description('Namn på RG som ska skapas.')
param name string

@description('Location för RG.')
param location string

@description('Taggar för RG.')
param tags object

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: name
  location: location
  tags: tags
}

output resourceGroupId string = rg.id
