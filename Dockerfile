# this is good in general case but cant be used in elastic beanstalk
# as it dont support stage naming
FROM node:lts-alpine as builder
# FROM node:lts-alpine

WORKDIR '/app'
COPY ./package.json /app
RUN yarn install
COPY ./ /app
RUN yarn run build

# serving forntend using nginx
FROM nginx
# exposing port here for aws to expose it to
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# COPY --from=0 /app/build /usr/share/nginx/html