# dev/keda

Have you ever wanted to get dev box up and running for a project in minutes, even if it includes Kubernetes? Try cloud-init and multipass.run!

```bash
curl -L -o cloud-init.yaml 'https://raw.githubusercontent.com/asw101/2021/main/dev/keda/cloud-init.yaml

multipass launch -d 20G -n keda --cloud-init cloud-init.yaml

multipass shell keda
```
