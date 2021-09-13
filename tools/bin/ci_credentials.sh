#!/usr/bin/env bash

. tools/lib/lib.sh

set -e

function write_standard_creds() {
  local connector_name=$1
  local creds=$2
  local cred_filename=${3:-config.json}

  [ -z "$connector_name" ] && error "Empty connector name"
  [ -z "$creds" ] && error "Creds not set for $connector_name"

  if [ "$connector_name" = "base-normalization" ]; then
    local secrets_dir="airbyte-integrations/bases/${connector_name}/secrets"
  else
    local secrets_dir="airbyte-integrations/connectors/${connector_name}/secrets"
  fi
  mkdir -p "$secrets_dir"
  echo "$creds" > "${secrets_dir}/${cred_filename}"
}

# Please maintain this organisation and alphabetise.
write_standard_creds destination-bigquery "$BIGQUERY_INTEGRATION_TEST_CREDS" "credentials.json"
write_standard_creds destination-bigquery-denormalized "$BIGQUERY_DENORMALIZED_INTEGRATION_TEST_CREDS" "credentials.json"
write_standard_creds destination-databricks "$DESTINATION_DATABRICKS_CREDS"
write_standard_creds destination-gcs "$DESTINATION_GCS_CREDS"
write_standard_creds destination-kvdb "$DESTINATION_KVDB_TEST_CREDS"
write_standard_creds destination-keen "$DESTINATION_KEEN_TEST_CREDS"

write_standard_creds destination-postgres "$DESTINATION_POSTGRES_SSH_PWD_TEST_CREDS" "ssh-pwd-config.json"
write_standard_creds destination-postgres "$DESTINATION_POSTGRES_SSH_KEY_TEST_CREDS" "ssh-key-config.json"
write_standard_creds destination-postgres "$DESTINATION_PUBSUB_TEST_CREDS" "credentials.json"
write_standard_creds destination-pubsub "$DESTINATION_PUBSUB_TEST_CREDS" "credentials.json"
write_standard_creds destination-redshift "$AWS_REDSHIFT_INTEGRATION_TEST_CREDS"
write_standard_creds destination-dynamodb "$DESTINATION_DYNAMODB_TEST_CREDS"
write_standard_creds destination-oracle "$AWS_ORACLE_INTEGRATION_TEST_CREDS"
write_standard_creds destination-s3 "$DESTINATION_S3_INTEGRATION_TEST_CREDS"
write_standard_creds destination-azure-blob-storage "$DESTINATION_AZURE_BLOB_CREDS"
write_standard_creds destination-snowflake "$SNOWFLAKE_GCS_COPY_INTEGRATION_TEST_CREDS" "copy_gcs_config.json"
write_standard_creds destination-snowflake "$SNOWFLAKE_S3_COPY_INTEGRATION_TEST_CREDS" "copy_s3_config.json"
write_standard_creds destination-snowflake "$SNOWFLAKE_INTEGRATION_TEST_CREDS" "insert_config.json"

write_standard_creds base-normalization "$BIGQUERY_INTEGRATION_TEST_CREDS" "bigquery.json"
write_standard_creds base-normalization "$SNOWFLAKE_INTEGRATION_TEST_CREDS" "snowflake.json"
write_standard_creds base-normalization "$AWS_REDSHIFT_INTEGRATION_TEST_CREDS" "redshift.json"
write_standard_creds base-normalization "$AWS_ORACLE_INTEGRATION_TEST_CREDS" "oracle.json"

