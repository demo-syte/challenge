# What's happening here:

Building Docker Image: We're building the Docker image directly from the checked-out code and our Dockerfile.

Archiving the Docker Image: After building, the Docker image is saved as a tarball, which makes it easier to transfer to the EC2 instance.

## Deploying to EC2:

The tarball is copied to the EC2 instance.
We then load the Docker image from the tarball into the Docker daemon on the EC2 instance.
Before running the new Docker container, we attempt to stop any running container named blogapp. The || true ensures that the command succeeds even if the blogapp container doesn't exist.
Finally, we run the Docker container with the name blogapp
