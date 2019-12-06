FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN yarn install
COPY . .
RUN yarn run build 

# The image above is temporary, we just need the resulting build to run on NGINX container we build  below
FROM nginx
## EXPOSE 80 tells elasticbeanstalk to map incomming traffic to exposed port
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# NGINX starts by default from nginx image