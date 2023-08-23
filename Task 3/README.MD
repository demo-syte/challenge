# Steps:

    Docker Hub account 
    then create a repository on Docker Hub for your BlogApp.
    Add use Docker Hub username and password as secrets in  GitHub repository settings. We can name them DOCKER_HUB_USERNAME and DOCKER_HUB_PASSWORD respectively.

## Deploying to EC2:

    Builds the Docker image.
    Logs into Docker Hub.
    Tags the image with your Docker Hub username and the repository name.
    Pushes the Docker image to Docker Hub.
    SSHs into your EC2 instance, pulls the Docker image from Docker Hub, stops any previous instance of the blogapp container, and then starts a new one.
## Ensure:

    We have  granted necessary permissions for  GitHub Actions runner to push to  Docker Hub repository.
    Docker is installed on  EC2 instance which we already did in previous steps.
    We've set up SSH keys and/or credentials appropriately for the ssh command to work without requiring a password.
