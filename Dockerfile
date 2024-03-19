FROM node:lts-alpine

LABEL org.opencontainers.image.source=https://github.com/AD-SDL/squid_frontend
LABEL org.opencontainers.image.description="Dashboard for Squid and WEI"
LABEL org.opencontainers.image.licenses=MIT

# install simple http server for serving static content
RUN npm install -g http-server
RUN apk add python3
RUN apk add py3-pip
RUN python3 -m venv ./venv
RUN chmod +x venv
RUN source venv/bin/activate 
RUN pip install fastapi --break-system-packages



# make the 'app' folder the current working directory
WORKDIR /app

# copy both 'package.json' and 'package-lock.json' (if available)
COPY ./ui/package*.json ./

# install project dependencies
RUN npm install

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .

# build app for production with minification

RUN npm run build --prefix ui
RUN cd api
EXPOSE 8080
CMD [ "uvicorn", "main:app", "--port=8080" ]
