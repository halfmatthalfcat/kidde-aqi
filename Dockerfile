FROM node:18
ADD  yarn.lock ./yarn.lock
ADD  package.json ./package.json
RUN  yarn
ADD  schema.prisma ./schema.prisma
RUN  npx prisma generate
ADD  tsconfig.json ./tsconfig.json
ADD  *.ts ./
ENTRYPOINT yarn run start