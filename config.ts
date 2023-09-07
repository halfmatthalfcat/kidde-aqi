import { cleanEnv, str } from "envalid";

export default cleanEnv(process.env, {
  KIDDE_EMAIL: str(),
  KIDDE_PASSWORD: str(),
  CRON: str({ default: "* * * * *" }),
});
