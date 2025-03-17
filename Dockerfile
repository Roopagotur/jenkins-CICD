# Use official Node.js image for Angular build
FROM node:22-alpine as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all source files
COPY . .

# Build the Angular application
RUN npm run build --configuration=production

# Use Nginx for serving Angular application
FROM nginx:latest
COPY --from=build /app/dist/angular-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
