# Azure-infrastruktur med Bicep (dev/test/prod)
**Namn:** Sofia Kho

## Struktur
```
/src/
  main.bicep
  /modules/
    rg.bicep        # exempel, anropas ej 
    storage.bicep
    appservice.bicep
/parameters/
  dev.json
  test.json
  prod.json
/docs/   # valfritt: lägg skärmdumpar här

```

## Körning (Azure Cloud Shell)
> Alla resurser måste ligga i din **personliga** Resource Group i skolans subscription.

```bash
RG="RG-sofiakhoshbin"  # din personliga RG

# Dev
az deployment group create --name app-dev  --resource-group "$RG" \
  --template-file ./src/main.bicep --parameters @./parameters/dev.json \
  --parameters secretValue=""

# Test
az deployment group create --name app-test --resource-group "$RG" \
  --template-file ./src/main.bicep --parameters @./parameters/test.json \
  --parameters secretValue=""

# Prod
az deployment group create --name app-prod --resource-group "$RG" \
  --template-file ./src/main.bicep --parameters @./parameters/prod.json \
  --parameters secretValue=""

```

## Hämta Web App URL:er (outputs)
```bash
echo "Dev:  $(az deployment group show -g "$RG" -n app-dev  --query "properties.outputs.webAppUrl.value" -o tsv)"
echo "Test: $(az deployment group show -g "$RG" -n app-test --query "properties.outputs.webAppUrl.value" -o tsv)"
echo "Prod: $(az deployment group show -g "$RG" -n app-prod --query "properties.outputs.webAppUrl.value" -o tsv)"

Web App URL:er (mina resultat från deployment)

Dev: https://app-sofia-dev-qkajca6sy4zog.azurewebsites.net

Test: https://app-sofia-test-qkajca6sy4zog.azurewebsites.net

Prod: https://app-sofia-prod-qkajca6sy4zog.azurewebsites.net
```

