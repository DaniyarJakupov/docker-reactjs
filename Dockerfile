# Use node image for builder stage
FROM node:alpine as builder

# Create a dir for the app
WORKDIR /reactapp

# Copy package.json to /reactapp folder inside docker image
COPY package.json .

# Install dependencies
RUN npm install

# Copy everything to /reactapp folder inside docker image
COPY . .

# Tell the image what to do when it starts as a container
# a.k.a Default command
CMD ["npm", "run", "build"]

# Run stage
FROM nginx
COPY --from=builder /reactapp/build /usr/share/nginx/html