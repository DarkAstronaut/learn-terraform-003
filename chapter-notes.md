# Terraform Core Workflow

Terraform Workflow makes sure that the infrastructure is provisioned in controlled and reproducable manner.

## Core Workflpw Steps:

- Write - Infrasturcture Code
- Plan - Preview Changes
- Apply - Make Changes

The actual implementation is as follows:

### As Individual User

1. _Write Configuration File_ which acts as blueprint for the infrastructure that is being created

- _Initialize Working Directory_ with `terraform init` which downloads the required plugins, providers,

2.  _Run_ `terraform plan` to review all the changes that are being made to the infrastructure and verify if changes align with the goals (also add Version Control with `git add` or `git commit` on the main.tf file)
3.  _Run_ `terraform apply` to perform the actions for creating or changing infrastructue by terraform

- _Push to Repository_ with `git push` to move code to Remote SCM.

After the code (`main.tf` or other file) is written, `terraform init` command is run. This command performs

- Backend Initialization, which creates storage space for _state_ file keeps the track of the resources
- Provider Initialization, gets cloud provider plugins required for resource creation and modification
- Module Installation, (if applicable) download and installs module dependencies from configuration
- Plugin Initialization, initize all the plugins from providers for interaction with cloud APIs
- Authentication and Authorization, check credentials
- Environment Validation,to check if everything is up and ready to use
- `.terraform` subdirectory had provider plugins and modules
- `.terraform.lock.hcl` contains version constraints from proivders to maintain consistency across Terraform commands and environment

After initializing, before checking the plan, `terraform validate` command can be used to check for syntax errors and it shows if there are any problems with the file. `terraform fmt` can be used to format the code files to Terraform standards if indent and blocks to maintain consistency and improve readability

With `terraform plan`, the tasks that the Terraform will perform is provided. Terraform compares the existing resources and gets this execution plan details with state file.

After reviewing the plan, `terraform apply` command is used to create / modify the resources following the plan. Then terraform state file will be updated which contains all the changes on the reosurces. _Note:_ `terraform state list` _command can be used to see the list of the resources present in the state file_

As part of the workflow, there are times when resources needds to be removed after its usage. This is need to manaage the costs. This can be achieved with `terraform destroy`. This command clears all the resources that are created. It shows the changes that are made (destruction of the resources) and this changes are updated in state file

## With Terraform Cloud

- **Terraform Cloud** is service hosted at https://app.terraform.io helps teams to use Terraform together as group
- Provides secure hub for **input variables** and **state** where team can initialize and run configurations with CLI remotely basedd to the state file and variables stored on Terraform Cloud

# Terraform State

**Terraform State** is record of resources that Terraform in managing, including the metadata and the configuration details of the resources

- Terraform uses state file to track changes and make updates to the infrastructure.
- After applying, Terraform creates `terraform.tfstate` (state file)

## Terraform State Storage Loactions

### Local Backend

State file saves in local system

1. **Advantages**

- _Simplicity_: Doesn't need additional configurations to access state file and setting up state file is easy
- _Speed_: Quickly accessable and suitable to small scale projects

2.  **Disadvantages**, when working as team

- _Lack of Collaboration_, making it difficult to share, collaborate the state file, which could lead to errors and version conrol problems
- _Concurrency Issues_, leading to corruption of state file when concurrent users apply changes as Local system doesn't have builtin mechanisms
- _Data Loss_, making it difficult infrastructure

### Remote State

Storing state file in remote makes it easy of multiple people/teams to access it. State file can be stored in multiple locations like Amazon s3 Bucket, Google Cloud Storage, etc. This makes it possible to overcome the challenges of local state files and teams can access and collaborate without issues and conflicts of infrastructure

_Task_: Created S3 Bucket and moved `terraform.tfstate` to S3 Bucket - tf-demo-s3-bucket-0544

**State Locking**: Locking the Terraform State will prevent concurrent modifications to state file making it possible to avoid conflicts and inconsistent infrastructure. This makes it possible for only one user or process to modify the state file. This is achieved with Dynamo DB table (in AWS)

When `terraform plan` or `terraform apply` is run, it will say "Aquiring state lock" making it not possible for other to change the state file. Lock will be released after the changes are made in the state file

**Remote Backend State Options**

- Amazon S3
- Azure Storage,
- Google Cloud Storage
- HTTP Backend
- HashiCorp Consul
- Terraform Cloud
- Artifactory (JFrog)

## Resource Drift

- Case when actual infrastructure is different from what Terraform expects (based on coniguration files)
- Can be due to manual changes to infrastructure, updates out of Terraform. These can be identified with `terraform plan -refresh-only` and make changes accordingly in State file with `terraform apply -refresh-only`

# Understanding Terraform Configuration

## Variables

- Placeholders for values in the infrastructure code which can be modified to use in multiple cases
- Adds flexibility to customize and modify based on the need

### Variable Types

- String
- Number
- List
- Map

Variables are assigned in configuration file, saperate variables file or through command-line flags.

_Note_: It is suggested to declare variables in a seperate `variables.tf` file and access them in `main.tf` using `var.<variable_name>`

## Outputs

- Used to display specific values of the resources handled by the Terraform
- These values can act as inputs or bridge to the other elements for the infrastructure
- Values obtained from Outputs can be parts of configuration file, data sources and complex expressions

It is preferred that Outputs are written in `output.tf` file

## `.tfvars`

