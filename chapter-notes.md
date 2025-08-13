# Terraform Modules

### Challenges with single directory

- Increased Complexity for understanding and navigating config file
- Risk with making changes
- Copying can lead to errors and difficult to maintain
- Can also lead to duplicate resource creation

These challenges can be addressed with Terraform Modules

**Module** - A directory with collection of Terraform Code
"_A Terraform module is a set of Terraform configuration files in a single directory_" - HashiCorp Terraform Documentation

### Module Structure

Basic Module structure consists of following files:

- LICENSE
- README.md
- main.tf
- variables.tf
- outputs.tf
  This directory (from which the Terraform commands are executed) would become Root Module

### Types of Modules

- Root Module: Primary Configuration File
- Child Module: Resuable Componants/Configurations
- Published Modules: Shared Terraform Modules (found in Registry)

Modules can be loaded from local filesystem, remote sources (VCS, Terraform Cloud, HTTPS URLs, Enterprise Private Module registries)

### _Publishing a Module in Terraform Registry_

Terraform Module can be published by signing in with GitHub Account in https://registry.terraform.io and select the repository that has the files for the publishing module

### Uses of Modules

- Code Reusability: Reduces duplication and helps in maintaining consistency
- Modularization: Easy to organize and maintain code / breaking complex structure into simple individual componants
- Standardization: Company-wise same infrastructure componants / helps in maintaing orgaizational policies
- Collaboration: Enables team to work on componants without affecting other's code / work

**Module Inputs**: Variables that are passed to a module to configure its behaviour
**Module Output**: Values that a Module can return to main configuration which allows access to results or information from the module

Chaining Modules: When Output of a module acts as imput of another module
