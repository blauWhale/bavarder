-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bavarder
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bavarder
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bavarder` DEFAULT CHARACTER SET utf8 ;
USE `bavarder` ;

-- -----------------------------------------------------
-- Table `bavarder`.`pizza_size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bavarder`.`pizza_size` ;

CREATE TABLE IF NOT EXISTS `bavarder`.`pizza_size` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `diameter` FLOAT NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bavarder`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bavarder`.`role` ;

CREATE TABLE IF NOT EXISTS `bavarder`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bavarder`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bavarder`.`address` ;

CREATE TABLE IF NOT EXISTS `bavarder`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(255) NOT NULL,
  `post_code` INT NOT NULL,
  `streetname` VARCHAR(255) NOT NULL,
  `housenumber` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bavarder`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bavarder`.`person` ;

CREATE TABLE IF NOT EXISTS `bavarder`.`person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `gender` ENUM('MAN', 'WOMAN', 'NONBINARY') NOT NULL,
  `email_address` VARCHAR(255) NOT NULL,
  `phonenumber` VARCHAR(12) NOT NULL,
  `roles_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_natural_person_roles_idx` (`roles_id` ASC) VISIBLE,
  INDEX `fk_natural_person_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_natural_person_roles`
    FOREIGN KEY (`roles_id`)
    REFERENCES `bavarder`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_natural_person_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `bavarder`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bavarder`.`ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bavarder`.`ingredients` ;

CREATE TABLE IF NOT EXISTS `bavarder`.`ingredients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `price` FLOAT NOT NULL,
  `quantity` FLOAT NOT NULL,
  `supplier_person` INT NOT NULL,
  `vegetarian` TINYINT NULL,
  `vegan` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ingredients_person1_idx` (`supplier_person` ASC) VISIBLE,
  CONSTRAINT `fk_ingredients_person1`
    FOREIGN KEY (`supplier_person`)
    REFERENCES `bavarder`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bavarder`.`pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bavarder`.`pizza` ;

