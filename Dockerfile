# Use official Node.js image as the base image
FROM node:latest AS builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install dependencies
RUN npm install

# Copy the entire project
COPY . .

# Build the Angular app
RUN ng build 

# Use Nginx image as the base image for serving Angular application
FROM nginx:alpine

# Copy the built Angular app from the 'builder' stage to the NGINX html directory
COPY --from=builder /app/dist/sample2-angular/browser /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
