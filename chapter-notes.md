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
- Can be due to manual changes to infrastructure, updates out of Terraform. These can be identified with `terraform plan -refresh-only` and make changes accordingly
