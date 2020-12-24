#!/bin/bash
tar -zcvf env-template.tar.gz environment/
aws s3 cp env-template.tar.gz s3://proton-${account_name}-test/env-template.tar.gz --region us-west-2
version=$(aws proton-preview create-environment-template-minor-version --region us-west-2 --template-name "proton-ecs" --major-version-id "1" --source-s3-bucket proton-${account_name}-test --source-s3-key env-template.tar.gz | jq -r .environmentTemplateMinorVersion.minorVersionId)
sleep 5 # Seems to take a sec.
aws proton-preview update-environment-template-minor-version --region us-west-2 --template-name "proton-ecs" --major-version-id "1" --minor-version-id ${version} --status "PUBLISHED"
