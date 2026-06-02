# METADATA
# title: API Gateway custom domain must use an approved TLS security policy
# description: TLS_1_0 permits weak cipher suites. All custom domains must use a security policy from the approved list.
# custom:
#   controls:
#     - CC6.7
#   schedule: "0 */6 * * *"

package compliance_framework.apigw_require_approved_security_policy

violation[{}] if {
	not input.security_policy in data.approved_security_policies
}

title := "API Gateway custom domain must use an approved TLS security policy"
description := "TLS_1_0 permits weak cipher suites. All custom domains must use a security policy from the approved list."
