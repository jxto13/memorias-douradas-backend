# Stage 1: Build stage
FROM node:18 AS build
WORKDIR /app

# Copy package.json to build stage
COPY package.json yarn.lock ./

# Install plugins
RUN yarn add @medusajs/admin
RUN yarn add medusa-plugin-meilisearch

# Install dependencies
RUN yarn install

# ------------------------------------------

# Stage 2: Production stage
FROM node:18 AS production
WORKDIR /app

# Copy package.json from the build stage
COPY --from=build /app/package.json /app/package.json

# Modules
COPY --from=build /app/node_modules /app/node_modules

# Src files
COPY . .

ENTRYPOINT ["./entrypoint.sh"]
