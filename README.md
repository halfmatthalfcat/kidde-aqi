# kidde-aqi

I have two [Kidde Carbon Monoxide with AQI](https://www.kidde.com/home-safety/en/us/products/smart-home/smart-carbon-monoxide-with-indoor-air-quality-monitor/) meters in my home. Kidde has an app that displays metrics, but it frankly sucks. I wanted to extract the data and store/display it on my own.

This Bun app leverages the Kidde (unofficial) API to grab all my devices and store metrics (via Prisma) in Postgres for later retreval/analysis.