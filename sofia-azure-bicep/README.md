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
/docs/   # lägg skärmdumpar här (valfritt)
```

## Körning (Azure Cloud Shell)
> Alla resurser måste ligga i din **personliga** Resource Group i skolans subscription.

```bash
RG="RG-sofiakhoshbin"  # din personliga RG

# Dev
az deployment group create --name app-dev --resource-group "$RG"   --template-file ./src/main.bicep --parameters @./parameters/dev.json   --parameters secretValue=""

# Test
az deployment group create --name app-test --resource-group "$RG"   --template-file ./src/main.bicep --parameters @./parameters/test.json   --parameters secretValue=""

# Prod
az deployment group create --name app-prod --resource-group "$RG"   --template-file ./src/main.bicep --parameters @./parameters/prod.json   --parameters secretValue=""
```

## Hämta Web App URL:er (outputs)
```bash
az deployment group show -g "$RG" -n app-dev  --query "properties.outputs.webAppUrl.value" -o tsv
az deployment group show -g "$RG" -n app-test --query "properties.outputs.webAppUrl.value" -o tsv
az deployment group show -g "$RG" -n app-prod --query "properties.outputs.webAppUrl.value" -o tsv
```

## Bevis (för inlämning)
- Skärmdump av **RG** där 9 resurser syns (3 storage, 3 planer, 3 web apps).
- Skärmdumpar av **dev/test/prod**-webbsidorna (Azure välkomstsida räcker).
- (Gärna) skärmdump av **Deployments → Outputs** där `webAppUrl` syns.

## Push till GitHub
```bash
git init
git add .
git commit -m "Initial commit: Bicep 3 env for Sofia"
git branch -M main
git remote add origin https://github.com/SofiaKho/labb-2-bicep-azure-.git
git push -u origin main
```
