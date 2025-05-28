# custom-sshkeyscan-timeout
# Custom SSH Keyscan Timeout  for Okteto Pipelines

> This repository is provided by the community and Okteto does not officially support it.

## Overview

This repository helps you configure Okteto with predefined SSH host keys when your cluster has limited outbound connectivity, particularly when direct access to port 22 is restricted.

By default, Okteto uses `ssh-keyscan` to dynamically retrieve public SSH keys from source control servers, which requires outbound access on port 22. In certain conditions, the default timeout might not be enoughThis repository provides an alternative solution by setting up a custom timeout for ssh-keyscan and a custom pipeline runner image.

## Setup Instructions

### 1. Customize your timeout and other ssh-keyscan options

Update the `alias` in the `bashrc` file with your required values.

### 2. Build and Push the Custom Image

Build the container image, setting `OKTETO_VERSION` to match your installed Okteto Platform version:

```bash
# Replace 1.31.0 with your Okteto version
docker build -t your-registry/pipeline-runner-custom-known-hosts:1.31.0 --build-arg=OKTETO_VERSION=1.31.0 .

# Push to your container registry
docker push your-registry/pipeline-runner-custom-known-hosts:1.31.0
```

### 3. Update Helm Configuration

Add the `installer` section to your Helm configuration file (e.g. `values.yaml`), specifying your custom image:

```yaml
installer:
  runner:
    registry: your-registry
    repository: pipeline-runner-custom-known-hosts
    tag: 1.32.0
```

### 4. Upgrade Your Okteto Installation

Apply the changes to your Okteto installation:

```bash
helm upgrade --install okteto okteto/okteto -f values.yaml
```

## Verification

After applying these changes, Okteto will use your static `known_hosts` list when cloning repositories during:
- UI operations
- `okteto pipeline` commands
- `okteto preview` commands

## Tested Versions
This community contribution was tested in Okteto 1.32.0

## Troubleshooting

If you encounter SSH key verification errors:
1. Verify your `alias` in the `bashrc` file contains the correct and up-to-date values
2. Ensure the custom image was successfully built and is being used by Okteto

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.
