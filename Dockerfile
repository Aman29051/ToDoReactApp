# Use an official Node.js runtime as the base image
FROM node:14 as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install the project dependencies
RUN npm install

# Copy all the source code to the container
COPY . .

# Build the React app
RUN npm run build

# Use a smaller, lightweight base image for serving the built app
FROM nginx:alpine

# Copy the built files from the previous stage to the nginx public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the container's port (default is 80 for Nginx)
EXPOSE 80

# Start Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]
