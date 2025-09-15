@description('Prefix för namn, t.ex. "sofia".')
param namePrefix string

@allowed(['dev','test','prod'])
param environment string

param location string
param tags object

@description('SKU för Storage. Standard_LRS enligt krav.')
param storageSku string

@description('Kind för Storage. StorageV2 enligt krav.')
param storageKind string

var stgName = toLower('${namePrefix}${environment}${uniqueString(subscription().subscriptionId, namePrefix, environment)}')

resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: stgName
  location: location
  tags: tags
  sku: { name: storageSku }
  kind: storageKind
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
  }
}

output storageAccountName string = sa.name
output storageAccountId string = sa.id
