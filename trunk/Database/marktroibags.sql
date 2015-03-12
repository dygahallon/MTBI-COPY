-- MySQL Script generated by MySQL Workbench
-- 03/12/15 23:46:25
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema marktroibags
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `marktroibags` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `marktroibags` ;

-- -----------------------------------------------------
-- Table `marktroibags`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`admin` (
  `id` INT(11) NOT NULL,
  `fname` VARCHAR(45) NULL DEFAULT NULL,
  `lname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `contact_no` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `marktroibags`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`company` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `shipping_address` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `marktroibags`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`user` (
  `id` INT(11) NOT NULL,
  `username` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `auth_key` VARCHAR(32) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `password_hash` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `password_reset_token` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  `email` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `role` INT(2) NOT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT '10',
  `created_at` INT(11) NOT NULL,
  `updated_at` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_ibfk_1`
    FOREIGN KEY (`id`)
    REFERENCES `marktroibags`.`admin` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `marktroibags`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`customer` (
  `id` INT(11) NOT NULL,
  `fname` VARCHAR(45) NULL DEFAULT NULL,
  `lname` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(60) NULL DEFAULT NULL,
  `contact_no` VARCHAR(25) NULL DEFAULT NULL,
  `company_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_account_company_idx` (`company_id` ASC),
  CONSTRAINT `customer_ibfk_1`
    FOREIGN KEY (`id`)
    REFERENCES `marktroibags`.`user` (`id`),
  CONSTRAINT `fk_account_company`
    FOREIGN KEY (`company_id`)
    REFERENCES `marktroibags`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `marktroibags`.`migration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`migration` (
  `version` VARCHAR(180) NOT NULL,
  `apply_time` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`version`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `marktroibags`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`product` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `admin_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_admin1_idx` (`admin_id` ASC),
  CONSTRAINT `fk_product_admin1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `marktroibags`.`admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `marktroibags`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`order` (
  `id` INT(11) NOT NULL,
  `date` VARCHAR(45) NULL DEFAULT NULL,
  `quantity` VARCHAR(45) NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `product_id` INT(11) NOT NULL,
  `admin_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_product1_idx` (`product_id` ASC),
  INDEX `fk_order_admin1_idx` (`admin_id` ASC),
  INDEX `fk_order_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_order_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `marktroibags`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_admin1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `marktroibags`.`admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `marktroibags`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `marktroibags`.`report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`report` (
  `id` INT(11) NOT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `order_id` INT(11) NOT NULL,
  `admin_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_report_order1_idx` (`order_id` ASC),
  INDEX `fk_report_admin1_idx` (`admin_id` ASC),
  CONSTRAINT `fk_report_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `marktroibags`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_admin1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `marktroibags`.`admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `marktroibags`.`promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `marktroibags`.`promotion` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `date` VARCHAR(45) NULL,
  `admin_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_promotion_admin1_idx` (`admin_id` ASC),
  CONSTRAINT `fk_promotion_admin1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `marktroibags`.`admin` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
