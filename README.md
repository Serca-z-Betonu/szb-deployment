# SzB API deployment

This repository allows us to provision a virtual machine in the AWS cloud on which we deploy our API in Docker along with the PostrgeSQL database in a single Docker Compose file.

## Usage

To use this repository, you need a valid OpenSSH key pair. You also need to create a `terraform.tfvars` file to override `aws_access_key_id` and `aws_secret_access_key` with valid AWS IAM user credentials.
