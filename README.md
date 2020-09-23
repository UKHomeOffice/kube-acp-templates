# ACP Kubernetes Template Files

This repo presents a nice place to store a few template files in relation to the following:

- Kube Templates:
  - Deployment Template (+ Redis Deployment)
  - Service Template (+ Redis Port Handling)
  - Ingress Template
  - Network Policy Template
  - ConfigMap Template
  - Secret Template
  - Bash Script For Manually Deploying Secrets

- Drone Templates:
  - Drone Template
  - NPMRC Template
  - Dockerfile Template

- Helper Scripts

## Kube Templates

- *Deployment* - Templates including a redis deployment, or a separated redis deployment and service file so sessions are not lost when updating an application in production.
- *Service* - Templates which route traffic from your ingress to your deployments.
- *Ingress* - Template with annotations specific to ACP's Kubernetes clusters to automatically request LetsEncrypt HTTPS certificates and redirect HTTP direct to HTTPS for security. Hooks internet traffic making requests to the specified domain name and routes HTTPS traffic on port 443 to your Service file.
- *Network Policy* - Template which overrides the ACP Deny All traffic network policy to whitelist network traffic in your namespace.
- *ConfigMap* - Template for setting up publicly accessible environmental variables which are NOT secret for easier management by the ops team. Also to share environment specific variables to multiple applications in the same namespace.
- *Secret* - Template for creating a Kubernetes secret.
- *Bash Scripts* - Bash scripts for manually deploying secrets into your Kubernetes cluster.

## Drone Templates

- *Drone* - Template for setting up Drone builds and deployments in your Kubernetes namespace. For updating deployments and using Slack hooks to send messages to your relevant deployment Slack channel.
- *NPMRC* - Template for setting up access to NPM install private dependencies in Artifactory when required to run in a Dockerfile during a Drone build.
- *Dockerfile* - For setting up a fresh build of an application in an isolated working virtual environment that is then stored either publicly in Quay.io or privately in either Artifactory or AWS ECR.

## Helper Scripts

Helper scripts for updating Kubernetes files using the kubectl tool and managing deployments and updates.
