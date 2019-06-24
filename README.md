# KS-CERT-MANAGER

Easy install for cert-manager on K8S (Kubernetes) using KS (Ksonnet) to allow automatic SSL certificate issuing for your HTTPS API servers.

## Quick Setup and Deployment

This shortcut is for people acquainted with K8S.
If you are less comfortable please skip this section and read the rest of the README.

- Connect to your K8S cluster via kubectl
- Run:
``` bash
kubectl apply -f https://raw.githubusercontent.com/srfrnk/ks-cert-manager/master/dist/ks-cert-manager.json
```

## Minikube setup

```bash
minikube start
minikube addons enable ingress
```

```bash
ks env set cluster --server=https://$(minikube ip):8443
```

## GKE setup

Replace `<CLUSTER_EP_IP>` with the cluster Endpoint IP:

```bash
ks env set cluster --server=https://<CLUSTER_EP_IP>
```

### GCE LB

To use the GCE LB the values for `'kubernetes.io/ingress.class': 'nginx',` need to be changed to `'kubernetes.io/ingress.class': 'gce',`

### Static IPs

```bash
gcloud --project=<PROJECT_NAME> compute addresses create <GCE_STATIC_IP_NAME> --global
```

Add to ingress annotations `'kubernetes.io/ingress.global-static-ip-name': '<GCE_STATIC_IP_NAME>',`

## Deploy

```bash
ks apply cluster -c cert-manager
```

```bash
ks apply cluster -c letsencrypt-staging
```

```bash
ks apply cluster -c example-app
```

- Edit the file [ingress-tls-staging](./components/ingress-tls-staging.jsonnet)
- Replace `www.my-example.com` with your own domain (must be setup so DNS can find it).

```bash
ks apply cluster -c ingress-tls-staging
```

Check status:

```bash
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
ks apply cluster -c letsencrypt-prod
```

- Edit the file [ingress-tls-prod](./components/ingress-tls-prod.jsonnet)
- Replace `www.my-example-prod.com` with your own domain (must be setup so DNS can find it).

```bash
ks apply cluster -c ingress-tls-prod
```

**Replace `www.my-example-prod.com` with your own domain**

```bash
kubectl get ingresses.extensions ingress-prod | tail -n 1 | awk '{print $3}' | xargs -I"{}" echo -e '{} www.my-example-prod.com\n' | sudo tee -a /etc/hosts > /dev/null
```

**Replace `www.my-example-prod.com` with your own domain**

```bash
xdg-open https://www.my-example-prod.com
```
