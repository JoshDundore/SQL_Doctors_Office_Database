-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8mb4 ;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `hospital`.`billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`billing` (
  `billingID` BIGINT NOT NULL,
  `billingType` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL DEFAULT NULL,
  `fees` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`billingID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `hospital`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`person` (
  `personID` BIGINT NOT NULL,
  `fName` VARCHAR(45) NULL DEFAULT NULL,
  `lName` VARCHAR(45) NULL DEFAULT NULL,
  `streetAddress` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `state` CHAR(5) NULL DEFAULT NULL,
  `zip` INT(11) NULL DEFAULT NULL,
  `primaryNumber` BIGINT NULL DEFAULT NULL,
  `ssn` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`personID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `hospital`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`doctor` (
  `doctorID` VARCHAR(11) NOT NULL,
  `personID` BIGINT NULL DEFAULT NULL,
  `doctor_fName` VARCHAR(45) NULL DEFAULT NULL,
  `doctor_Lname` VARCHAR(45) NULL DEFAULT NULL,
  `medicalDegrees` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`doctorID`),
  INDEX `fk_personID` (`personID` ASC),
  CONSTRAINT `fk_personID`
    FOREIGN KEY (`personID`)
    REFERENCES `hospital`.`person` (`personID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `hospital`.`doctorspecialty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`doctorspecialty` (
  `specialtyID` BIGINT NOT NULL,
  `doctorID` VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (`specialtyID`),
  INDEX `fk_doctorID` (`doctorID` ASC),
  CONSTRAINT `fk_doctorID`
    FOREIGN KEY (`doctorID`)
    REFERENCES `hospital`.`doctor` (`doctorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `hospital`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`patient` (
  `patientID` BIGINT NOT NULL,
  `personID` BIGINT NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `secondaryNumber` BIGINT(100) NULL DEFAULT NULL,
  PRIMARY KEY (`patientID`),
  INDEX `fkp_personID` (`personID` ASC),
  CONSTRAINT `fkp_personID`
    FOREIGN KEY (`personID`)
    REFERENCES `hospital`.`person` (`personID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `hospital`.`patientvisit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`patientvisit` (
  `visitID` INT(11) NOT NULL,
  `patientID` BIGINT NULL DEFAULT NULL,
  `doctorID` VARCHAR(11) NULL DEFAULT NULL,
  `visitDate` DATE NULL DEFAULT NULL,
  `docNote` VARCHAR(45) NULL DEFAULT NULL,
  `billingID` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`visitID`),
  INDEX `fkp_patientID` (`patientID` ASC),
  INDEX `fkd_doctorID` (`doctorID` ASC),
  INDEX `fk_billingID_idx` (`billingID` ASC),
  CONSTRAINT `fkd_doctorID`
    FOREIGN KEY (`doctorID`)
    REFERENCES `hospital`.`doctor` (`doctorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkp_patientID`
    FOREIGN KEY (`patientID`)
    REFERENCES `hospital`.`patient` (`patientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_billingID`
    FOREIGN KEY (`billingID`)
    REFERENCES `hospital`.`billing` (`billingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `hospital`.`medicaltest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`medicaltest` (
  `prescriptionID` INT(11) NOT NULL,
  `visitID` INT(11) NULL DEFAULT NULL,
  `testResult` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`prescriptionID`),
  INDEX `fk_visitID` (`visitID` ASC),
  CONSTRAINT `fk_visitID`
    FOREIGN KEY (`visitID`)
    REFERENCES `hospital`.`patientvisit` (`visitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `hospital`.`prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`prescription` (
  `prescriptionID` INT(11) NULL DEFAULT NULL,
  `prescriptionName` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `fk_prescriptionID` (`prescriptionID` ASC),
  CONSTRAINT `fk_prescriptionID`
    FOREIGN KEY (`prescriptionID`)
    REFERENCES `hospital`.`medicaltest` (`prescriptionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `hospital`.`specialty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`specialty` (
  `specialtyName` VARCHAR(20) NULL DEFAULT NULL,
  `specialtyID` BIGINT NULL DEFAULT NULL,
  INDEX `fk_specialtyID` (`specialtyID` ASC),
  CONSTRAINT `fk_specialtyID`
    FOREIGN KEY (`specialtyID`)
    REFERENCES `hospital`.`doctorspecialty` (`specialtyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ---------------------------------------------------
-- Table `hospital` .`audit_table`
-- ---------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`audit_table` (
  `doctorID` VARCHAR(11) NULL DEFAULT NULL,
  `action` VARCHAR(20) NULL DEFAULT NULL,
  `specialtyID` BIGINT  NULL DEFAULT NULL,
  `dateofMod` DATE NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

USE `hospital` ;

-- -----------------------------------------------------
-- Placeholder table for view `hospital`.`alldoctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`alldoctors` (`doctor_FName` INT, `doctor_LName` INT, `specialtyName` INT);

-- -----------------------------------------------------
-- Placeholder table for view `hospital`.`prescribes_vicodin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospital`.`prescribes_vicodin` (`doctor_FName` INT, `doctor_LName` INT);

-- -----------------------------------------------------
-- View `hospital`.`alldoctors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`alldoctors`;
USE `hospital`;
CREATE  OR REPLACE VIEW alldoctors 
AS SELECT hospital.doctor.doctor_fName AS doctor_FName,
        hospital.doctor.doctor_Lname AS doctor_LName,
        hospital.specialty.specialtyName AS specialtyName
    FROM((((hospital.doctor
        JOIN hospital.doctorspecialty)
        JOIN hospital.specialty)
        JOIN hospital.doctorspecialty doctorjoin ON (hospital.doctorspecialty.doctorID = hospital.doctor.doctorID))
        JOIN hospital.specialty visitjoin ON (hospital.specialty.specialtyID = hospital.doctorspecialty.specialtyID))
    GROUP BY hospital.doctor.doctor_fName , hospital.doctor.doctor_Lname , hospital.specialty.specialtyName;

select * FROM alldoctors;

-- -----------------------------------------------------
-- View `hospital`.`prescribes_vicodin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`prescribes_vicodin`;
USE `hospital`;
CREATE  OR REPLACE VIEW prescribes_vicodin
AS SELECT doctor.doctor_FName, doctor.doctor_LName
FROM (doctor, prescription, patientvisit, medicaltest)
Join patientvisit as patientJoin on patientvisit.doctorID = doctor.doctorID
Join patientvisit as visitJoin on patientvisit.visitID = medicaltest.visitID
Join medicaltest as testjoin on medicaltest.prescriptionID = prescription.prescriptionID
WHERE prescriptionName = "Vicodin"
group by doctor.doctor_FName, doctor.doctor_LName; 

select * FROM prescribes_vicodin;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- View `hospital`. `Robert_Retirement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`Robert_Retires`;
USE `hospital`;
CREATE  OR REPLACE VIEW Robert_Retires
AS SELECT person.fName, person.lName
FROM (person, doctor, patientvisit, patient)
join doctor as doc on doctor.doctorID = patientvisit.doctorID
join patientvisit as vis on patientvisit.patientID = patient.patientID
join patient as pat on patient.personID = person.personID
WHERE doctor.doctor_fName = 'Robert' and doctor.doctor_Lname = 'Stevens'
group by person.fName, person.lName;

select * FROM Robert_Retires;

DELIMITER $$
USE `hospital`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hospital`.`doctorspecialty_AFTER_INSERT` AFTER INSERT ON `doctorspecialty` FOR EACH ROW
BEGIN
	INSERT INTO audit_table VALUES (NEW.doctorID, 'insert', NEW.specialtyID, NOW());
END$$

USE `hospital`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hospital`.`doctorspecialty_AFTER_UPDATE` AFTER UPDATE ON `doctorspecialty` FOR EACH ROW
BEGIN
	IF OLD.specialtyID <> new.specialtyID THEN
		INSERT INTO audit_table VALUES (OLD.doctorID, 'update', NEW.specialtyID, NOW());
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `hospital`.`billing`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`billing` (`billingID`, `billingType`, `description`, `fees`) VALUES (111295, 'Credit', 'Visa', 51.20);
INSERT INTO `hospital`.`billing` (`billingID`, `billingType`, `description`, `fees`) VALUES (111583, 'Insurance', 'UnitedHealthCare', 48.70);
INSERT INTO `hospital`.`billing` (`billingID`, `billingType`, `description`, `fees`) VALUES (111229, 'Apple Pay', 'Mastercard', 78.29);
INSERT INTO `hospital`.`billing` (`billingID`, `billingType`, `description`, `fees`) VALUES (111456, 'Debit', 'Visa', 12.32);
INSERT INTO `hospital`.`billing` (`billingID`, `billingType`, `description`, `fees`) VALUES (654322, 'Credit', 'Visa', 13.55);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`person`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (928343019, 'John', 'Hamilton', '21st Street', 'Los Angeles', 'CA', 90001, 9492388899, 738472938);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (123456789, 'Michelle', 'Langston', '23 San Leandro', 'Newport Beach', 'CA', 91234, 9497283747, 923847562);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (987236481, 'Michael', 'Phelps', '132 University', 'Orange', 'CA', 93827, 7149289999, 123456789);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (129847593, 'Janice', 'Chen', '89 Lakeview', 'Tustin', 'CA', 90382, 6572930022, 837465839);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (982734859, 'Steve', 'Gates', '57 State College', 'Fullerton', 'CA', 92831, 5158391838, 987654321);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (986716283, 'Dave', 'Johnson', '17 Sesame', 'Fullerton', 'CA', 92813, 8716171711, 871642678);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (983887281, 'Kasey', 'Lim', '28 State College', 'Fullerton', 'CA', 93718, 7142228888, 657483920);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (999123892, 'Jake', 'Kensington', '89 Second St', 'San Gabriel', 'CA', 97262, 6572938102, 999922278);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (238943879, 'Stephanie', 'Dang', '10 Rosemary', 'Lake Forest', 'CA', 92781, 8881293742, 918273647);
INSERT INTO `hospital`.`person` (`personID`, `fName`, `lName`, `streetAddress`, `city`, `state`, `zip`, `primaryNumber`, `ssn`) VALUES (118536863, 'Robert', 'Stevens', '29 Lincoln', 'Irvine', 'CA', 92602, 8888624198, 862471962);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`doctor`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`doctor` (`doctorID`, `personID`, `doctor_fName`, `doctor_Lname`, `medicalDegrees`) VALUES ('ST2048', 982734859, 'Steve', 'Gates', 'MD');
INSERT INTO `hospital`.`doctor` (`doctorID`, `personID`, `doctor_fName`, `doctor_Lname`, `medicalDegrees`) VALUES ('KL3819', 983887281, 'Kasey', 'Lim', 'MD');
INSERT INTO `hospital`.`doctor` (`doctorID`, `personID`, `doctor_fName`, `doctor_Lname`, `medicalDegrees`) VALUES ('JK8192', 999123892, 'Jake', 'Kensington', 'MD');
INSERT INTO `hospital`.`doctor` (`doctorID`, `personID`, `doctor_fName`, `doctor_Lname`, `medicalDegrees`) VALUES ('SD9128', 238943879, 'Stephanie', 'Dang', 'MD');
INSERT INTO `hospital`.`doctor` (`doctorID`, `personID`, `doctor_fName`, `doctor_Lname`, `medicalDegrees`) VALUES ('RS7429', 118536863, 'Robert', 'Stevens', 'MD');

COMMIT;



-- -----------------------------------------------------
-- Data for table `hospital`.`doctorspecialty`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`doctorspecialty` (`specialtyID`, `doctorID`) VALUES (000000000, 'ST2048');
INSERT INTO `hospital`.`doctorspecialty` (`specialtyID`, `doctorID`) VALUES (927392738, 'KL3819');
INSERT INTO `hospital`.`doctorspecialty` (`specialtyID`, `doctorID`) VALUES (023948719, 'JK8192');
INSERT INTO `hospital`.`doctorspecialty` (`specialtyID`, `doctorID`) VALUES (128334323, 'SD9128');
INSERT INTO `hospital`.`doctorspecialty` (`specialtyID`, `doctorID`) VALUES (960431345, 'RS7429');

COMMIT;



-- -----------------------------------------------------
-- Data for table `hospital`.`patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`patient` (`patientID`, `personID`, `dob`, `secondaryNumber`) VALUES (928343019, 928343019, '2000-01-12', 9492347890);
INSERT INTO `hospital`.`patient` (`patientID`, `personID`, `dob`, `secondaryNumber`) VALUES (338849283, 123456789, '1978-02-28', 7148920993);
INSERT INTO `hospital`.`patient` (`patientID`, `personID`, `dob`, `secondaryNumber`) VALUES (123123123, 987236481, '1980-03-03', 6572388473);
INSERT INTO `hospital`.`patient` (`patientID`, `personID`, `dob`, `secondaryNumber`) VALUES (883927229, 129847593, '1988-09-18', 9493338274);
INSERT INTO `hospital`.`patient` (`patientID`, `personID`, `dob`, `secondaryNumber`) VALUES (287538191, 986716283, '1990-05-10', 1112389382);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`patientvisit`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`patientvisit` (`visitID`, `patientID`, `doctorID`, `visitDate`, `docNote`, `billingID`) VALUES (234, 928343019, 'ST2048', '2020-04-24', 'Tumor in brain', 111295);
INSERT INTO `hospital`.`patientvisit` (`visitID`, `patientID`, `doctorID`, `visitDate`, `docNote`, `billingID`) VALUES (133, 338849283, 'KL3819', '2020-06-22', 'Gunshot wound to the head', 111583);
INSERT INTO `hospital`.`patientvisit` (`visitID`, `patientID`, `doctorID`, `visitDate`, `docNote`, `billingID`) VALUES (34, 123123123, 'JK8192', '2020-07-17', 'Heart murmur', 111229);
INSERT INTO `hospital`.`patientvisit` (`visitID`, `patientID`, `doctorID`, `visitDate`, `docNote`, `billingID`) VALUES (345, 883927229, 'SD9128', '2020-12-21', 'Severed finger', 111456);
INSERT INTO `hospital`.`patientvisit` (`visitID`, `patientID`, `doctorID`, `visitDate`, `docNote`, `billingID`) VALUES (113, 287538191, 'RS7429', '2020-12-22', 'Third degree burn', 654322);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`medicaltest`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`medicaltest` (`prescriptionID`, `visitID`, `testResult`) VALUES (9382, 234, 'CT scan positive');
INSERT INTO `hospital`.`medicaltest` (`prescriptionID`, `visitID`, `testResult`) VALUES (6757, 133, 'Surgery done successfully');
INSERT INTO `hospital`.`medicaltest` (`prescriptionID`, `visitID`, `testResult`) VALUES (8743, 34, 'Can be discharged tomorrow');
INSERT INTO `hospital`.`medicaltest` (`prescriptionID`, `visitID`, `testResult`) VALUES (8822, 345, 'Surgery done. Keep watch for finger movement');
INSERT INTO `hospital`.`medicaltest` (`prescriptionID`, `visitID`, `testResult`) VALUES (1111, 113, 'Maintain bandages over area');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`prescription`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`prescription` (`prescriptionID`, `prescriptionName`) VALUES (9382, 'Fentanyl');
INSERT INTO `hospital`.`prescription` (`prescriptionID`, `prescriptionName`) VALUES (6757, 'Fentanyl');
INSERT INTO `hospital`.`prescription` (`prescriptionID`, `prescriptionName`) VALUES (8743, 'Vicodin');
INSERT INTO `hospital`.`prescription` (`prescriptionID`, `prescriptionName`) VALUES (8822, 'Oxycodone');
INSERT INTO `hospital`.`prescription` (`prescriptionID`, `prescriptionName`) VALUES (1111, 'Morphine');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hospital`.`specialty`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `hospital`.`specialty` (`specialtyName`, `specialtyID`) VALUES ('Neurosurgeon', 927392738);
INSERT INTO `hospital`.`specialty` (`specialtyName`, `specialtyID`) VALUES ('Cardiologist', 023948719);
INSERT INTO `hospital`.`specialty` (`specialtyName`, `specialtyID`) VALUES ('Orthopedic', 128334323);
INSERT INTO `hospital`.`specialty` (`specialtyName`, `specialtyID`) VALUES ('Trauma', 960431345);
INSERT INTO `hospital`.`specialty` (`specialtyName`, `specialtyID`) VALUES ('None', 000000000);

COMMIT;



DELIMITER //
CREATE PROCEDURE prescriptionNum( IN cityName VARCHAR(20))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
END;
Select concat(count(*) ,' | ', prescription.prescriptionName) AS "" FROM medicaltest
INNER JOIN patientvisit ON patientvisit.visitID=medicaltest.visitID 
INNER JOIN prescription ON prescription.prescriptionID=medicaltest.prescriptionID 
INNER JOIN patient ON patientvisit.patientID=patient.patientID 
INNER JOIN doctor ON patientvisit.doctorID=doctor.doctorID 
where patient.personID IN(SELECT personID FROM person WHERE city=cityName) 
GROUP BY prescription.prescriptionName;
END //
DELIMITER //

call prescriptionNum('Fullerton');

