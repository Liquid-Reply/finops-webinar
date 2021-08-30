terraform init \
    -backend-config="address=https://gitlab.com/api/v4/projects/29054924/terraform/state/example-production" \
    -backend-config="lock_address=https://gitlab.com/api/v4/projects/29054924/terraform/state/example-production/lock" \
    -backend-config="unlock_address=https://gitlab.com/api/v4/projects/29054924/terraform/state/example-production/lock" \
    -backend-config="username=gitlab-ci-token" \
    -backend-config="password=${CI_JOB_TOKEN}" \
    -backend-config="lock_method=POST" \
    -backend-config="unlock_method=DELETE" \
    -backend-config="retry_wait_min=5" \
    -reconfigure