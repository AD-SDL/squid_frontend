FROM node:lts-alpine

LABEL org.opencontainers.image.source=https://github.com/AD-SDL/squid_frontend
LABEL org.opencontainers.image.description="Dashboard for Squid and WEI"
LABEL org.opencontainers.image.licenses=MIT

# install fastapi
RUN apk add python3
RUN apk add py3-pip
RUN pip install fastapi --break-system-packages
RUN pip install uvicorn --break-system-packages



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
WORKDIR /app/api
CMD [ "python", "-m",  "uvicorn", "main:app", "--host=0.0.0.0", "--port=8080" ]
