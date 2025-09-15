@description('Prefix för namn, t.ex. "sofia".')
param namePrefix string

@allowed(['dev','test','prod'])
param environment string

param location string
param tags object

@description('App Service SKU, t.ex. B1 för dev/test och S1 för prod.')
param skuName string

var planName = 'plan-${namePrefix}-${environment}-${uniqueString(resourceGroup().id)}'
var webName  = toLower('app-${namePrefix}-${environment}-${uniqueString(resourceGroup().id)}')

resource plan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: planName
  location: location
  tags: tags
  sku: {
    name: skuName
  }
}

resource app 'Microsoft.Web/sites@2023-01-01' = {
  name: webName
  location: location
  tags: tags
  httpsOnly: true
  properties: {
    serverFarmId: plan.id
  }
}

output webAppName string = app.name
output webAppUrl  string = 'https://${app.properties.defaultHostName}'
output serverFarmName string = plan.name
