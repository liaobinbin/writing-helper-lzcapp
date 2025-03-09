FROM node:16-bookworm AS base

FROM base AS builder

WORKDIR /app
COPY . .

ENV NEXT_TELEMETRY_DISABLED=1
RUN yarn
RUN yarn run build

FROM base AS runner

WORKDIR /app

RUN adduser --uid 1001 nextjs

COPY --from=builder --chown=nextjs:node /app/ /app/

ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV production

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["yarn", "run", "start"]
