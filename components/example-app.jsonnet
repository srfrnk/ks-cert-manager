local k = import 'k.libsonnet';
local env = std.extVar('__ksonnet/environments');
k.core.v1.list.new([
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'example-deployment',
      labels: {
        app: 'example',
      },
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          app: 'example',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'example',
          },
        },
        spec: {
          containers: [
            {
              name: 'example',
              image: 'nginx',
              ports: [
                {
                  containerPort: 80,
                },
              ],
            },
          ],
        },
      },
    },
  },
  {
    kind: 'Service',
    apiVersion: 'v1',
    metadata: {
      name: 'example-service',
    },
    spec: {
      selector: {
        app: 'example',
      },
      ports: [
        {
          protocol: 'TCP',
          port: 80,
          targetPort: 80,
        },
      ],
    },
  },
])
