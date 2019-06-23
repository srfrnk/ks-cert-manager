FORCE:

publish: FORCE
	ks show -o json cluster -c cert-manager -c letsencrypt-staging -c letsencrypt-prod > dist/ks-cert-manager.json
