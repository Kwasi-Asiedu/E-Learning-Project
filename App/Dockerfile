# Base image from which dockerfile is built 
FROM nginx:latest

RUN apt-get update 
RUN apt-get install -y nginx

WORKDIR /usr/share/nginx/html

COPY tokyo-1.0 /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443

#ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
CMD ["nginx", "-g", "daemon off;"]