`terraform.tfvars` is a file created to assign values to the variables whithout changing the configuration file. If there is a need to change the values of the variables and want to overwrite the default values mentioned in `variables.tf`, it is advised to use `terrafrom.tfvars`.

## Secure Secret Injection - Best Practices

Data provided to Terraform may contain sensitive information such as API Tokens, Application Passwords, Authentication Credentials to configure resources

### Best Practices

1. Avoid Stroing Sensitive Information in `.tfvars` File, as it could be part of VCS and everyone can see sensitive information
2. Mark Variables and Outputs as Sensitive, by setting `sensitive = true` these values are not displayed in terminals or logs (even though it doesn't provide encryption, it hides the sensitive information in Terraform)
3. Secure Terraform State with Encryption at Rest, as sensitive data can be stored in state file, it is important to encrypt it to prevent unauthorized access
4. Using Environment Variables, which prevents exposure of sensitive data. Terrafrom Environment Variables can be created by running the command `$ export TF_VAR_<variable_name>="<value>"` where _variable name_ matches the varialbe declared in `variables.tf` file
5. Using a Secrets Manager, like
   - HashiCorp Vault
   - AWS Key Management Service (KMS)
   - AWS Systems Manager Paramenter Store (SSM Paramenter Store)
   - Azure Key Vault
6. Regularly Rotate Secrets and Credential, which is achieved with Secrets Manager

## Terraform Data Types

### Primitive Datatypes

- String
- Boolean
- Number

### Collection Types

- List
- Map
- Set

### Structural Types

- Objects
- Tuple

## Resources

A Resource is a infrastructure element that is created by Terraform. Each Resource has Resource Name (name of the resource created) and Resource Attributes (settings under each resource).

```
resource "<resource_type>" "<resource_name>" {
    <attribute_1> = <value_1>
    <attribute_2> = <value_2>
}

```

The `lifecycle` **Meta-Argument** in Terraform allows changing the resource behavior when `terraform apply` is execcuted. It has following arguments:

- `create_before_destroy`, determining order of creation and destruction of resources, making is helful to check if creation of a new resource is possible before destroying existing resource

```
resource "aws_instance" "sample" {
    # ...
    lifecycle {
        create_before_destroy = true
    }
}
```

- `prevent_destroy`, doesn't destroy the resource safeguarding from accidental destruction of resource
- `ignore_changes`, prevents unwanted modification of the resource, helping to keep the settings changes which are modified later
- `replace_triggered_by`, specify conditions to replace the resource

**Resource Dependency**, are used when directly mentioning that creation of a resource depends on a created or existing resource. For example, creation of an _AWS Instance_ could depend on _AWS Security Group_ and Terraform must create the Security Group before creating the Instance. This is achieved with `depends_on` in the resource block

### Looping and Multiple Instances

Used for creating or modifying multiple copies / duplicates of a resource, module or data source

- with `count` Meta-argumnet, multiple resource based on the number provided
- with `for_each` Meta-argument, multiple resource based on the set values which iterates for each value in the set

**Resource Addressing** is constructed with string comprising of 2 essential components:

- Module Path, signify the location within the hieraical structure of modules
- Resource Specification, addressed with `<resource_type>.<resource_name>[N]` (N is for index if resource of count-based)

## Terraform Functions

Terraform has built-in functions that can be used with expressions to interact withdata, manipulate configuration. Terraform funtions can be executed in terminal with `terraform console` command

**Built-In Functions**, (Examples in _functions.tf_ file)

- Numeric
- String, to manipulate and transform strings
- Collection, to manipulate collections like lists, sets, maps, ...
- Type Conversion
- Encoding
- Filesystem
- Data and Time
- Hash and Crypto
- IP Network

Find more at https://developer.hashicorp.com/terraform/language/functions

## Bulid-In Dependency Management

**Dependencies** are relationship between resources and configuration, used by Terraform to determine the order of resource creation and modification

### Types of Dependencies

**Implicit Dependency** - Dependencies in Terraform that are inferred by Terraform based on how Resources are referred within the configuration file (Example in `main.tf`)

**Explicit Dependency** - Dependencies that are defiened exxplicitly with `depends_on` paramenter (Example in `main.tf`), giving control over order of resource creation, provision and destruction

# Terraform Cloud

Terraform Cloud is SaaS Application that helps teams to use Terraform together by providing centralized environment for managing IaC across various cloud providers and on-premise environment, Terraform Cloud manages the State File (More at https://developer.hashicorp.com/terraform/cloud-docs)

- Organization - Top Level Container to managae Infrastructure
- Run - Execution of Terraform Configuration, records Creation, Updation and Deletion of Resources

## Features

- Manage Terraform State Files
- Show Histroy / Previous Runs for State
- Variable Management
- Cost Estimation
- Specify version of Terraform per Workspace
- Notifications via Webhook Level
- Permissions Management (Organization-level and Workspace-level)
- Global State Sharing
- Policy as Code (with Sentinel Policy Sets)
- Multifactor Authentication
- Single Sign-On / SSO (at paid tier)
- Integration with ServiceNow, Custom-Run Tasks, Kubernetes, etc.

## Collaboration Tools

- As a Centralized Platform, it offers

  - Role-based Access Control (RBAC)
  - Version Histroy
  - Workspace Management

- For Governance, Key Features are
  - Policy Enforcement
  - Compliance Monitoring
  - Audit Logging
