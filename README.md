# AWS Lambda EC2 Scheduler

This Terraform script automates the provisioning of an EC2 instance and a Lambda function that starts and stops the instance at specific times.

## Prerequisites

- Terraform installed on your local machine. You can download it [here](https://www.terraform.io/downloads.html).
- An AWS account with appropriate permissions to create EC2 instances, Lambda functions, and IAM roles.

## Getting Started

1. Generate an SSH key pair using the `ssh-keygen` command:

    ```bash
    ssh-keygen -t rsa
    ```

    Follow the prompts to choose a location and passphrase. Your private key (`keyname.pem`) will be saved in `~/.ssh/`.

2. Update the Terraform configuration with your SSH key name:

    Open `modules/ec2/main.tf` and replace `YOUR_KEY_NAME` with the name of your SSH key (without the `.pem` extension).

3. Initialize Terraform and apply the configuration:

    ```bash
    cd lambda-function
    terraform init
    terraform plan
    terraform apply
    ```

    Review the plan and confirm the changes to deploy the EC2 instance and Lambda function.

## Configuration

- `modules/lambda/main.tf`: Contains the Terraform configuration for provisioning the EC2 instance and Lambda function.
- `modules/lambda/start.zip`: Lambda function code to start the EC2 instance.
- `modules/lambda/stop.zip`: Lambda function code to stop the EC2 instance.

## Usage

The Lambda function is scheduled to run at specific times using Amazon EventBridge (formerly CloudWatch Events). By default, it starts the EC2 instance at 8:00 AM UTC and stops it at 8:00 PM UTC. You can adjust the schedule expressions in `modules/lambdamain.tf` as needed.


## Contributing

Contributions are welcome! Please submit issues or pull requests if you encounter any problems or have suggestions for improvements.

## Contact

For questions or support, contact [Viresh Solanki](mailto:vireshsolanki58@gmail.com).
