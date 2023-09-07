-- CreateTable
CREATE TABLE "Device" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Device_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Metric" (
    "deviceId" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "temp" DECIMAL(65,30) NOT NULL,
    "hpa" INTEGER NOT NULL,
    "tvoc" DECIMAL(65,30) NOT NULL,
    "iaq" DECIMAL(65,30) NOT NULL,
    "co2" DECIMAL(65,30) NOT NULL,
    "humidity" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "Metric_pkey" PRIMARY KEY ("deviceId","timestamp")
);

-- AddForeignKey
ALTER TABLE "Metric" ADD CONSTRAINT "Metric_deviceId_fkey" FOREIGN KEY ("deviceId") REFERENCES "Device"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
