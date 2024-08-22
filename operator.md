## Azure Service Bus Queue

Azure Service Bus is a fully managed enterprise messaging service that facilitates communication between decoupled applications and services. It enables reliable message queuing and publish-subscribe capabilities, ensuring seamless data flow and enhancing the scalability and resilience of applications.

### Design Decisions

- **Namespace & Queue Creation**: The module creates an Azure Service Bus namespace and a queue within that namespace. The namespace is configured with SystemAssigned identity for integrated security.
  
- **SKU Consideration**: Differentiation is made between 'Premium' and other SKUs. For Premium SKUs, additional features like partitioning and zone redundancy are enabled or configurable.
  
- **Security Roles**: Specific roles like "Azure Service Bus Data Sender" and "Azure Service Bus Data Receiver" are created and scoped to the Service Bus namespace for access control.
  
- **Monitoring & Alerts**: Automated alarms for server errors and latency issues are configured, ensuring high availability and performance through predefined thresholds and alert conditions.

### Runbook

#### Checking Namespace and Queue Status

To ensure your Service Bus namespace and queue are operational, you can check their statuses using Azure CLI commands.

```sh
# Check Namespace Status
az servicebus namespace show --resource-group <resource-group-name> --name <namespace-name> 

# Check Queue Status
az servicebus queue show --resource-group <resource-group-name> --namespace-name <namespace-name> --name <queue-name>
```

#### Viewing Active Messages

If messages are not being processed as expected, check the active messages in the queue.

```sh
az servicebus queue message count --resource-group <resource-group-name> --namespace-name <namespace-name> --queue-name <queue-name>
```

This command returns the count of messages in different states (active, dead-lettered, etc.) to help diagnose queuing issues.

#### Troubleshooting Network and Access Issues

If there are access problems, check the network rules and the assigned roles to ensure proper configuration.

```sh
# List Network Rules
az servicebus namespace network-rule list --resource-group <resource-group-name> --namespace-name <namespace-name> 

# Check Role Assignments
az role assignment list --scope <namespace-id>
```

#### Monitoring Service Health

Azure provides built-in monitoring via metrics and logs to track the health of your Service Bus namespace and queues.

```sh
# View Metrics for Namespace
az monitor metrics list --resource <namespace-id> --metric-names "Messages Count, ActiveMessages, DeadLetteredMessages"

# View Logs for Namespace
az monitor log-analytics query --workspace <workspace-id> --analytics-query "AzureDiagnostics | where ResourceId contains '<namespace-id>'"
```

#### Dealing with Message Duplication

If duplicate messages are being inserted, it might be due to the `requires_duplicate_detection` setting.

```sh
# Ensure Duplicate Detection is Enabled
az servicebus queue update --resource-group <resource-group-name> --namespace-name <namespace-name> --name <queue-name> --requires-duplicate-detection true
```

Remember to monitor the duplicate detection history to identify patterns and possible issues with message sending.



