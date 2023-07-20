FROM node:14 as build
WORKDIR /app
COPY package*.json ./

RUN npm install
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;","0.0.0.0:8000]
