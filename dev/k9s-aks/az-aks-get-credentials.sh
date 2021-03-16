RESOURCE_GROUP='210200-aks'
LOCATION='eastus'
AKS_NAME='aks210200'

az aks get-credentials -g $RESOURCE_GROUP -n $AKS_NAME

az aks install-cli
