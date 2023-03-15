# Cross-region access to Confluent Cloud is not supported when VPC peering is enabled with Google Cloud. Your AWS VPC and Confluent Cloud must be in the same region.
# The region of your VPC that you want to connect to Confluent Cloud Cluster
# Cross-region AWS PrivateLink connections are not supported yet.
region = "us-east-1"

# The region of the AWS peer VPC.
customer_region = "us-east-1"

# The CIDR of Confluent Cloud Network
cidr = "10.10.0.0/16"

# The AWS Account ID of the peer VPC owner.
# You can find your AWS Account ID here (https://console.aws.amazon.com/billing/home?#/account) under My Account section of the AWS Management Console. Must be a 12 character string.
aws_account_id = "<AWS_ACT_ID>"
mongodb_endpoint = "<MongoDB_URL>"
mongodb_username = "<MongoDB_usename>"
mongodb_password = "<MongoDB_password>"
mongodb_name = "<MongoDB_DB_name>"
mongodb_collection_name = "<MongoDB_collection_name>"
confluent_cloud_api_key = "<Cflt_API_KEY>"
confluent_cloud_api_secret = "<Cflt_Secret>"
