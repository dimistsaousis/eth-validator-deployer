# Ethereum Validator Deployer

Streamline the deployment of an ethereum validator using docker. The validator uses erigon for the execution client and lighthouse for consensus and validator clients.
Monitoring is provided using grafana and prometheus.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Project Structure](#project-structure)
3. [Environment Variables](#environment-variables)
4. [Services Description](#services-description)
5. [Deployment Instructions](#deployment-instructions)
6. [Monitoring](#monitoring)
7. [Support](#support)
8. [License](#license)

## Prerequisites

Ensure that you have the following installed on your machine:

- Docker
- Docker Compose

## Project Structure

```plaintext
eth-validator-deployer/
    docker-compose.yaml
    README.md
    .env
    consensus/
        Dockerfile
        entrypoint.sh
    validator/
        Dockerfile
        keymanager.sh
        entrypoint.sh
    grafana/
        datasource.yml
        Dockerfile
        provision-dashboards.sh
        dashboard.yml
    execution/
        jwtsecret.sh
        Dockerfile
        entrypoint.sh
    configs/
        blackbox.yml
        json.yml
    scripts/
        docker-volume-size.sh
    prometheus/
        Dockerfile
        prometheus.yml
```

## Environment Variables

Configure the environment variables in the `.env` file:

```plaintext
KEYSTORE_PASSWORD=*your password here*
ETH_NETWORK=*the network here*
FEE_RECIPIENT=*your address here*
```

## Services Description

- **Consensus**: Utilizes Lighthouse for consensus layer services. Configured with `--network` and `--suggested-fee-recipient` options.
- **Validator**: Lighthouse is used for validation services. Validator keys are imported using a script, and need to be stored accordingly.
- **Execution**: Utilizes Erigon. A JWT secret for communication between consensus and execution is auto-generated.
- **Monitoring**: Utilizes Prometheus and Grafana to provide monitoring dashboards for various services.
- **Data Export**: Various exporters are set up to provide metrics and data for monitoring.

## Deployment Instructions

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/dimistsaousis/eth-validator-deployer.git
   cd eth-validator-deployer
   ```

2. **Update Environment Variables**:
   Open the `.env` file with a text editor of your choice and update the environment variables `KEYSTORE_PASSWORD`, `ETH_NETWORK`, and `FEE_RECIPIENT` with your own values:

   ```plaintext
   KEYSTORE_PASSWORD=*your password here*
   ETH_NETWORK=*the network here*
   FEE_RECIPIENT=*your address here*
   ```

3. **Prepare Validator Keys**:

   - Ensure that your validator keys are present in the `.eth/ethereum-keys` directory.
   - If the directory doesn't exist, create it:
     ```bash
     mkdir -p .eth/ethereum-keys
     ```
   - Place your validator keys in the `.eth/ethereum-keys` directory.

4. **Build and Deploy**:
   Now, build and deploy the Docker Compose setup with the following command:

   ```bash
   docker-compose up --build -d
   ```

5. **Verify Deployment**:
   Verify that all containers are running and healthy:

   ```bash
   docker-compose ps
   ```

6. **Access Monitoring Dashboards**:
   Access Grafana by navigating to `http://localhost:3000` on your web browser to view the monitoring dashboards and ensure the services are operating as expected.

In the `validator` service configuration, the `keymanager.sh` script is used to import the validator keys from the `.eth/ethereum-keys` directory. It's imperative that the validator keys are placed in this directory prior to deploying the services, and the `KEYSTORE_PASSWORD` environment variable is set correctly in the `.env` file to ensure the secure handling of these keys.

## Support

For any inquiries or issues regarding the setup, please open an issue in the repository or contact the maintainers.

## License

This project is under the MIT License.
