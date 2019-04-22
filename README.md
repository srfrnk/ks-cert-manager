# KS-CERT-MANAGER

## Minikube setup

```bash
minikube start
minikube addons enable ingress
```

## Deploy
```bash
ks env set minikube --server=https://$(minikube ip):8443
```

```bash
ks apply minikube -c cert-manager
```

```bash
ks apply minikube -c letsencrypt-staging
```

```bash
ks apply minikube -c example-app
```

 - Edit the file [ingress-tls-staging](./components/ingress-tls-staging.jsonnet)
 - Replace `www.my-example.com` with your own domain (must be setup so DNS can find it).
```bash
ks apply minikube -c ingress-tls-staging
```

Check status:
```
kubectl describe order
kubectl describe challenge
```

Add ingress IP to hosts (**Replace `www.my-example.com` with your own domain**):
```bash
kubectl get ingress ingress | tail -n 1 | awk '{print $3}' | xargs -I"{}" echo -e '{} www.my-example.com\n' | sudo tee -a /etc/hosts > /dev/null
```

Open in browser (**Replace `www.my-example.com` with your own domain**):
```bash
xdg-open https://www.my-example.com
```

## Prod

```bash
ks apply minikube -c letsencrypt-prod
```

 - Edit the file [ingress-tls-prod](./components/ingress-tls-prod.jsonnet)
 - Replace `www.my-example-prod.com` with your own domain (must be setup so DNS can find it).
```bash
ks apply minikube -c ingress-tls-prod
```

**Replace `www.my-example-prod.com` with your own domain**
```bash
kubectl get ingresses.extensions ingress-prod | tail -n 1 | awk '{print $3}' | xargs -I"{}" echo -e '{} www.my-example-prod.com\n' | sudo tee -a /etc/hosts > /dev/null
```

**Replace `www.my-example-prod.com` with your own domain**
```bash
xdg-open https://www.my-example-prod.com
```