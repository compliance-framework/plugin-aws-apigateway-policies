package compliance_framework.apigw_require_approved_security_policy

import rego.v1

# TLS_1_2 — approved, no violation
test_no_violation_tls12 if {
	count(violation) == 0 with input as {"security_policy": "TLS_1_2"}
		with data.approved_security_policies as ["TLS_1_2"]
}

# TLS_1_0 — not in approved list, violation
test_violation_tls10 if {
	count(violation) == 1 with input as {"security_policy": "TLS_1_0"}
		with data.approved_security_policies as ["TLS_1_2"]
}

# Empty security_policy — not in approved list, violation
test_violation_empty_policy if {
	count(violation) == 1 with input as {"security_policy": ""}
		with data.approved_security_policies as ["TLS_1_2"]
}

# Missing security_policy field — rule body undefined, no violation
test_no_violation_missing_field if {
	count(violation) == 0 with input as {}
		with data.approved_security_policies as ["TLS_1_2"]
}

# Custom approved list that includes TLS_1_0 — no violation for TLS_1_0
test_no_violation_custom_approved_list if {
	count(violation) == 0 with input as {"security_policy": "TLS_1_0"}
		with data.approved_security_policies as ["TLS_1_0", "TLS_1_2"]
}
