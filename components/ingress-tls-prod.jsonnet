local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['ingress-tls-prod'];
{
  apiVersion: 'extensions/v1beta1',
  kind: 'Ingress',
  metadata: {
    annotations: {
      'certmanager.k8s.io/acme-challenge-type': 'http01',
      'certmanager.k8s.io/cluster-issuer': 'letsencrypt-prod',
      'kubernetes.io/ingress.class': 'nginx',
      // 'kubernetes.io/ingress.class': 'gce',
      'certmanager.k8s.io/acme-http01-edit-in-place': 'true',
    },
    name: 'ingress-prod',
  },
  spec: {
    rules: [
      {
        host: 'www.my-example-prod.com',
        http: {
          paths: [
            {
              // path: '/',
              backend: {
                serviceName: 'example-service',
                servicePort: 80,
              },
            },
          ],
        },
      },
    ],
    tls: [
      {
        hosts: [
          'www.my-example-prod.com',
        ],
        secretName: 'example-secret-prod',
      },
    ],
  },
}
