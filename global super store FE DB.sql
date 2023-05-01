-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema global_super_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema global_super_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `global_super_store` DEFAULT CHARACTER SET utf8 ;
USE `global_super_store` ;

-- -----------------------------------------------------
-- Table `global_super_store`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Customer` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(45) NULL,
  `ContactDetails` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `global_super_store`.`Delivary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Delivary` (
  `addressID` INT NOT NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `postalCode` INT NULL,
  PRIMARY KEY (`addressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `global_super_store`.`shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`shipping` (
  `shippingID` INT NOT NULL,
  `shippingDate` DATE NULL,
  `shippingMode` VARCHAR(45) NULL,
  `shippingcost` DECIMAL NULL,
  `addressId` INT NULL,
  PRIMARY KEY (`shippingID`),
  INDEX `addressId_idx` (`addressId` ASC) VISIBLE,
  CONSTRAINT `addressId`
    FOREIGN KEY (`addressId`)
    REFERENCES `global_super_store`.`Delivary` (`addressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `global_super_store`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Products` (
  `productID` INT NOT NULL,
  `productname` VARCHAR(45) NULL,
  `productprice` DECIMAL NULL,
  `category` VARCHAR(45) NULL,
  `subcategory` VARCHAR(45) NULL,
  PRIMARY KEY (`productID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `global_super_store`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `global_super_store`.`Orders` (
  `OrdersID` INT NOT NULL,
  `Ordersdate` DATE NULL,
  `totalcost` DECIMAL NULL,
  `quantity` INT NULL,
  `OrderPriority` VARCHAR(255) NULL,
  `discount` DECIMAL NULL,
  `customerID` INT NULL,
  `shippingID` INT NULL,
  `productID` INT NULL,
  PRIMARY KEY (`OrdersID`),
  INDEX `shippingID_idx` (`shippingID` ASC) VISIBLE,
  INDEX `customerID_idx` (`customerID` ASC) VISIBLE,
  INDEX `productId_idx` (`productID` ASC) VISIBLE,
  CONSTRAINT `customerID`
    FOREIGN KEY (`customerID`)
    REFERENCES `global_super_store`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `shippingID`
    FOREIGN KEY (`shippingID`)
    REFERENCES `global_super_store`.`shipping` (`shippingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `productId`
    FOREIGN KEY (`productID`)
    REFERENCES `global_super_store`.`Products` (`productID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
