# AWS Two-Tier Infrastructure with Terraform

This project contains Terraform code to set up a **simple two-tier infrastructure** to deploy a Flask app on AWS.

## Architecture Overview

The infrastructure is designed as follows:
- **VPC**: A Virtual Private Cloud to host all the resources.
- **Subnets**: Two subnets in different Availability Zones for high availability.
- **RDS Instance**: Amazon RDS instance with optional Multi-AZ deployment for high availability.

![AWS RDS Architecture](https://github.com/DevopsDhruv/Run-Flask-app-with-RDS/blob/main/Flaskapp_Infrastructure.drawio.png?raw=true)

## Prerequisites

- Terraform installed on your local machine.
- AWS access key and secret key 🗝 

## Setup Infrastructure on AWS using Terraform

1. Clone the repository:
    ```sh
    git clone https://github.com/DevopsDhruv/Run-Flask-app-with-RDS.git
    
    cd Run-Flask-app-with-RDS
    ```
2. Create an SSH key for the public subnet EC2 instance:
    ```bash
    ssh-keygen
    ```
    Create the SSH key and name it exactly `instance_key`.

3. Initialize Terraform:

    ```sh
    terraform init
    ```
4. Edit the values in the `terraform.tfvars` file as per your requirements.

5. Apply the Terraform configuration:
    ```sh
    terraform apply --auto-approve
    ```

## Deploy Flask App on EC2 Instance

1. Connect to the EC2 instance using SSH:

    ```bash
    ssh -i 'instance_key' ubuntu@Change_with_Instance_publicIP
    ```

2. Install Docker and Docker Compose:

    ```bash
    git clone https://github.com/DevopsDhruv/Install-Docker.git

    cd Install-Docker
    ```

    ```bash
    chmod a+x Install_Docker.sh

    ./Install_Docker.sh
    ```

3. Clone the Flask app repository:

    ```bash
    git clone https://github.com/DevopsDhruv/flask-app.git

    cd flask-app
    ```

4. Set up RDS for the Flask app:

    ```bash
    mysql -h change_with_database_endpoint -u admin -p
    Password: admin54321

    CREATE DATABASE flaskapp;

    USE flaskapp;

    CREATE TABLE users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(100)
    );

    GRANT ALL PRIVILEGES ON flaskapp.* TO 'admin'@'%';

    exit;
    ```

5. Edit the `docker-compose.yml` file:
    
    Change `DB_Host=Your_RDS_endpoint`, then save and exit.

6. Run the Flask app:

    ```bash
    docker-compose up --build -d 
    ```

**Now you can access the Flask app at `instance_publicIP:5000`.**

## Check Data Inside RDS Database

1. Connect to the RDS database:

    ```bash
    mysql -h change_with_database_endpoint -u admin -p
    Password: admin54321

    USE flaskapp;

    SELECT * FROM users;
    ```

## 
