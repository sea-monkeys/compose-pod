FROM node:slim
LABEL maintainer="@k33g_org"

WORKDIR /app

COPY redirect.js .

CMD ["node", "redirect.js"]