import config from "./config.ts";

interface KiddeAuth {
  access_token: string;
}
const key = await fetch("https://api.homesafe.kidde.com/api/v4/auth/login", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    email: config.KIDDE_EMAIL,
    password: config.KIDDE_PASSWORD,
    timezone: "America/Chicago",
  }),
})
  .then<KiddeAuth>((r) => r.json())
  .then((body) => body.access_token);

const authHeaders = {
  cookie: `session=${key}`,
};

interface Location {
  id: number;
  label: string;
}
const locations = await fetch(
  "https://api.homesafe.kidde.com/api/v4/location",
  {
    headers: authHeaders,
  }
)
  .then<Array<Location>>((r) => r.json())
  .then((body) => body.map((l) => l.id));

interface Metric {
  value: number;
  status: string;
  Unit: string;
}
interface Device {
  id: number;
  label: string;
  last_seen: string;
  serial_number: string;
  co_level: number;
  iaq_temperature: Metric;
  humidity: Metric;
  hpa: Metric;
  tvoc: Metric;
  iaq: Metric;
  co2: Metric;
}
export const getDevices: () => Promise<Array<Device>> = () =>
  Promise.all(
    locations.map((l) =>
      fetch(`https://api.homesafe.kidde.com/api/v4/location/${l}/device`, {
        headers: authHeaders,
      }).then<Array<Device>>((r) => r.json())
    )
  ).then((results) => results.flat());
