local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['letsencrypt-prod'];
{
  apiVersion: 'certmanager.k8s.io/v1alpha1',
  kind: 'ClusterIssuer',
  metadata: {
    name: 'letsencrypt-prod',
  },
  spec: {
    acme: {
      email: 'shahar@dav.network',
      http01: {},
      privateKeySecretRef: {
        name: 'letsencrypt-prod',
      },
      server: 'https://acme-v02.api.letsencrypt.org/directory',
    },
  },
}
