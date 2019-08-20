#First step is the builder process 

FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
#Now build the production build on this builder phase image which is required later
RUN npm run build

#This is the run phase which takes the build folder from above and executes

FROM nginx
# --from=builder denotes that take the build folder from above mid generated image in the builder phase
COPY --from=builder /app/build /usr/share/nginx/html

#We dont need a CMD here as by default an nginx will start the ports 