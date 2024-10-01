# Use the official Node.js image as a build environment
FROM node:16 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Use a lightweight server image to serve the app
FROM nginx:alpine

# Copy the built application to Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose the specific port
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
