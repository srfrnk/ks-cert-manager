local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['letsencrypt-staging'];
{
  apiVersion: 'certmanager.k8s.io/v1alpha1',
  kind: 'ClusterIssuer',
  metadata: {
    name: 'letsencrypt-staging',
  },
  spec: {
    acme: {
      email: 'shahar@dav.network',
      http01: {},
      privateKeySecretRef: {
        name: 'letsencrypt-staging',
      },
      server: 'https://acme-staging-v02.api.letsencrypt.org/directory',
      // https://acme-v02.api.letsencrypt.org/directory
    },
  },
}
