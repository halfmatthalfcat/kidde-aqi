/*
  Warnings:

  - Added the required column `co` to the `Metric` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Metric" ADD COLUMN     "co" DECIMAL(65,30) NOT NULL;
