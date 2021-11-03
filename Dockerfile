#
# ---- Dependencies ----
FROM node:17-alpine3.14@sha256:46d3668a8435fef267bc7e215b5ebbef0a34c461365549ebea0cee00b386a6df AS base

WORKDIR /app

COPY package.json .

RUN npm set progress=false && npm config set depth 0

RUN npm install --only=production 
# copy production node_modules aside
RUN cp -R node_modules prod_node_modules
# install ALL node_modules, including 'devDependencies'
RUN npm install


#
# ---- Release ----
FROM node:17-alpine3.14@sha256:46d3668a8435fef267bc7e215b5ebbef0a34c461365549ebea0cee00b386a6df AS release

WORKDIR /app

RUN apk --no-cache add dumb-init

# Remove package manager
RUN rm -rf /sbin/apk /etc/apk /lib/apk /usr/share/apk /var/lib/apk

# copy production node_modules
COPY --from=base /app/prod_node_modules ./node_modules
# copy app sources
COPY --chown=node:node . .
# expose port and define CMD
USER node

EXPOSE 8080

CMD ["dumb-init", "node", "server.js"]