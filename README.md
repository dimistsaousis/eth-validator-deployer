# Blockchain Network Setup

This project sets up a blockchain network using Docker Compose. It consists of multiple services including a blockchain execution engine, a consensus mechanism, and a validator. Metrics exporters and monitoring tools are also integrated.

## Project Structure

- `docker-compose.yml`: The main file that orchestrates all the Docker containers.
- `Dockerfile.erigon`: Dockerfile for building the Erigon execution service.
- `Dockerfile.lighthouseconsensus`: Dockerfile for building the Lighthouse consensus service.
- `Dockerfile.lighthousevalidator`: Dockerfile for building the Lighthouse validator service.
- `Dockerfile.metrics-exporter`: Dockerfile for building the metrics exporter service.
- `jwtsecret.sh`: Script for generating JWT secrets for authentication.
- `keymanager.sh`: Script for managing validator keys.

## Getting Started

### Prerequisites

- Docker and Docker Compose installed on your machine.

### Configuration

1. Create a directory named `.eth` at the root of your project.
2. Inside the `.eth` directory, create a sub-directory named `ethereum-keys` where you will place your validator keys.
3. Update the `docker-compose.yml` file with the desired network configurations.
4. Set the environment variables `ETH_NETWORK` and `KEYSTORE_PASSWORD` in your environment or in a `.env` file.

### Building and Running

1. Run `docker-compose build` to build the Docker images.
2. Run `docker-compose up -d` to start the network.

### Monitoring

The setup includes Prometheus and Grafana for monitoring. Access the Grafana dashboard at `http://localhost:3000`.

## Services

- **Execution Service (Erigon)**:
  - Builds and executes blockchain transactions.
  - Exposed ports: 30303, 30304, 30305, and 42069.

- **Consensus Service (Lighthouse)**:
  - Handles the consensus protocol.
  - Exposed ports: 9000 and 9001.

- **Validator Service (Lighthouse)**:
  - Manages the validator nodes in the network.
  - Utilizes the `keymanager.sh` script to handle the copying of validator keys from the `.eth/ethereum-keys` directory to the appropriate location within the validator service container.

- **Metrics Exporters**:
  - Collects and exports metrics from the blockchain network.

- **Monitoring Tools (Prometheus and Grafana)**:
  - Provides monitoring and alerting services.

## Volumes

- Data directories and configuration files are mounted as volumes to retain data across container restarts.

## Contributing

If you would like to contribute to this project, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License.
