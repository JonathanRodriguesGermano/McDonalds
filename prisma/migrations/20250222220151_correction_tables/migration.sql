/*
  Warnings:

  - The values [CANCELLED] on the enum `OrderStatus` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `nome` on the `MenuCategory` table. All the data in the column will be lost.
  - You are about to drop the column `createAt` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `createAt` on the `OrderProduct` table. All the data in the column will be lost.
  - You are about to drop the column `imageUlr` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `nome` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `avatarImageUlr` on the `Restaurant` table. All the data in the column will be lost.
  - You are about to drop the column `coverImageUlr` on the `Restaurant` table. All the data in the column will be lost.
  - You are about to drop the column `nome` on the `Restaurant` table. All the data in the column will be lost.
  - Added the required column `name` to the `MenuCategory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageUrl` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `avatarImageUrl` to the `Restaurant` table without a default value. This is not possible if the table is not empty.
  - Added the required column `coverImageUrl` to the `Restaurant` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Restaurant` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "OrderStatus_new" AS ENUM ('PENDING', 'IN_PREPARATION', 'FINISHED');
ALTER TABLE "Order" ALTER COLUMN "status" TYPE "OrderStatus_new" USING ("status"::text::"OrderStatus_new");
ALTER TYPE "OrderStatus" RENAME TO "OrderStatus_old";
ALTER TYPE "OrderStatus_new" RENAME TO "OrderStatus";
DROP TYPE "OrderStatus_old";
COMMIT;

-- AlterTable
ALTER TABLE "MenuCategory" DROP COLUMN "nome",
ADD COLUMN     "name" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "createAt",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "OrderProduct" DROP COLUMN "createAt",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "imageUlr",
DROP COLUMN "nome",
ADD COLUMN     "imageUrl" TEXT NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Restaurant" DROP COLUMN "avatarImageUlr",
DROP COLUMN "coverImageUlr",
DROP COLUMN "nome",
ADD COLUMN     "avatarImageUrl" TEXT NOT NULL,
ADD COLUMN     "coverImageUrl" TEXT NOT NULL,
ADD COLUMN     "name" TEXT NOT NULL;
