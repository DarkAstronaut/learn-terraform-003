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
