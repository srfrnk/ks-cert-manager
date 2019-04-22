local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['ingress-tls-staging'];
{
  apiVersion: 'extensions/v1beta1',
  kind: 'Ingress',
  metadata: {
    annotations: {
      'certmanager.k8s.io/acme-challenge-type': 'http01',
      'certmanager.k8s.io/cluster-issuer': 'letsencrypt-staging',
      'kubernetes.io/ingress.class': 'nginx',
    },
    name: 'ingress-staging',
  },
  spec: {
    rules: [
      {
        host: 'www.my-example.com',
        http: {
          paths: [
            {
              path: '/',
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
          'www.my-example.com',
        ],
        secretName: 'example-secret',
      },
    ],
  },
}
