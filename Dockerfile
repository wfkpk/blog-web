FROM node:18 AS builder

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm

RUN pnpm install

COPY . .

RUN pnpm build
FROM node:18
WORKDIR /app
COPY --from=builder /app /app
EXPOSE 3008
ENV NODE_ENV=production

CMD ["pnpm", "start", "--port", "3008"]
