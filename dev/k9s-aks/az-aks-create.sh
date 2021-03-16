RESOURCE_GROUP='210200-aks'
LOCATION='eastus'
AKS_NAME='aks210200'

az group create -n $RESOURCE_GROUP -l $LOCATION

az aks create --resource-group $RESOURCE_GROUP --name $AKS_NAME \
	--node-count 1 \
	--enable-addons monitoring \
	--generate-ssh-keys

