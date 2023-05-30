# Stage 1: Build stage
FROM node:18 AS build
WORKDIR /app

# Copy package.json to build stage
COPY package.json yarn.lock ./

# Install plugins
RUN yarn add @medusajs/admin
RUN yarn add medusa-plugin-meilisearch
RUN yarn add nodemailer

# Copy and install custom plugin
# COPY custom-plugins custom-plugins
# RUN yarn add file:./custom-plugins/medusa-plugin-nodemailer

# Install dependencies
RUN yarn install

# ------------------------------------------

# Stage 2: Production stage
FROM node:18 AS production
WORKDIR /app

# Src files
COPY . .

# Copy package.json from the build stage
COPY --from=build /app/package.json /app/package.json

# Modules
COPY --from=build /app/node_modules /app/node_modules


ENTRYPOINT ["./entrypoint.sh"]
