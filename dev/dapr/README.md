# dev/dapr

```bash
curl -L -o cloud-init.yaml 'https://raw.githubusercontent.com/asw101/2021/main/dev/dapr/cloud-init.yaml'

multipass launch -d 20G -n dapr --cloud-init cloud-init.yaml

multipass shell dapr
```
