# nexora-authflow-infra-shared

Global and shared infrastructure for AuthFlow.
Provisioned once in the shared subscription using sp-global-shared credentials.

## Layers

| Layer | Description | State Key |
|-------|-------------|-----------|
| global | Front Door, ACR, DNS Zone | authflow/global/global.tfstate |
| shared | VNet, subnets, Log Analytics | authflow/shared/shared.tfstate |

## Deployment Order

```
1. global/
2. shared/   (reads global outputs via remote state)
```

## Credentials

Service Principal: nxr-authflow-sp-global-shared
Subscription: nexora-authflow-shared

## Module Sources

| Module | Source | Latest Version |
|--------|--------|----------------|
| resource-group | `git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/resource-group` | v0.1.3 |
| network | `git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/network` | v0.2.0 |
| subnet | `git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/subnet` | v0.3.1 |
| nsg | `git::https://github.com/nxr-platform/nexora-authflow-terraform-modules.git//modules/nsg` | v0.4.0 |
