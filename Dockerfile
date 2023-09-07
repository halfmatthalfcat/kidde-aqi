FROM oven/bun
RUN  bun add --global prisma
ADD  bun.lockb bun.lockb
ADD  package.json package.json
ADD  schema.prisma schema.prisma
ADD  tsconfig.json tsconfig.json
ADD  *.ts ./
RUN  bun i
RUN  bun run prisma generate
ENTRYPOINT bun run index.ts