
# Dockerize the BlogApp application, you can follow these steps:

1: Create a Dockerfile Create a file named Dockerfile in the root directory of your BlogApp project
2: Build a docker image

$ docker build -t blogapp .

3. Run a Docker container based on that image. Run the following command:

$ docker run -p 3000:3000 -d blogapp && sleep 5 && curl http://<localhost>:3000/

added sleep 5 to wait for 5 seconds after starting the Docker container. This allows some time for the application to start up before making the curl request.
