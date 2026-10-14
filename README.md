# AWS API Gateway policies

Standalone OPA/Rego policy bundle for API Gateway custom domain evidence emitted by the `plugin-aws-apigateway` collector.

## Input schema

Each policy evaluates one API Gateway custom domain at a time using:

- `input.region`
- `input.account_id`
- `input.domain_name`
- `input.security_policy`
- `input.certificate_arn` (omitted when the domain has no certificate)
- `input.endpoint_type`
- `input.status`
- `input.tags`

## Current coverage

| Policy | Checks | Controls |
| --- | --- | --- |
| `apigw_require_approved_security_policy` | the domain's TLS security policy is in `approved_security_policies`; an empty security policy is a violation | CC6.7 |

## Policy data

Default baselines live in `policies/data.json` and can be overridden by agent-supplied policy data.

| Key | Default | Used by |
| --- | --- | --- |
| `approved_security_policies` | `["TLS_1_2"]` | `apigw_require_approved_security_policy` |

## Testing

Run local checks with:

```shell
opa check policies
opa test policies
```

Or use the Makefile wrappers:

```shell
make validate
make test
```

## Bundling

Build the distributable bundle with:

```shell
make build
```

This writes `dist/bundle.tar.gz`.

## Releasing

- Releases come from release-please PRs: merging one tags `vX.Y.Z` and publishes the policy bundle.
- Release candidates (`vX.Y.Z-rcN`) come from the `cut-prerelease` workflow.

## Related repositories

- [plugin-aws-apigateway](https://github.com/compliance-framework/plugin-aws-apigateway)