CREATE TABLE IF NOT EXISTS `bavarder`.`pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `pizza_size_id` INT NOT NULL,
  `ingredients_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pizza_pizza_size1_idx` (`pizza_size_id` ASC) VISIBLE,
  INDEX `fk_pizza_ingredients1_idx` (`ingredients_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_pizza_size1`
    FOREIGN KEY (`pizza_size_id`)
    REFERENCES `bavarder`.`pizza_size` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_ingredients1`
    FOREIGN KEY (`ingredients_id`)
    REFERENCES `bavarder`.`ingredients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bavarder`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bavarder`.`order` ;

CREATE TABLE IF NOT EXISTS `bavarder`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `natural_person_id` INT NOT NULL,
  `price` FLOAT NOT NULL,
  `trackingnumber` INT NULL,
  `delivered` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_natural_person1_idx` (`natural_person_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_natural_person1`
    FOREIGN KEY (`natural_person_id`)
    REFERENCES `bavarder`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bavarder`.`pizza_has_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bavarder`.`pizza_has_order` ;

CREATE TABLE IF NOT EXISTS `bavarder`.`pizza_has_order` (
  `id` INT NOT NULL,
  `pizza_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`, `pizza_id`, `order_id`),
  INDEX `fk_pizza_has_order_order1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_pizza_has_order_pizza1_idx` (`pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_has_order_pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `bavarder`.`pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_has_order_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `bavarder`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




insert into pizza_size (id, diameter, price) values (1, 5, 14);
insert into pizza_size (id, diameter, price) values (2, 23, 15);
insert into pizza_size (id, diameter, price) values (3, 16, 15);
insert into pizza_size (id, diameter, price) values (4, 19, 13);
insert into pizza_size (id, diameter, price) values (5, 25, 14);

insert into address (id, city, post_code, streetname, housenumber) values (1, 'Huangtan', 83, '27082 Westerfield Park', '67733');
insert into address (id, city, post_code, streetname, housenumber) values (2, 'Wilwerwiltz', 53, '9070 Derek Pass', '6');
insert into address (id, city, post_code, streetname, housenumber) values (3, 'Banxi', 35, '7 Continental Crossing', '6006');
insert into address (id, city, post_code, streetname, housenumber) values (4, 'Le Blanc-Mesnil', 96, '7 Sutherland Plaza', '3');
insert into address (id, city, post_code, streetname, housenumber) values (5, 'Berlin', 55, '33321 Blaine Junction', '94837');

insert into bavarder.role (id, role) values (1, 'CUSTOMER');
insert into bavarder.role (id, role) values (2, 'MANAGER');
insert into bavarder.role (id, role) values (3, 'EMPLOYEE');
insert into bavarder.role (id, role) values (4, 'SUPPLIER');

insert into person (id, firstname, lastname, gender, email_address, phonenumber, roles_id, address_id) values (1, 'Martie', 'Revel', 'MAN', 'mrevel0@buzzfeed.com', '943-644-3949', 1, 1);
insert into person (id, firstname, lastname, gender, email_address, phonenumber, roles_id, address_id) values (2, 'Shurlocke', 'Riccardelli', 'NONBINARY', 'sriccardelli1@weibo.com', '189-948-3700', 2, 2 );
insert into person (id, firstname, lastname, gender, email_address, phonenumber, roles_id, address_id) values (3, 'Huntley', 'Sandle', 'MAN', 'hsandle2@auda.org.au', '191-214-9752', 2, 3);
insert into person (id, firstname, lastname, gender, email_address, phonenumber, roles_id, address_id) values (4, 'Jacquette', 'Hirtzmann', 'WOMAN', 'jhirtzmann3@facebook.com', '884-257-9859', 3, 4);
insert into person (id, firstname, lastname, gender, email_address, phonenumber, roles_id, address_id) values (5, 'Darsie', 'Thewys', 'WOMAN', 'dthewys4@fema.gov', '834-803-7809', 2, 5);

insert into ingredients (id, name, price, quantity, supplier_person, vegetarian, vegan) values (1, 'Durango', 2, 49, 4, false, true);
insert into ingredients (id, name, price, quantity, supplier_person, vegetarian, vegan) values (2, 'Fusion', 1, 90, 4, true, false);
insert into ingredients (id, name, price, quantity, supplier_person, vegetarian, vegan) values (3, 'C-Class', 5, 91, 4, false, false);
insert into ingredients (id, name, price, quantity, supplier_person, vegetarian, vegan) values (4, 'Miata MX-5', 2, 58, 4, false, true);
insert into ingredients (id, name, price, quantity, supplier_person, vegetarian, vegan) values (5, 'F150', 1, 60, 4, false, true);

insert into pizza (id, name, pizza_size_id, ingredients_id) values (1, 'California Pizza', 4, 2);
insert into pizza (id, name, pizza_size_id, ingredients_id) values (2, 'New York-Style Pizza', 1, 1);
insert into pizza (id, name, pizza_size_id, ingredients_id) values (3, 'Detroit Pizza', 3, 5);
insert into pizza (id, name, pizza_size_id, ingredients_id) values (4, 'Greek Pizza', 1, 1);
insert into pizza (id, name, pizza_size_id, ingredients_id) values (5, 'Sicilian Pizza', 2, 5);

insert into bavarder.order (id, natural_person_id, price, trackingnumber, delivered) values (1, 1, 30, 15, true);
insert into bavarder.order  (id, natural_person_id, price, trackingnumber, delivered) values (2, 2, 28, 9, true);
insert into bavarder.order  (id, natural_person_id, price, trackingnumber, delivered) values (3, 3, 22, 1, true);
insert into bavarder.order  (id, natural_person_id, price, trackingnumber, delivered) values (4, 4, 29, 2, false);
insert into bavarder.order  (id, natural_person_id, price, trackingnumber, delivered) values (5, 5, 20, 10, true);

insert into pizza_has_order (id, pizza_id, order_id, quantity) values (1, 1, 1, 1);
insert into pizza_has_order (id, pizza_id, order_id, quantity) values (2, 4, 1, 1);
insert into pizza_has_order (id, pizza_id, order_id, quantity) values (3, 3, 2, 1);
insert into pizza_has_order (id, pizza_id, order_id, quantity) values (4, 3, 3, 2);
insert into pizza_has_order (id, pizza_id, order_id, quantity) values (5, 3, 4, 1);



