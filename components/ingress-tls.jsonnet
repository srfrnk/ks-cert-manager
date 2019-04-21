local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['ingress-tls'];
{
  apiVersion: 'extensions/v1beta1',
  kind: 'Ingress',
  metadata: {
    annotations: {
      'certmanager.k8s.io/acme-challenge-type': 'http01',
      'certmanager.k8s.io/cluster-issuer': 'letsencrypt-staging',
      'kubernetes.io/ingress.class': 'nginx',
    },
    name: 'ingress',
  },
  spec: {
    rules: [
      {
        host: 'www.example.com',
        http: {
          paths: [
            {
              backend: {
                serviceName: 'my-service',
                servicePort: 80,
              },
              path: '/',
            },
          ],
        },
      },
    ],
    tls: [
      {
        hosts: [
          'www.example.com',
        ],
        secretName: 'example-secret',
      },
    ],
  },
}
