FROM oven/bun:0.8
ADD  bun.lockb ./bun.lockb
ADD  package.json ./package.json
RUN  bun i
ADD  schema.prisma ./schema.prisma
RUN  bunx prisma generate
ADD  node_modules/.prisma/client ./node_modules/.prisma/client
ADD  tsconfig.json ./tsconfig.json
ADD  *.ts ./
ENTRYPOINT bun run start