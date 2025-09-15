targetScope = 'resourceGroup'

@description('Prefix för namn, t.ex. "sofia".')
param namePrefix string

@allowed(['dev','test','prod'])
param environment string

param location string
param tags object

// Storage
param storageSku string
param storageKind string

// App Service
param skuName string

// Övriga parametrar (behålls för kompatibilitet med parameterfilerna)
param enableKv bool
param kvName string
param secretName string
@secure()
param secretValue string
param enableAutoscale bool

module stg './modules/storage.bicep' = {
  name: 'storage'
  params: {
    namePrefix: namePrefix
    environment: environment
    location: location
    tags: tags
    storageSku: storageSku
    storageKind: storageKind
  }
}

module appsvc './modules/appservice.bicep' = {
  name: 'appservice'
  params: {
    namePrefix: namePrefix
    environment: environment
    location: location
    tags: tags
    skuName: skuName
  }
}

output webAppUrl string = appsvc.outputs.webAppUrl
