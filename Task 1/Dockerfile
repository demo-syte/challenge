#Dockerfile Create a file named Dockerfile in the root directory of your BlogApp project. 

# Use an official Node.js runtime as the base image
FROM node:latest

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose the port that the application will run on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "run", "start"]