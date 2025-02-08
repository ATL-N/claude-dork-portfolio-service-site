FROM node:18-alpine AS base

# Install dependencies only when needed
FROM base AS deps
WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./
RUN npm ci

# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Set build-time variables
ENV NEXT_TELEMETRY_DISABLED 1
ENV PORT 3001

RUN npm run build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app

# Install debugging tools
RUN apk add --no-cache curl netstat-nat procps

ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1
ENV PORT 3001
ENV HOSTNAME "0.0.0.0"

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy necessary files
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json

# Set the correct permission for prerender cache
RUN mkdir .next
RUN chown nextjs:nodejs .next

# Copy built application
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

EXPOSE 3001

# Add a script to verify the environment and start the server
COPY --chown=nextjs:nodejs <<'EOF' /app/start.sh
#!/bin/sh
echo "Environment variables:"
env
echo "\nStarting server on port $PORT"
exec node server.js
EOF

RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]

# CMD ["node", "server.js"]
# CMD ["npm", "start"]