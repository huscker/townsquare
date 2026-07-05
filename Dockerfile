# ^1
# Stage 1: Build the Vue.js frontend
FROM node:20-bookworm-slim AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# _________________________________________________________________
# Stage 2: Frontend image (nginx serving static files)
FROM nginxinc/nginx-unprivileged:1.27-alpine AS frontend

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /app

USER 101

EXPOSE 8080

# _________________________________________________________________
# Stage 3: Backend image (Node.js WebSocket server)
FROM node:20-bookworm-slim AS backend

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --omit=dev

COPY server/ ./server/

ENV NODE_ENV=production
ENV USE_TLS=false
ENV SERVER_PORT=8080

EXPOSE 8080

CMD ["node", "server/index.js"]
