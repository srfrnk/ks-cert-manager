local k = import 'k.libsonnet';
local env = std.extVar('__ksonnet/environments');
local params = std.extVar('__ksonnet/params').components['cert-manager'];
k.core.v1.list.new([
  {
    apiVersion: 'apiextensions.k8s.io/v1beta1',
    kind: 'CustomResourceDefinition',
    metadata: {
      creationTimestamp: null,
      labels: {
        'controller-tools.k8s.io': '1.0',
      },
      name: 'certificates.certmanager.k8s.io',
    },
    spec: {
      additionalPrinterColumns: [
        {
          JSONPath: '.status.conditions[?(@.type==\\"Ready\\")].status',
          name: 'Ready',
          type: 'string',
        },
        {
          JSONPath: '.spec.secretName',
          name: 'Secret',
          type: 'string',
        },
        {
          JSONPath: '.spec.issuerRef.name',
          name: 'Issuer',
          priority: 1,
          type: 'string',
        },
        {
          JSONPath: '.status.conditions[?(@.type==\\"Ready\\")].message',
          name: 'Status',
          priority: 1,
          type: 'string',
        },
        {
          JSONPath: '.metadata.creationTimestamp',
          description: 'CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.',
          name: 'Age',
          type: 'date',
        },
      ],
      group: 'certmanager.k8s.io',
      names: {
        kind: 'Certificate',
        plural: 'certificates',
        shortNames: [
          'cert',
          'certs',
        ],
      },
      scope: 'Namespaced',
      validation: {
        openAPIV3Schema: {
          properties: {
            apiVersion: {
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources',
              type: 'string',
            },
            kind: {
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds',
              type: 'string',
            },
            metadata: {
              type: 'object',
            },
            spec: {
              properties: {
                acme: {
                  description: "ACME contains configuration specific to ACME Certificates. Notably, this contains details on how the domain names listed on this Certificate resource should be 'solved', i.e. mapping HTTP01 and DNS01 providers to DNS names.",
                  properties: {
                    config: {
                      items: {
                        properties: {
                          domains: {
                            description: 'Domains is the list of domains that this SolverConfig applies to.',
                            items: {
                              type: 'string',
                            },
                            type: 'array',
                          },
                        },
                        required: [
                          'domains',
                        ],
                        type: 'object',
                      },
                      type: 'array',
                    },
                  },
                  required: [
                    'config',
                  ],
                  type: 'object',
                },
                commonName: {
                  description: 'CommonName is a common name to be used on the Certificate',
                  type: 'string',
                },
                dnsNames: {
                  description: 'DNSNames is a list of subject alt names to be used on the Certificate',
                  items: {
                    type: 'string',
                  },
                  type: 'array',
                },
                duration: {
                  description: 'Certificate default Duration',
                  type: 'string',
                },
                ipAddresses: {
                  description: 'IPAddresses is a list of IP addresses to be used on the Certificate',
                  items: {
                    type: 'string',
                  },
                  type: 'array',
                },
                isCA: {
                  description: "IsCA will mark this Certificate as valid for signing. This implies that the 'signing' usage is set",
                  type: 'boolean',
                },
                issuerRef: {
                  description: "IssuerRef is a reference to the issuer for this certificate. If the 'kind' field is not set, or set to 'Issuer', an Issuer resource with the given name in the same namespace as the Certificate will be used. If the 'kind' field is set to 'ClusterIssuer', a ClusterIssuer with the provided name will be used. The 'name' field in this stanza is required at all times.",
                  properties: {
                    kind: {
                      type: 'string',
                    },
                    name: {
                      type: 'string',
                    },
                  },
                  required: [
                    'name',
                  ],
                  type: 'object',
                },
                keyAlgorithm: {
                  description: 'KeyAlgorithm is the private key algorithm of the corresponding private key for this certificate. If provided, allowed values are either "rsa" or "ecdsa" If KeyAlgorithm is specified and KeySize is not provided, key size of 256 will be used for "ecdsa" key algorithm and key size of 2048 will be used for "rsa" key algorithm.',
                  enum: [
                    'rsa',
                    'ecdsa',
                  ],
                  type: 'string',
                },
                keySize: {
                  description: 'KeySize is the key bit size of the corresponding private key for this certificate. If provided, value must be between 2048 and 8192 inclusive when KeyAlgorithm is empty or is set to "rsa", and value must be one of (256, 384, 521) when KeyAlgorithm is set to "ecdsa".',
                  format: 'int64',
                  type: 'integer',
                },
                organization: {
                  description: 'Organization is the organization to be used on the Certificate',
                  items: {
                    type: 'string',
                  },
                  type: 'array',
                },
                renewBefore: {
                  description: 'Certificate renew before expiration duration',
                  type: 'string',
                },
                secretName: {
                  description: 'SecretName is the name of the secret resource to store this secret in',
                  type: 'string',
                },
              },
              required: [
                'secretName',
                'issuerRef',
              ],
              type: 'object',
            },
            status: {
              properties: {
                conditions: {
                  items: {
                    properties: {
                      lastTransitionTime: {
                        description: 'LastTransitionTime is the timestamp corresponding to the last status change of this condition.',
                        format: 'date-time',
                        type: 'string',
                      },
                      message: {
                        description: 'Message is a human readable description of the details of the last transition, complementing reason.',
                        type: 'string',
                      },
                      reason: {
                        description: "Reason is a brief machine readable explanation for the condition's last transition.",
                        type: 'string',
                      },
                      status: {
                        description: "Status of the condition, one of ('True', 'False', 'Unknown').",
                        enum: [
                          'True',
                          'False',
                          'Unknown',
                        ],
                        type: 'string',
                      },
                      type: {
                        description: "Type of the condition, currently ('Ready').",
                        type: 'string',
                      },
                    },
                    required: [
                      'type',
                      'status',
                      'lastTransitionTime',
                      'reason',
                      'message',
                    ],
                    type: 'object',
                  },
                  type: 'array',
                },
                lastFailureTime: {
                  format: 'date-time',
                  type: 'string',
                },
                notAfter: {
                  description: 'The expiration time of the certificate stored in the secret named by this resource in spec.secretName.',
                  format: 'date-time',
                  type: 'string',
                },
              },
              type: 'object',
            },
          },
        },
      },
      version: 'v1alpha1',
    },
    status: {
      acceptedNames: {
        kind: '',
        plural: '',
      },
      conditions: [],
      storedVersions: [],
    },
  },
  {
    apiVersion: 'apiextensions.k8s.io/v1beta1',
    kind: 'CustomResourceDefinition',
    metadata: {
      creationTimestamp: null,
      labels: {
        'controller-tools.k8s.io': '1.0',
      },
      name: 'challenges.certmanager.k8s.io',
    },
    spec: {
      additionalPrinterColumns: [
        {
          JSONPath: '.status.state',
          name: 'State',
          type: 'string',
        },
        {
          JSONPath: '.spec.dnsName',
          name: 'Domain',
          type: 'string',
        },
        {
          JSONPath: '.status.reason',
          name: 'Reason',
          priority: 1,
          type: 'string',
        },
        {
          JSONPath: '.metadata.creationTimestamp',
          description: 'CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.',
          name: 'Age',
          type: 'date',
        },
      ],
      group: 'certmanager.k8s.io',
      names: {
        kind: 'Challenge',
        plural: 'challenges',
      },
      scope: 'Namespaced',
      validation: {
        openAPIV3Schema: {
          properties: {
            apiVersion: {
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources',
              type: 'string',
            },
            kind: {
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds',
              type: 'string',
            },
            metadata: {
              type: 'object',
            },
            spec: {
              properties: {
                authzURL: {
                  description: 'AuthzURL is the URL to the ACME Authorization resource that this challenge is a part of.',
                  type: 'string',
                },
                config: {
                  description: 'Config specifies the solver configuration for this challenge.',
                  type: 'object',
                },
                dnsName: {
                  description: 'DNSName is the identifier that this challenge is for, e.g. example.com.',
                  type: 'string',
                },
                issuerRef: {
                  description: "IssuerRef references a properly configured ACME-type Issuer which should be used to create this Challenge. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Challenge will be marked as failed.",
                  properties: {
                    kind: {
                      type: 'string',
                    },
                    name: {
                      type: 'string',
                    },
                  },
                  required: [
                    'name',
                  ],
                  type: 'object',
                },
                key: {
                  description: 'Key is the ACME challenge key for this challenge',
                  type: 'string',
                },
                token: {
                  description: 'Token is the ACME challenge token for this challenge.',
                  type: 'string',
                },
                type: {
                  description: 'Type is the type of ACME challenge this resource represents, e.g. "dns01" or "http01"',
                  type: 'string',
                },
                url: {
                  description: 'URL is the URL of the ACME Challenge resource for this challenge. This can be used to lookup details about the status of this challenge.',
                  type: 'string',
                },
                wildcard: {
                  description: "Wildcard will be true if this challenge is for a wildcard identifier, for example '*.example.com'",
                  type: 'boolean',
                },
              },
              required: [
                'authzURL',
                'type',
                'url',
                'dnsName',
                'token',
                'key',
                'wildcard',
                'config',
                'issuerRef',
              ],
              type: 'object',
            },
            status: {
              properties: {
                presented: {
                  description: "Presented will be set to true if the challenge values for this challenge are currently 'presented'. This *does not* imply the self check is passing. Only that the values have been 'submitted' for the appropriate challenge mechanism (i.e. the DNS01 TXT record has been presented, or the HTTP01 configuration has been configured).",
                  type: 'boolean',
                },
                processing: {
                  description: "Processing is used to denote whether this challenge should be processed or not. This field will only be set to true by the 'scheduling' component. It will only be set to false by the 'challenges' controller, after the challenge has reached a final state or timed out. If this field is set to false, the challenge controller will not take any more action.",
                  type: 'boolean',
                },
                reason: {
                  description: 'Reason contains human readable information on why the Challenge is in the current state.',
                  type: 'string',
                },
                state: {
                  description: "State contains the current 'state' of the challenge. If not set, the state of the challenge is unknown.",
                  enum: [
                    '',
                    'valid',
                    'ready',
                    'pending',
                    'processing',
                    'invalid',
                    'expired',
                    'errored',
                  ],
                  type: 'string',
                },
              },
              required: [
                'processing',
                'presented',
                'reason',
              ],
              type: 'object',
            },
          },
          required: [
            'metadata',
            'spec',
            'status',
          ],
        },
      },
      version: 'v1alpha1',
    },
    status: {
      acceptedNames: {
        kind: '',
        plural: '',
      },
      conditions: [],
      storedVersions: [],
    },
  },
  {
    apiVersion: 'apiextensions.k8s.io/v1beta1',
    kind: 'CustomResourceDefinition',
    metadata: {
      creationTimestamp: null,
      labels: {
        'controller-tools.k8s.io': '1.0',
      },
      name: 'clusterissuers.certmanager.k8s.io',
    },
    spec: {
      group: 'certmanager.k8s.io',
      names: {
        kind: 'ClusterIssuer',
        plural: 'clusterissuers',
      },
      scope: 'Cluster',
      validation: {
        openAPIV3Schema: {
          properties: {
            apiVersion: {
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources',
              type: 'string',
            },
            kind: {
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds',
              type: 'string',
            },
            metadata: {
              type: 'object',
            },
            spec: {
              properties: {
                acme: {
                  properties: {
                    email: {
                      description: 'Email is the email for this account',
                      type: 'string',
                    },
                    privateKeySecretRef: {
                      description: 'PrivateKey is the name of a secret containing the private key for this user account.',
                      properties: {
                        key: {
                          description: 'The key of the secret to select from. Must be a valid secret key.',
                          type: 'string',
                        },
                        name: {
                          description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                          type: 'string',
                        },
                      },
                      required: [
                        'name',
                      ],
                      type: 'object',
                    },
                    server: {
                      description: 'Server is the ACME server URL',
                      type: 'string',
                    },
                    skipTLSVerify: {
                      description: 'If true, skip verifying the ACME server TLS certificate',
                      type: 'boolean',
                    },
                  },
                  required: [
                    'email',
                    'server',
                    'privateKeySecretRef',
                  ],
                  type: 'object',
                },
                ca: {
                  properties: {
                    secretName: {
                      description: 'SecretName is the name of the secret used to sign Certificates issued by this Issuer.',
                      type: 'string',
                    },
                  },
                  required: [
                    'secretName',
                  ],
                  type: 'object',
                },
                selfSigned: {
                  type: 'object',
                },
                vault: {
                  properties: {
                    auth: {
                      description: 'Vault authentication',
                      properties: {
                        appRole: {
                          description: 'This Secret contains a AppRole and Secret',
                          properties: {
                            path: {
                              description: 'Where the authentication path is mounted in Vault.',
                              type: 'string',
                            },
                            roleId: {
                              type: 'string',
                            },
                            secretRef: {
                              properties: {
                                key: {
                                  description: 'The key of the secret to select from. Must be a valid secret key.',
                                  type: 'string',
                                },
                                name: {
                                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                                  type: 'string',
                                },
                              },
                              required: [
                                'name',
                              ],
                              type: 'object',
                            },
                          },
                          required: [
                            'path',
                            'roleId',
                            'secretRef',
                          ],
                          type: 'object',
                        },
                        tokenSecretRef: {
                          description: 'This Secret contains the Vault token key',
                          properties: {
                            key: {
                              description: 'The key of the secret to select from. Must be a valid secret key.',
                              type: 'string',
                            },
                            name: {
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                              type: 'string',
                            },
                          },
                          required: [
                            'name',
                          ],
                          type: 'object',
                        },
                      },
                      type: 'object',
                    },
                    caBundle: {
                      description: 'Base64 encoded CA bundle to validate Vault server certificate. Only used if the Server URL is using HTTPS protocol. This parameter is ignored for plain HTTP protocol connection. If not set the system root certificates are used to validate the TLS connection.',
                      format: 'byte',
                      type: 'string',
                    },
                    path: {
                      description: 'Vault URL path to the certificate role',
                      type: 'string',
                    },
                    server: {
                      description: 'Server is the vault connection address',
                      type: 'string',
                    },
                  },
                  required: [
                    'auth',
                    'server',
                    'path',
                  ],
                  type: 'object',
                },
                venafi: {
                  properties: {
                    cloud: {
                      description: 'Cloud specifies the Venafi cloud configuration settings. Only one of TPP or Cloud may be specified.',
                      properties: {
                        apiTokenSecretRef: {
                          description: 'APITokenSecretRef is a secret key selector for the Venafi Cloud API token.',
                          properties: {
                            key: {
                              description: 'The key of the secret to select from. Must be a valid secret key.',
                              type: 'string',
                            },
                            name: {
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                              type: 'string',
                            },
                          },
                          required: [
                            'name',
                          ],
                          type: 'object',
                        },
                        url: {
                          description: 'URL is the base URL for Venafi Cloud',
                          type: 'string',
                        },
                      },
                      required: [
                        'url',
                        'apiTokenSecretRef',
                      ],
                      type: 'object',
                    },
                    tpp: {
                      description: 'TPP specifies Trust Protection Platform configuration settings. Only one of TPP or Cloud may be specified.',
                      properties: {
                        caBundle: {
                          description: 'CABundle is a PEM encoded TLS certifiate to use to verify connections to the TPP instance. If specified, system roots will not be used and the issuing CA for the TPP instance must be verifiable using the provided root. If not specified, the connection will be verified using the cert-manager system root certificates.',
                          format: 'byte',
                          type: 'string',
                        },
                        credentialsRef: {
                          description: "CredentialsRef is a reference to a Secret containing the username and password for the TPP server. The secret must contain two keys, 'username' and 'password'.",
                          properties: {
                            name: {
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                              type: 'string',
                            },
                          },
                          required: [
                            'name',
                          ],
                          type: 'object',
                        },
                        url: {
                          description: 'URL is the base URL for the Venafi TPP instance',
                          type: 'string',
                        },
                      },
                      required: [
                        'url',
                        'credentialsRef',
                      ],
                      type: 'object',
                    },
                    zone: {
                      description: 'Zone is the Venafi Policy Zone to use for this issuer. All requests made to the Venafi platform will be restricted by the named zone policy. This field is required.',
                      type: 'string',
                    },
                  },
                  required: [
                    'zone',
                  ],
                  type: 'object',
                },
              },
              type: 'object',
            },
            status: {
              properties: {
                acme: {
                  properties: {
                    uri: {
                      description: 'URI is the unique account identifier, which can also be used to retrieve account details from the CA',
                      type: 'string',
                    },
                  },
                  type: 'object',
                },
                conditions: {
                  items: {
                    properties: {
                      lastTransitionTime: {
                        description: 'LastTransitionTime is the timestamp corresponding to the last status change of this condition.',
                        format: 'date-time',
                        type: 'string',
                      },
                      message: {
                        description: 'Message is a human readable description of the details of the last transition, complementing reason.',
                        type: 'string',
                      },
                      reason: {
                        description: "Reason is a brief machine readable explanation for the condition's last transition.",
                        type: 'string',
                      },
                      status: {
                        description: "Status of the condition, one of ('True', 'False', 'Unknown').",
                        enum: [
                          'True',
                          'False',
                          'Unknown',
                        ],
                        type: 'string',
                      },
                      type: {
                        description: "Type of the condition, currently ('Ready').",
                        type: 'string',
                      },
                    },
                    required: [
                      'type',
                      'status',
                      'lastTransitionTime',
                      'reason',
                      'message',
                    ],
                    type: 'object',
                  },
                  type: 'array',
                },
              },
              type: 'object',
            },
          },
        },
      },
      version: 'v1alpha1',
    },
    status: {
      acceptedNames: {
        kind: '',
        plural: '',
      },
      conditions: [],
      storedVersions: [],
    },
  },
  {
    apiVersion: 'apiextensions.k8s.io/v1beta1',
    kind: 'CustomResourceDefinition',
    metadata: {
      creationTimestamp: null,
      labels: {
        'controller-tools.k8s.io': '1.0',
      },
      name: 'issuers.certmanager.k8s.io',
    },
    spec: {
      group: 'certmanager.k8s.io',
      names: {
        kind: 'Issuer',
        plural: 'issuers',
      },
      scope: 'Namespaced',
      validation: {
        openAPIV3Schema: {
          properties: {
            apiVersion: {
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources',
              type: 'string',
            },
            kind: {
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds',
              type: 'string',
            },
            metadata: {
              type: 'object',
            },
            spec: {
              properties: {
                acme: {
                  properties: {
                    email: {
                      description: 'Email is the email for this account',
                      type: 'string',
                    },
                    privateKeySecretRef: {
                      description: 'PrivateKey is the name of a secret containing the private key for this user account.',
                      properties: {
                        key: {
                          description: 'The key of the secret to select from. Must be a valid secret key.',
                          type: 'string',
                        },
                        name: {
                          description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                          type: 'string',
                        },
                      },
                      required: [
                        'name',
                      ],
                      type: 'object',
                    },
                    server: {
                      description: 'Server is the ACME server URL',
                      type: 'string',
                    },
                    skipTLSVerify: {
                      description: 'If true, skip verifying the ACME server TLS certificate',
                      type: 'boolean',
                    },
                  },
                  required: [
                    'email',
                    'server',
                    'privateKeySecretRef',
                  ],
                  type: 'object',
                },
                ca: {
                  properties: {
                    secretName: {
                      description: 'SecretName is the name of the secret used to sign Certificates issued by this Issuer.',
                      type: 'string',
                    },
                  },
                  required: [
                    'secretName',
                  ],
                  type: 'object',
                },
                selfSigned: {
                  type: 'object',
                },
                vault: {
                  properties: {
                    auth: {
                      description: 'Vault authentication',
                      properties: {
                        appRole: {
                          description: 'This Secret contains a AppRole and Secret',
                          properties: {
                            path: {
                              description: 'Where the authentication path is mounted in Vault.',
                              type: 'string',
                            },
                            roleId: {
                              type: 'string',
                            },
                            secretRef: {
                              properties: {
                                key: {
                                  description: 'The key of the secret to select from. Must be a valid secret key.',
                                  type: 'string',
                                },
                                name: {
                                  description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                                  type: 'string',
                                },
                              },
                              required: [
                                'name',
                              ],
                              type: 'object',
                            },
                          },
                          required: [
                            'path',
                            'roleId',
                            'secretRef',
                          ],
                          type: 'object',
                        },
                        tokenSecretRef: {
                          description: 'This Secret contains the Vault token key',
                          properties: {
                            key: {
                              description: 'The key of the secret to select from. Must be a valid secret key.',
                              type: 'string',
                            },
                            name: {
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                              type: 'string',
                            },
                          },
                          required: [
                            'name',
                          ],
                          type: 'object',
                        },
                      },
                      type: 'object',
                    },
                    caBundle: {
                      description: 'Base64 encoded CA bundle to validate Vault server certificate. Only used if the Server URL is using HTTPS protocol. This parameter is ignored for plain HTTP protocol connection. If not set the system root certificates are used to validate the TLS connection.',
                      format: 'byte',
                      type: 'string',
                    },
                    path: {
                      description: 'Vault URL path to the certificate role',
                      type: 'string',
                    },
                    server: {
                      description: 'Server is the vault connection address',
                      type: 'string',
                    },
                  },
                  required: [
                    'auth',
                    'server',
                    'path',
                  ],
                  type: 'object',
                },
                venafi: {
                  properties: {
                    cloud: {
                      description: 'Cloud specifies the Venafi cloud configuration settings. Only one of TPP or Cloud may be specified.',
                      properties: {
                        apiTokenSecretRef: {
                          description: 'APITokenSecretRef is a secret key selector for the Venafi Cloud API token.',
                          properties: {
                            key: {
                              description: 'The key of the secret to select from. Must be a valid secret key.',
                              type: 'string',
                            },
                            name: {
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                              type: 'string',
                            },
                          },
                          required: [
                            'name',
                          ],
                          type: 'object',
                        },
                        url: {
                          description: 'URL is the base URL for Venafi Cloud',
                          type: 'string',
                        },
                      },
                      required: [
                        'url',
                        'apiTokenSecretRef',
                      ],
                      type: 'object',
                    },
                    tpp: {
                      description: 'TPP specifies Trust Protection Platform configuration settings. Only one of TPP or Cloud may be specified.',
                      properties: {
                        caBundle: {
                          description: 'CABundle is a PEM encoded TLS certifiate to use to verify connections to the TPP instance. If specified, system roots will not be used and the issuing CA for the TPP instance must be verifiable using the provided root. If not specified, the connection will be verified using the cert-manager system root certificates.',
                          format: 'byte',
                          type: 'string',
                        },
                        credentialsRef: {
                          description: "CredentialsRef is a reference to a Secret containing the username and password for the TPP server. The secret must contain two keys, 'username' and 'password'.",
                          properties: {
                            name: {
                              description: 'Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?',
                              type: 'string',
                            },
                          },
                          required: [
                            'name',
                          ],
                          type: 'object',
                        },
                        url: {
                          description: 'URL is the base URL for the Venafi TPP instance',
                          type: 'string',
                        },
                      },
                      required: [
                        'url',
                        'credentialsRef',
                      ],
                      type: 'object',
                    },
                    zone: {
                      description: 'Zone is the Venafi Policy Zone to use for this issuer. All requests made to the Venafi platform will be restricted by the named zone policy. This field is required.',
                      type: 'string',
                    },
                  },
                  required: [
                    'zone',
                  ],
                  type: 'object',
                },
              },
              type: 'object',
            },
            status: {
              properties: {
                acme: {
                  properties: {
                    uri: {
                      description: 'URI is the unique account identifier, which can also be used to retrieve account details from the CA',
                      type: 'string',
                    },
                  },
                  type: 'object',
                },
                conditions: {
                  items: {
                    properties: {
                      lastTransitionTime: {
                        description: 'LastTransitionTime is the timestamp corresponding to the last status change of this condition.',
                        format: 'date-time',
                        type: 'string',
                      },
                      message: {
                        description: 'Message is a human readable description of the details of the last transition, complementing reason.',
                        type: 'string',
                      },
                      reason: {
                        description: "Reason is a brief machine readable explanation for the condition's last transition.",
                        type: 'string',
                      },
                      status: {
                        description: "Status of the condition, one of ('True', 'False', 'Unknown').",
                        enum: [
                          'True',
                          'False',
                          'Unknown',
                        ],
                        type: 'string',
                      },
                      type: {
                        description: "Type of the condition, currently ('Ready').",
                        type: 'string',
                      },
                    },
                    required: [
                      'type',
                      'status',
                      'lastTransitionTime',
                      'reason',
                      'message',
                    ],
                    type: 'object',
                  },
                  type: 'array',
                },
              },
              type: 'object',
            },
          },
        },
      },
      version: 'v1alpha1',
    },
    status: {
      acceptedNames: {
        kind: '',
        plural: '',
      },
      conditions: [],
      storedVersions: [],
    },
  },
  {
    apiVersion: 'apiextensions.k8s.io/v1beta1',
    kind: 'CustomResourceDefinition',
    metadata: {
      creationTimestamp: null,
      labels: {
        'controller-tools.k8s.io': '1.0',
      },
      name: 'orders.certmanager.k8s.io',
    },
    spec: {
      additionalPrinterColumns: [
        {
          JSONPath: '.status.state',
          name: 'State',
          type: 'string',
        },
        {
          JSONPath: '.spec.issuerRef.name',
          name: 'Issuer',
          priority: 1,
          type: 'string',
        },
        {
          JSONPath: '.status.reason',
          name: 'Reason',
          priority: 1,
          type: 'string',
        },
        {
          JSONPath: '.metadata.creationTimestamp',
          description: 'CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.',
          name: 'Age',
          type: 'date',
        },
      ],
      group: 'certmanager.k8s.io',
      names: {
        kind: 'Order',
        plural: 'orders',
      },
      scope: 'Namespaced',
      validation: {
        openAPIV3Schema: {
          properties: {
            apiVersion: {
              description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#resources',
              type: 'string',
            },
            kind: {
              description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/api-conventions.md#types-kinds',
              type: 'string',
            },
            metadata: {
              type: 'object',
            },
            spec: {
              properties: {
                commonName: {
                  description: 'CommonName is the common name as specified on the DER encoded CSR. If CommonName is not specified, the first DNSName specified will be used as the CommonName. At least one of CommonName or a DNSNames must be set. This field must match the corresponding field on the DER encoded CSR.',
                  type: 'string',
                },
                config: {
                  description: 'Config specifies a mapping from DNS identifiers to how those identifiers should be solved when performing ACME challenges. A config entry must exist for each domain listed in DNSNames and CommonName.',
                  items: {
                    properties: {
                      domains: {
                        description: 'Domains is the list of domains that this SolverConfig applies to.',
                        items: {
                          type: 'string',
                        },
                        type: 'array',
                      },
                    },
                    required: [
                      'domains',
                    ],
                    type: 'object',
                  },
                  type: 'array',
                },
                csr: {
                  description: 'Certificate signing request bytes in DER encoding. This will be used when finalizing the order. This field must be set on the order.',
                  format: 'byte',
                  type: 'string',
                },
                dnsNames: {
                  description: 'DNSNames is a list of DNS names that should be included as part of the Order validation process. If CommonName is not specified, the first DNSName specified will be used as the CommonName. At least one of CommonName or a DNSNames must be set. This field must match the corresponding field on the DER encoded CSR.',
                  items: {
                    type: 'string',
                  },
                  type: 'array',
                },
                issuerRef: {
                  description: "IssuerRef references a properly configured ACME-type Issuer which should be used to create this Order. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Order will be marked as failed.",
                  properties: {
                    kind: {
                      type: 'string',
                    },
                    name: {
                      type: 'string',
                    },
                  },
                  required: [
                    'name',
                  ],
                  type: 'object',
                },
              },
              required: [
                'csr',
                'issuerRef',
                'config',
              ],
              type: 'object',
            },
            status: {
              properties: {
                certificate: {
                  description: "Certificate is a copy of the PEM encoded certificate for this Order. This field will be populated after the order has been successfully finalized with the ACME server, and the order has transitioned to the 'valid' state.",
                  format: 'byte',
                  type: 'string',
                },
                challenges: {
                  description: 'Challenges is a list of ChallengeSpecs for Challenges that must be created in order to complete this Order.',
                  items: {
                    properties: {
                      authzURL: {
                        description: 'AuthzURL is the URL to the ACME Authorization resource that this challenge is a part of.',
                        type: 'string',
                      },
                      config: {
                        description: 'Config specifies the solver configuration for this challenge.',
                        type: 'object',
                      },
                      dnsName: {
                        description: 'DNSName is the identifier that this challenge is for, e.g. example.com.',
                        type: 'string',
                      },
                      issuerRef: {
                        description: "IssuerRef references a properly configured ACME-type Issuer which should be used to create this Challenge. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Challenge will be marked as failed.",
                        properties: {
                          kind: {
                            type: 'string',
                          },
                          name: {
                            type: 'string',
                          },
                        },
                        required: [
                          'name',
                        ],
                        type: 'object',
                      },
                      key: {
                        description: 'Key is the ACME challenge key for this challenge',
                        type: 'string',
                      },
                      token: {
                        description: 'Token is the ACME challenge token for this challenge.',
                        type: 'string',
                      },
                      type: {
                        description: 'Type is the type of ACME challenge this resource represents, e.g. "dns01" or "http01"',
                        type: 'string',
                      },
                      url: {
                        description: 'URL is the URL of the ACME Challenge resource for this challenge. This can be used to lookup details about the status of this challenge.',
                        type: 'string',
                      },
                      wildcard: {
                        description: "Wildcard will be true if this challenge is for a wildcard identifier, for example '*.example.com'",
                        type: 'boolean',
                      },
                    },
                    required: [
                      'authzURL',
                      'type',
                      'url',
                      'dnsName',
                      'token',
                      'key',
                      'wildcard',
                      'config',
                      'issuerRef',
                    ],
                    type: 'object',
                  },
                  type: 'array',
                },
                failureTime: {
                  description: 'FailureTime stores the time that this order failed. This is used to influence garbage collection and back-off.',
                  format: 'date-time',
                  type: 'string',
                },
                finalizeURL: {
                  description: 'FinalizeURL of the Order. This is used to obtain certificates for this order once it has been completed.',
                  type: 'string',
                },
                reason: {
                  description: 'Reason optionally provides more information about a why the order is in the current state.',
                  type: 'string',
                },
                state: {
                  description: "State contains the current state of this Order resource. States 'success' and 'expired' are 'final'",
                  enum: [
                    '',
                    'valid',
                    'ready',
                    'pending',
                    'processing',
                    'invalid',
                    'expired',
                    'errored',
                  ],
                  type: 'string',
                },
                url: {
                  description: 'URL of the Order. This will initially be empty when the resource is first created. The Order controller will populate this field when the Order is first processed. This field will be immutable after it is initially set.',
                  type: 'string',
                },
              },
              type: 'object',
            },
          },
          required: [
            'metadata',
            'spec',
            'status',
          ],
        },
      },
      version: 'v1alpha1',
    },
    status: {
      acceptedNames: {
        kind: '',
        plural: '',
      },
      conditions: [],
      storedVersions: [],
    },
  },
  {
    apiVersion: 'v1',
    kind: 'Namespace',
    metadata: {
      labels: {
        'certmanager.k8s.io/disable-validation': 'true',
      },
      name: 'cert-manager',
    },
  },
  {
    apiVersion: 'v1',
    kind: 'ServiceAccount',
    metadata: {
      labels: {
        app: 'cainjector',
        chart: 'cainjector-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-cainjector',
      namespace: 'cert-manager',
    },
  },
  {
    apiVersion: 'v1',
    kind: 'ServiceAccount',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook',
      namespace: 'cert-manager',
    },
  },
  {
    apiVersion: 'v1',
    kind: 'ServiceAccount',
    metadata: {
      labels: {
        app: 'cert-manager',
        chart: 'cert-manager-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager',
      namespace: 'cert-manager',
    },
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1beta1',
    kind: 'ClusterRole',
    metadata: {
      labels: {
        app: 'cainjector',
        chart: 'cainjector-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-cainjector',
    },
    rules: [
      {
        apiGroups: [
          'certmanager.k8s.io',
        ],
        resources: [
          'certificates',
        ],
        verbs: [
          'get',
          'list',
          'watch',
        ],
      },
      {
        apiGroups: [
          '',
        ],
        resources: [
          'secrets',
        ],
        verbs: [
          'get',
          'list',
          'watch',
        ],
      },
      {
        apiGroups: [
          '',
        ],
        resources: [
          'configmaps',
          'events',
        ],
        verbs: [
          '*',
        ],
      },
      {
        apiGroups: [
          'admissionregistration.k8s.io',
        ],
        resources: [
          'validatingwebhookconfigurations',
          'mutatingwebhookconfigurations',
        ],
        verbs: [
          '*',
        ],
      },
      {
        apiGroups: [
          'apiregistration.k8s.io',
        ],
        resources: [
          'apiservices',
        ],
        verbs: [
          '*',
        ],
      },
    ],
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1beta1',
    kind: 'ClusterRoleBinding',
    metadata: {
      labels: {
        app: 'cainjector',
        chart: 'cainjector-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-cainjector',
    },
    roleRef: {
      apiGroup: 'rbac.authorization.k8s.io',
      kind: 'ClusterRole',
      name: 'cert-manager-cainjector',
    },
    subjects: [
      {
        kind: 'ServiceAccount',
        name: 'cert-manager-cainjector',
        namespace: 'cert-manager',
      },
    ],
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1beta1',
    kind: 'ClusterRole',
    metadata: {
      labels: {
        app: 'cert-manager',
        chart: 'cert-manager-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager',
    },
    rules: [
      {
        apiGroups: [
          'certmanager.k8s.io',
        ],
        resources: [
          'certificates',
          'certificates/finalizers',
          'issuers',
          'clusterissuers',
          'orders',
          'orders/finalizers',
          'challenges',
        ],
        verbs: [
          '*',
        ],
      },
      {
        apiGroups: [
          '',
        ],
        resources: [
          'configmaps',
          'secrets',
          'events',
          'services',
          'pods',
        ],
        verbs: [
          '*',
        ],
      },
      {
        apiGroups: [
          'extensions',
        ],
        resources: [
          'ingresses',
        ],
        verbs: [
          '*',
        ],
      },
    ],
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1beta1',
    kind: 'ClusterRoleBinding',
    metadata: {
      labels: {
        app: 'cert-manager',
        chart: 'cert-manager-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager',
    },
    roleRef: {
      apiGroup: 'rbac.authorization.k8s.io',
      kind: 'ClusterRole',
      name: 'cert-manager',
    },
    subjects: [
      {
        kind: 'ServiceAccount',
        name: 'cert-manager',
        namespace: 'cert-manager',
      },
    ],
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1',
    kind: 'ClusterRole',
    metadata: {
      labels: {
        app: 'cert-manager',
        chart: 'cert-manager-v0.7.0',
        heritage: 'Tiller',
        'rbac.authorization.k8s.io/aggregate-to-admin': 'true',
        'rbac.authorization.k8s.io/aggregate-to-edit': 'true',
        'rbac.authorization.k8s.io/aggregate-to-view': 'true',
        release: 'cert-manager',
      },
      name: 'cert-manager-view',
    },
    rules: [
      {
        apiGroups: [
          'certmanager.k8s.io',
        ],
        resources: [
          'certificates',
          'issuers',
        ],
        verbs: [
          'get',
          'list',
          'watch',
        ],
      },
    ],
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1',
    kind: 'ClusterRole',
    metadata: {
      labels: {
        app: 'cert-manager',
        chart: 'cert-manager-v0.7.0',
        heritage: 'Tiller',
        'rbac.authorization.k8s.io/aggregate-to-admin': 'true',
        'rbac.authorization.k8s.io/aggregate-to-edit': 'true',
        release: 'cert-manager',
      },
      name: 'cert-manager-edit',
    },
    rules: [
      {
        apiGroups: [
          'certmanager.k8s.io',
        ],
        resources: [
          'certificates',
          'issuers',
        ],
        verbs: [
          'create',
          'delete',
          'deletecollection',
          'patch',
          'update',
        ],
      },
    ],
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1beta1',
    kind: 'ClusterRoleBinding',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook:auth-delegator',
    },
    roleRef: {
      apiGroup: 'rbac.authorization.k8s.io',
      kind: 'ClusterRole',
      name: 'system:auth-delegator',
    },
    subjects: [
      {
        apiGroup: '',
        kind: 'ServiceAccount',
        name: 'cert-manager-webhook',
        namespace: 'cert-manager',
      },
    ],
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1beta1',
    kind: 'RoleBinding',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook:webhook-authentication-reader',
      namespace: 'kube-system',
    },
    roleRef: {
      apiGroup: 'rbac.authorization.k8s.io',
      kind: 'Role',
      name: 'extension-apiserver-authentication-reader',
    },
    subjects: [
      {
        apiGroup: '',
        kind: 'ServiceAccount',
        name: 'cert-manager-webhook',
        namespace: 'cert-manager',
      },
    ],
  },
  {
    apiVersion: 'rbac.authorization.k8s.io/v1',
    kind: 'ClusterRole',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook:webhook-requester',
    },
    rules: [
      {
        apiGroups: [
          'admission.certmanager.k8s.io',
        ],
        resources: [
          'certificates',
          'issuers',
          'clusterissuers',
        ],
        verbs: [
          'create',
        ],
      },
    ],
  },
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook',
      namespace: 'cert-manager',
    },
    spec: {
      ports: [
        {
          name: 'https',
          port: 443,
          targetPort: 6443,
        },
      ],
      selector: {
        app: 'webhook',
        release: 'cert-manager',
      },
      type: 'ClusterIP',
    },
  },
  {
    apiVersion: 'apps/v1beta1',
    kind: 'Deployment',
    metadata: {
      labels: {
        app: 'cainjector',
        chart: 'cainjector-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-cainjector',
      namespace: 'cert-manager',
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          app: 'cainjector',
          release: 'cert-manager',
        },
      },
      template: {
        metadata: {
          annotations: null,
          labels: {
            app: 'cainjector',
            release: 'cert-manager',
          },
        },
        spec: {
          containers: [
            {
              args: [
                '--leader-election-namespace=$(POD_NAMESPACE)',
              ],
              env: [
                {
                  name: 'POD_NAMESPACE',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'metadata.namespace',
                    },
                  },
                },
              ],
              image: 'quay.io/jetstack/cert-manager-cainjector:v0.7.0',
              imagePullPolicy: 'IfNotPresent',
              name: 'cainjector',
              resources: {},
            },
          ],
          serviceAccountName: 'cert-manager-cainjector',
        },
      },
    },
  },
  {
    apiVersion: 'apps/v1beta1',
    kind: 'Deployment',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook',
      namespace: 'cert-manager',
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          app: 'webhook',
          release: 'cert-manager',
        },
      },
      template: {
        metadata: {
          annotations: null,
          labels: {
            app: 'webhook',
            release: 'cert-manager',
          },
        },
        spec: {
          containers: [
            {
              args: [
                '--v=12',
                '--secure-port=6443',
                '--tls-cert-file=/certs/tls.crt',
                '--tls-private-key-file=/certs/tls.key',
              ],
              env: [
                {
                  name: 'POD_NAMESPACE',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'metadata.namespace',
                    },
                  },
                },
              ],
              image: 'quay.io/jetstack/cert-manager-webhook:v0.7.0',
              imagePullPolicy: 'IfNotPresent',
              name: 'webhook',
              resources: {},
              volumeMounts: [
                {
                  mountPath: '/certs',
                  name: 'certs',
                },
              ],
            },
          ],
          serviceAccountName: 'cert-manager-webhook',
          volumes: [
            {
              name: 'certs',
              secret: {
                secretName: 'cert-manager-webhook-webhook-tls',
              },
            },
          ],
        },
      },
    },
  },
  {
    apiVersion: 'apps/v1beta1',
    kind: 'Deployment',
    metadata: {
      labels: {
        app: 'cert-manager',
        chart: 'cert-manager-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager',
      namespace: 'cert-manager',
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          app: 'cert-manager',
          release: 'cert-manager',
        },
      },
      template: {
        metadata: {
          annotations: {
            'prometheus.io/path': '/metrics',
            'prometheus.io/port': '9402',
            'prometheus.io/scrape': 'true',
          },
          labels: {
            app: 'cert-manager',
            release: 'cert-manager',
          },
        },
        spec: {
          containers: [
            {
              args: [
                '--cluster-resource-namespace=$(POD_NAMESPACE)',
                '--leader-election-namespace=$(POD_NAMESPACE)',
              ],
              env: [
                {
                  name: 'POD_NAMESPACE',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'metadata.namespace',
                    },
                  },
                },
              ],
              image: 'quay.io/jetstack/cert-manager-controller:v0.7.0',
              imagePullPolicy: 'IfNotPresent',
              name: 'cert-manager',
              ports: [
                {
                  containerPort: 9402,
                },
              ],
              resources: {
                requests: {
                  cpu: '10m',
                  memory: '32Mi',
                },
              },
            },
          ],
          serviceAccountName: 'cert-manager',
        },
      },
    },
  },
  {
    apiVersion: 'apiregistration.k8s.io/v1beta1',
    kind: 'APIService',
    metadata: {
      annotations: {
        'certmanager.k8s.io/inject-ca-from': 'cert-manager/cert-manager-webhook-webhook-tls',
      },
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'v1beta1.admission.certmanager.k8s.io',
    },
    spec: {
      group: 'admission.certmanager.k8s.io',
      groupPriorityMinimum: 1000,
      service: {
        name: 'cert-manager-webhook',
        namespace: 'cert-manager',
      },
      version: 'v1beta1',
      versionPriority: 15,
    },
  },
  {
    apiVersion: 'certmanager.k8s.io/v1alpha1',
    kind: 'Issuer',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook-selfsign',
      namespace: 'cert-manager',
    },
    spec: {
      selfSigned: {},
    },
  },
  {
    apiVersion: 'certmanager.k8s.io/v1alpha1',
    kind: 'Certificate',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook-ca',
      namespace: 'cert-manager',
    },
    spec: {
      commonName: 'ca.webhook.cert-manager',
      duration: '43800h',
      isCA: true,
      issuerRef: {
        name: 'cert-manager-webhook-selfsign',
      },
      secretName: 'cert-manager-webhook-ca',
    },
  },
  {
    apiVersion: 'certmanager.k8s.io/v1alpha1',
    kind: 'Issuer',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook-ca',
      namespace: 'cert-manager',
    },
    spec: {
      ca: {
        secretName: 'cert-manager-webhook-ca',
      },
    },
  },
  {
    apiVersion: 'certmanager.k8s.io/v1alpha1',
    kind: 'Certificate',
    metadata: {
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook-webhook-tls',
      namespace: 'cert-manager',
    },
    spec: {
      dnsNames: [
        'cert-manager-webhook',
        'cert-manager-webhook.cert-manager',
        'cert-manager-webhook.cert-manager.svc',
      ],
      duration: '8760h',
      issuerRef: {
        name: 'cert-manager-webhook-ca',
      },
      secretName: 'cert-manager-webhook-webhook-tls',
    },
  },
  {
    apiVersion: 'admissionregistration.k8s.io/v1beta1',
    kind: 'ValidatingWebhookConfiguration',
    metadata: {
      annotations: {
        'certmanager.k8s.io/inject-apiserver-ca': 'true',
      },
      labels: {
        app: 'webhook',
        chart: 'webhook-v0.7.0',
        heritage: 'Tiller',
        release: 'cert-manager',
      },
      name: 'cert-manager-webhook',
    },
    webhooks: [
      {
        clientConfig: {
          service: {
            name: 'kubernetes',
            namespace: 'default',
            path: '/apis/admission.certmanager.k8s.io/v1beta1/certificates',
          },
        },
        failurePolicy: 'Fail',
        name: 'certificates.admission.certmanager.k8s.io',
        namespaceSelector: {
          matchExpressions: [
            {
              key: 'certmanager.k8s.io/disable-validation',
              operator: 'NotIn',
              values: [
                'true',
              ],
            },
            {
              key: 'name',
              operator: 'NotIn',
              values: [
                'cert-manager',
              ],
            },
          ],
        },
        rules: [
          {
            apiGroups: [
              'certmanager.k8s.io',
            ],
            apiVersions: [
              'v1alpha1',
            ],
            operations: [
              'CREATE',
              'UPDATE',
            ],
            resources: [
              'certificates',
            ],
          },
        ],
      },
      {
        clientConfig: {
          service: {
            name: 'kubernetes',
            namespace: 'default',
            path: '/apis/admission.certmanager.k8s.io/v1beta1/issuers',
          },
        },
        failurePolicy: 'Fail',
        name: 'issuers.admission.certmanager.k8s.io',
        namespaceSelector: {
          matchExpressions: [
            {
              key: 'certmanager.k8s.io/disable-validation',
              operator: 'NotIn',
              values: [
                'true',
              ],
            },
            {
              key: 'name',
              operator: 'NotIn',
              values: [
                'cert-manager',
              ],
            },
          ],
        },
        rules: [
          {
            apiGroups: [
              'certmanager.k8s.io',
            ],
            apiVersions: [
              'v1alpha1',
            ],
            operations: [
              'CREATE',
              'UPDATE',
            ],
            resources: [
              'issuers',
            ],
          },
        ],
      },
      {
        clientConfig: {
          service: {
            name: 'kubernetes',
            namespace: 'default',
            path: '/apis/admission.certmanager.k8s.io/v1beta1/clusterissuers',
          },
        },
        failurePolicy: 'Fail',
        name: 'clusterissuers.admission.certmanager.k8s.io',
        namespaceSelector: {
          matchExpressions: [
            {
              key: 'certmanager.k8s.io/disable-validation',
              operator: 'NotIn',
              values: [
                'true',
              ],
            },
            {
              key: 'name',
              operator: 'NotIn',
              values: [
                'cert-manager',
              ],
            },
          ],
        },
        rules: [
          {
            apiGroups: [
              'certmanager.k8s.io',
            ],
            apiVersions: [
              'v1alpha1',
            ],
            operations: [
              'CREATE',
              'UPDATE',
            ],
            resources: [
              'clusterissuers',
            ],
          },
        ],
      },
    ],
  },
])
