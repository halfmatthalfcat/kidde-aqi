FROM oven/bun:0.8
ADD  bun.lockb ./bun.lockb
ADD  package.json ./package.json
RUN  bun i
ADD  node_modules ./node_modules
ADD  schema.prisma ./schema.prisma
RUN  bunx prisma generate
ADD  node_modules/.prisma ./node_modules/.prisma
ADD  tsconfig.json ./tsconfig.json
ADD  *.ts ./
ENTRYPOINT bun run start