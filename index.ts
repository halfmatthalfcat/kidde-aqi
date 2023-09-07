import { PrismaClient } from "@prisma/client";
import cron from "node-cron";
import config from "./config";
import { getDevices } from "./kidde";
const prisma = new PrismaClient();

cron.schedule(config.CRON, async () => {
  const devices = await getDevices();

  for (const device of devices) {
    let existingDevice = await prisma.device.findFirst({
      where: { id: device.serial_number },
    });

    if (!existingDevice) {
      existingDevice = await prisma.device.create({
        data: {
          id: device.serial_number,
          name: device.label,
        },
      });
    }

    const metricExists = await prisma.metric.findFirst({
      where: {
        deviceId: device.serial_number,
        timestamp: device.last_seen,
      },
    });

    if (!metricExists) {
      const { co_level, iaq, iaq_temperature, humidity, hpa, tvoc, co2 } =
        device;

      await prisma.metric.create({
        data: {
          deviceId: device.serial_number,
          timestamp: device.last_seen,
          temp: iaq_temperature.value,
          hpa: hpa.value,
          tvoc: tvoc.value,
          iaq: iaq.value,
          co: co_level,
          co2: co2.value,
          humidity: humidity.value,
        },
      });
    }
  }
});
