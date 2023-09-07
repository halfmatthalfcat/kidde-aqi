FROM oven/bun
ADD  bun.lockb bun.lockb
ADD  package.json package.json
RUN  bun i
ADD  schema.prisma schema.prisma
RUN  bun run prisma generate
RUN  mkdir ./node_modules/.prisma
# ADD  ./node_modules/.prisma ./node_modules/.prisma/
ADD  tsconfig.json tsconfig.json
ADD  *.ts ./
ENTRYPOINT bun run start