write_standard_creds source-amazon-seller-partner "$AMAZON_SELLER_PARTNER_TEST_CREDS"
write_standard_creds source-amplitude "$AMPLITUDE_INTEGRATION_TEST_CREDS"
write_standard_creds source-apify-dataset "$APIFY_INTEGRATION_TEST_CREDS"
write_standard_creds source-amazon-ads "$AMAZON_ADS_TEST_CREDS"
write_standard_creds source-amplitude "$AMPLITUDE_INTEGRATION_TEST_CREDS"
write_standard_creds source-asana "$SOURCE_ASANA_TEST_CREDS"
write_standard_creds source-aws-cloudtrail "$SOURCE_AWS_CLOUDTRAIL_CREDS"
write_standard_creds source-bamboo-hr "$SOURCE_BAMBOO_HR_CREDS"
write_standard_creds source-bigcommerce "$SOURCE_BIGCOMMERCE_CREDS"
write_standard_creds source-bigquery "$BIGQUERY_TEST_CREDS" "credentials.json"
write_standard_creds source-bing-ads "$SOURCE_BING_ADS_CREDS"
write_standard_creds source-braintree "$BRAINTREE_TEST_CREDS"
write_standard_creds source-cart "$CART_TEST_CREDS"
write_standard_creds source-chargebee "$CHARGEBEE_INTEGRATION_TEST_CREDS"
write_standard_creds source-drift "$DRIFT_INTEGRATION_TEST_CREDS"
write_standard_creds source-dixa "$SOURCE_DIXA_TEST_CREDS"
write_standard_creds source-exchange-rates "$EXCHANGE_RATES_TEST_CREDS"
write_standard_creds source-file "$GOOGLE_CLOUD_STORAGE_TEST_CREDS" "gcs.json"
write_standard_creds source-file "$AWS_S3_INTEGRATION_TEST_CREDS" "aws.json"
write_standard_creds source-file "$AZURE_STORAGE_INTEGRATION_TEST_CREDS" "azblob.json"
write_standard_creds source-freshdesk "$FRESHDESK_TEST_CREDS"
write_standard_creds source-facebook-marketing "$FACEBOOK_MARKETING_TEST_INTEGRATION_CREDS"
write_standard_creds source-facebook-pages "$FACEBOOK_PAGES_INTEGRATION_TEST_CREDS"
write_standard_creds source-gitlab "$GITLAB_INTEGRATION_TEST_CREDS"
write_standard_creds source-github "$GH_NATIVE_INTEGRATION_TEST_CREDS"
write_standard_creds source-google-ads "$GOOGLE_ADS_TEST_CREDS"
write_standard_creds source-google-adwords-singer "$ADWORDS_INTEGRATION_TEST_CREDS"
write_standard_creds source-google-analytics-v4 "$GOOGLE_ANALYTICS_V4_TEST_CREDS"
write_standard_creds source-googleanalytics-singer "$GOOGLE_ANALYTICS_TEST_CREDS"
write_standard_creds source-googleanalytics-singer "$GOOGLE_ANALYTICS_TEST_TRACKING_ID" "tracker.txt"
write_standard_creds source-google-directory "$GOOGLE_DIRECTORY_TEST_CREDS"
write_standard_creds source-google-search-console "$GOOGLE_SEARCH_CONSOLE_CDK_TEST_CREDS"
write_standard_creds source-google-search-console "$GOOGLE_SEARCH_CONSOLE_CDK_TEST_CREDS_SRV_ACC" "service_account_config.json"
write_standard_creds source-google-search-console-singer "$GOOGLE_SEARCH_CONSOLE_TEST_CREDS"
write_standard_creds source-google-sheets "$GOOGLE_SHEETS_TESTS_CREDS"
write_standard_creds source-google-workspace-admin-reports "$GOOGLE_WORKSPACE_ADMIN_REPORTS_TEST_CREDS"
write_standard_creds source-greenhouse "$GREENHOUSE_TEST_CREDS"
write_standard_creds source-harvest "$HARVEST_INTEGRATION_TESTS_CREDS"
write_standard_creds source-hubspot "$HUBSPOT_INTEGRATION_TESTS_CREDS"
write_standard_creds source-instagram "$INSTAGRAM_INTEGRATION_TESTS_CREDS"
write_standard_creds source-intercom "$INTERCOM_INTEGRATION_TEST_CREDS"
write_standard_creds source-iterable "$ITERABLE_INTEGRATION_TEST_CREDS"
write_standard_creds source-jira "$JIRA_INTEGRATION_TEST_CREDS"
write_standard_creds source-klaviyo "$KLAVIYO_TEST_CREDS"
write_standard_creds source-looker "$LOOKER_INTEGRATION_TEST_CREDS"
write_standard_creds source-mailchimp "$MAILCHIMP_TEST_CREDS"
write_standard_creds source-marketo-singer "$SOURCE_MARKETO_SINGER_INTEGRATION_TEST_CONFIG"
write_standard_creds source-microsoft-teams "$MICROSOFT_TEAMS_TEST_CREDS"
write_standard_creds source-mixpanel "$MIXPANEL_INTEGRATION_TEST_CREDS"
write_standard_creds source-mssql "$MSSQL_RDS_TEST_CREDS"
write_standard_creds source-okta "$SOURCE_OKTA_TEST_CREDS"
write_standard_creds source-plaid "$PLAID_INTEGRATION_TEST_CREDS"
write_standard_creds source-paypal-transaction "$PAYPAL_TRANSACTION_CREDS"
write_standard_creds source-postgres "$POSTGRES_SSH_KEY_TEST_CREDS" "ssh-key-config.json"
write_standard_creds source-postgres "$POSTGRES_SSH_PWD_TEST_CREDS" "ssh-pwd-config.json"
write_standard_creds source-posthog "$POSTHOG_TEST_CREDS"
write_standard_creds source-pipedrive "$PIPEDRIVE_INTEGRATION_TESTS_CREDS"
write_standard_creds source-quickbooks-singer "$QUICKBOOKS_TEST_CREDS"
write_standard_creds source-recharge "$RECHARGE_INTEGRATION_TEST_CREDS"
write_standard_creds source-recurly "$SOURCE_RECURLY_INTEGRATION_TEST_CREDS"
write_standard_creds source-redshift "$AWS_REDSHIFT_INTEGRATION_TEST_CREDS"
write_standard_creds source-s3 "$SOURCE_S3_TEST_CREDS"
write_standard_creds source-s3 "$SOURCE_S3_PARQUET_CREDS" "parquet_config.json"
write_standard_creds source-salesforce "$SALESFORCE_BULK_INTEGRATION_TESTS_CREDS" "config_bulk.json"
write_standard_creds source-salesforce "$SALESFORCE_INTEGRATION_TESTS_CREDS"
write_standard_creds source-sendgrid "$SENDGRID_INTEGRATION_TEST_CREDS"
write_standard_creds source-shopify "$SHOPIFY_INTEGRATION_TEST_CREDS"
write_standard_creds source-shortio "$SOURCE_SHORTIO_TEST_CREDS"
write_standard_creds source-slack "$SOURCE_SLACK_TEST_CREDS"
write_standard_creds source-smartsheets "$SMARTSHEETS_TEST_CREDS"
write_standard_creds source-snapchat-marketing "$SOURCE_SNAPCHAT_MARKETING_CREDS"
write_standard_creds source-snowflake "$SNOWFLAKE_INTEGRATION_TEST_CREDS" "config.json"
write_standard_creds source-square "$SOURCE_SQUARE_CREDS"
write_standard_creds source-stripe "$SOURCE_STRIPE_CREDS"
write_standard_creds source-stripe "$STRIPE_INTEGRATION_CONNECTED_ACCOUNT_TEST_CREDS" "connected_account_config.json"
write_standard_creds source-surveymonkey "$SURVEYMONKEY_TEST_CREDS"
write_standard_creds source-tempo "$TEMPO_INTEGRATION_TEST_CREDS"
write_standard_creds source-trello "$TRELLO_TEST_CREDS"
write_standard_creds source-twilio "$TWILIO_TEST_CREDS"
write_standard_creds source-typeform "$SOURCE_TYPEFORM_CREDS"
write_standard_creds source-us-census "$SOURCE_US_CENSUS_TEST_CREDS"
write_standard_creds source-zendesk-chat "$ZENDESK_CHAT_INTEGRATION_TEST_CREDS"
write_standard_creds source-zendesk-sunshine "$ZENDESK_SUNSHINE_TEST_CREDS"
write_standard_creds source-zendesk-support "$ZENDESK_SUPPORT_TEST_CREDS"
write_standard_creds source-zendesk-talk "$ZENDESK_TALK_TEST_CREDS"
write_standard_creds source-zoom-singer "$ZOOM_INTEGRATION_TEST_CREDS"
write_standard_creds source-zuora "$SOURCE_ZUORA_TEST_CREDS"

