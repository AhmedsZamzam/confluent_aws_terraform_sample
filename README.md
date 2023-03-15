This repo uses Terraform to deploy

1. Private Confluent Cloud cluster
2. An AWS VPC in your AWS Account
3. Peering connection to the new VPC
4. A MongoDB Sink Connector

### Prerequisites

1. An existing MongoDB Atlas DB
2. AWS Keys
3. Confluent Cloud API Keys with Oraganisation Admin privilege
4. Terraform installed on your local computer


### Important Note

1. This example assumes that Terraform is run from a host in the private network, where it will have connectivity to the [Kafka REST API](https://docs.confluent.io/cloud/current/api.html#tag/Topic-(v3)) in other words, to the [REST endpoint](https://docs.confluent.io/cloud/current/clusters/broker-config.html#access-cluster-settings-in-the-ccloud-console) on the provisioned Kafka cluster. If it is not, you must make these changes:

    * Update the `confluent_api_key` resources by setting their `disable_wait_for_ready` flag to `true`. Otherwise, Terraform will attempt to validate API key creation by listing topics, which will fail without access to the Kafka REST API. Otherwise, you might see errors like:

        ```
        Error: error waiting for Kafka API Key "[REDACTED]" to sync: error listing Kafka Topics using Kafka API Key "[REDACTED]": Get "[https://[REDACTED]/kafka/v3/clusters/[REDACTED]/topics](https://[REDACTED]/kafka/v3/clusters/[REDACTED]/topics)": GET [https://[REDACTED]/kafka/v3/clusters/[REDACTED]/topics](https://[REDACTED]/kafka/v3/clusters/[REDACTED]/topics) giving up after 5 attempt(s): Get "[https://[REDACTED]/kafka/v3/clusters/[REDACTED]/topics](https://[REDACTED]/kafka/v3/clusters/[REDACTED/topics)": dial tcp [REDACTED]:443: i/o timeout
        ```

    * Remove the `confluent_kafka_topic` resource. These resources are provisioned using the Kafka REST API, which is only accessible from the private network.

2. One common deployment workflow for environments with private networking is as follows:

    * A initial (centrally-run) Terraform deployment provisions infrastructure: network, Kafka cluster, and other resources on cloud provider of your choice to setup private network connectivity (like DNS records)

    * A secondary Terraform deployment (run from within the private network) provisions data-plane resources (Kafka Topics and ACLs)

    * Note that RBAC role bindings can be provisioned in either the first or second step, as they are provisioned through the [Confluent Cloud API](https://docs.confluent.io/cloud/current/api.html), not the [Kafka REST API](https://docs.confluent.io/cloud/current/api.html#tag/Topic-(v3))

3. See [VPC Peering on AWS](https://docs.confluent.io/cloud/current/networking/peering/aws-peering.html) for more details.


### Deployment

1. Clone repo ```git clone <repo>```


2. Change directory to terraform folder ```cd terraform```


3. Edit ```terraform.tfvars``` with your inputs


4. Run ```terraform init```


5. Run ```terraform apply``` 

6. **The MongoDB Sink connector is expected to deploy but fail to start due to a specific configuration. This is because the connector is set to read from a topic that does not yet exist. Unfortunately, the topic could not be created during deployment because the computer running the Terraform script lacks connectivity to the Kafka REST API required for topic creation.**
