# FROM node:14-alpine AS development
# ENV NODE_ENV development
# # Add a work directory
# WORKDIR /app
# # Cache and Install dependencies
# COPY package.json .
# COPY yarn.lock .
# RUN npm install
# # Copy app files
# COPY . .
# # Expose port
# EXPOSE 4000
# # Start the app
# CMD [ "npm", "start" ]

FROM node:14-alpine

RUN mkdir /build
WORKDIR /build

COPY my-portfolio /build

# COPY app/requirements.txt /build

RUN npm isntall

EXPOSE 4000

CMD [ "npm", "start" ]
