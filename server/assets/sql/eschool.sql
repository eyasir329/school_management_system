-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema eschool
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eschool
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eschool` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `eschool` ;
DROP TRIGGER IF EXISTS `user_status_AFTER_UPDATE`;
DROP TRIGGER IF EXISTS `user_status_BEFORE_UPDATE`;
DROP TRIGGER IF EXISTS `users_BEFORE_UPDATE`;
-- -----------------------------------------------------
-- Table `eschool`.`user_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`user_status` (
  `user_id` INT NOT NULL,
  `user_type` VARCHAR(10) NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT 'Under Process',
  `password` VARCHAR(255) NULL DEFAULT '$2b$10$YXD4RNLiUkvs7PT.NrsaOuTkJOXv5DNkKhrP3kCwJpHzmP1sgyWSi',
  `key` VARCHAR(255) NOT NULL DEFAULT 'n3pyqqtoEya32sd24',
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NOT NULL,
  `division` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`socials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`socials` (
  `social_id` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(255) NULL DEFAULT '+8801792878992',
  `facebook` VARCHAR(255) NULL DEFAULT 'https://www.facebook.com/',
  `linkedin` VARCHAR(255) NULL DEFAULT 'https://bd.linkedin.com/',
  `twitter` VARCHAR(255) NULL DEFAULT 'https://twitter.com/?lang=en',
  `email` VARCHAR(255) NULL DEFAULT '\"N/A\"',
  PRIMARY KEY (`social_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`users` (
  `user_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `profile_pic` VARCHAR(255) NULL DEFAULT 'https://img.lovepik.com/element/45001/3052.png_300.png',
  `date_of_birth` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `birth_cirtificate_no` VARCHAR(50) NULL DEFAULT '567826562782DE',
  `nid_no` VARCHAR(50) NULL DEFAULT '462456772654DE',
  `social_id` INT NULL,
  `address_id` INT NULL,
  `street_address` VARCHAR(255) NULL DEFAULT '123 Main Street, Anytown, USA 12345',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  INDEX `fk_users_2_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_users_3_idx` (`social_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `eschool`.`user_status` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_2`
    FOREIGN KEY (`address_id`)
    REFERENCES `eschool`.`addresses` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_3`
    FOREIGN KEY (`social_id`)
    REFERENCES `eschool`.`socials` (`social_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`subject` (
  `subject_id` INT NOT NULL AUTO_INCREMENT,
  `sub_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`subject_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`positions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`positions` (
  `position_id` INT NOT NULL AUTO_INCREMENT,
  `position_name` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`position_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`teaches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`teaches` (
  `teacher_id` INT NOT NULL,
  `position_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`teacher_id`),
  UNIQUE INDEX `teacher_id_UNIQUE` USING BTREE (`teacher_id`) VISIBLE,
  INDEX `fk_teaches_4_idx` (`subject_id` ASC) VISIBLE,
  INDEX `fk_teaches_5_idx` (`position_id` ASC) VISIBLE,
  CONSTRAINT `fk_teaches_3`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `eschool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_teaches_4`
    FOREIGN KEY (`subject_id`)
    REFERENCES `eschool`.`subject` (`subject_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_teaches_5`
    FOREIGN KEY (`position_id`)
    REFERENCES `eschool`.`positions` (`position_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`parents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`parents` (
  `parent_id` INT NOT NULL,
  `father_user_id` INT NULL DEFAULT NULL,
  `mother_user_id` INT NULL DEFAULT NULL,
  `guardian_user_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`parent_id`),
  INDEX `fk_parents_1_idx` (`father_user_id` ASC) VISIBLE,
  INDEX `fk_parents_2_idx` (`mother_user_id` ASC) VISIBLE,
  INDEX `fk_parents_3_idx` (`guardian_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_parents_1`
    FOREIGN KEY (`father_user_id`)
    REFERENCES `eschool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_parents_2`
    FOREIGN KEY (`mother_user_id`)
    REFERENCES `eschool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_parents_3`
    FOREIGN KEY (`guardian_user_id`)
    REFERENCES `eschool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`students` (
  `student_id` INT NOT NULL,
  `parent_id` INT NOT NULL,
  `gender` VARCHAR(10) NOT NULL,
  `class_id` INT NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE,
  INDEX `fk_students_1_idx` (`class_id` ASC) VISIBLE,
  INDEX `fk_students_5_idx` (`parent_id` ASC) VISIBLE,
  CONSTRAINT `fk_students_1`
    FOREIGN KEY (`class_id`)
    REFERENCES `eschool`.`academics` (`class_id`),
  CONSTRAINT `fk_students_4`
    FOREIGN KEY (`student_id`)
    REFERENCES `eschool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_students_5`
    FOREIGN KEY (`parent_id`)
    REFERENCES `eschool`.`parents` (`parent_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`academics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`academics` (
  `class_id` INT NOT NULL,
  `class_name` VARCHAR(20) NOT NULL,
  `session` VARCHAR(45) NOT NULL,
  `class_teacher_id` INT NULL DEFAULT NULL,
  `class_captain_id` INT NULL DEFAULT NULL,
  `room_number` INT NULL DEFAULT NULL,
  `syllabus` VARCHAR(15000) NULL DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  UNIQUE INDEX `academic_id_UNIQUE` (`class_id` ASC) VISIBLE,
  INDEX `fk_academics_1_idx` (`class_teacher_id` ASC) VISIBLE,
  INDEX `fk_academics_2_idx` (`class_captain_id` ASC) VISIBLE,
  CONSTRAINT `fk_academics_1`
    FOREIGN KEY (`class_teacher_id`)
    REFERENCES `eschool`.`teaches` (`teacher_id`),
  CONSTRAINT `fk_academics_2`
    FOREIGN KEY (`class_captain_id`)
    REFERENCES `eschool`.`students` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`class_subjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`class_subjects` (
  `class_subject_id` INT NOT NULL AUTO_INCREMENT,
  `class_id` INT NOT NULL,
  `subject_id` INT NOT NULL,
  `teacher_id` INT NULL DEFAULT NULL,
  `syllabus` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`class_subject_id`),
  UNIQUE INDEX `class_subject_id_UNIQUE` (`class_subject_id` ASC) VISIBLE,
  UNIQUE INDEX `subject_id_UNIQUE` (`subject_id` ASC) VISIBLE,
  INDEX `fk_subjects_1_idx` (`class_id` ASC) VISIBLE,
  INDEX `fk_subjects_2_idx` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `fk_class_subjects_1`
    FOREIGN KEY (`class_id`)
    REFERENCES `eschool`.`academics` (`class_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_class_subjects_2`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `eschool`.`teaches` (`teacher_id`),
  CONSTRAINT `fk_class_subjects_3`
    FOREIGN KEY (`subject_id`)
    REFERENCES `eschool`.`subject` (`subject_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 103
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`attendance` (
  `student_id` INT NOT NULL,
  `class_subject_id` INT NOT NULL,
  `attendance` INT NULL DEFAULT 0,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE,
  UNIQUE INDEX `subject_id_UNIQUE` (`class_subject_id` ASC) VISIBLE,
  INDEX `fk_attendance_1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_attendance_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `eschool`.`students` (`student_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_attendance_2`
    FOREIGN KEY (`class_subject_id`)
    REFERENCES `eschool`.`class_subjects` (`class_subject_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`exam_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`exam_info` (
  `exam_id` INT NOT NULL AUTO_INCREMENT,
  `exam_name` VARCHAR(45) NOT NULL,
  `exam_held` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`exam_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`homeworks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`homeworks` (
  `class_subject_id` INT NOT NULL,
  `title` VARCHAR(45) NULL DEFAULT NULL,
  `content` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`class_subject_id`),
  CONSTRAINT `fk_homeworks_1`
    FOREIGN KEY (`class_subject_id`)
    REFERENCES `eschool`.`class_subjects` (`class_subject_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`homework_marks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`homework_marks` (
  `class_subject_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `content` VARCHAR(45) NULL DEFAULT NULL,
  `mark` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`class_subject_id`, `student_id`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE,
  UNIQUE INDEX `homework_id_UNIQUE` (`class_subject_id` ASC) VISIBLE,
  CONSTRAINT `fk_homework_marks_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `eschool`.`students` (`student_id`),
  CONSTRAINT `fk_homework_marks_2`
    FOREIGN KEY (`class_subject_id`)
    REFERENCES `eschool`.`homeworks` (`class_subject_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`marks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`marks` (
  `exam_id` INT NOT NULL,
  `class_subject_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `cq` DECIMAL(5,2) NULL DEFAULT NULL,
  `mcq` DECIMAL(5,2) NULL DEFAULT NULL,
  `attendance` DECIMAL(4,2) NULL DEFAULT NULL,
  `homework` DECIMAL(4,2) NULL DEFAULT NULL,
  INDEX `student_id` (`student_id` ASC) VISIBLE,
  INDEX `fk_marks_1_idx` (`exam_id` ASC) VISIBLE,
  INDEX `marks_ibfk_2_idx` (`class_subject_id` ASC) VISIBLE,
  CONSTRAINT `fk_marks_1`
    FOREIGN KEY (`exam_id`)
    REFERENCES `eschool`.`exam_info` (`exam_id`),
  CONSTRAINT `marks_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `eschool`.`students` (`student_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `marks_ibfk_2`
    FOREIGN KEY (`class_subject_id`)
    REFERENCES `eschool`.`class_subjects` (`class_subject_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`notice_board`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`notice_board` (
  `notice_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `category` VARCHAR(45) NOT NULL DEFAULT 'academic',
  `title` VARCHAR(255) NOT NULL,
  `link` VARCHAR(255) NULL DEFAULT NULL,
  `text_message` VARCHAR(2000) NULL DEFAULT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notice_id`),
  INDEX `fk_notice_board_1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_notice_board_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `eschool`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`principals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`principals` (
  `teacher_id` INT NOT NULL,
  `principal_speech` VARCHAR(3000) NOT NULL,
  `joining_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ending_date` DATE NULL DEFAULT NULL,
  INDEX `teacher_id` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `principals_ibfk_1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `eschool`.`teaches` (`teacher_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`school`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`school` (
  `eiin_number` VARCHAR(25) NOT NULL,
  `school_name` VARCHAR(255) NOT NULL,
  `established_at` VARCHAR(4) NOT NULL,
  `history` VARCHAR(3000) NULL DEFAULT NULL,
  `logo` VARCHAR(255) NULL DEFAULT NULL,
  `social_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`eiin_number`),
  UNIQUE INDEX `eiin_UNIQUE` (`eiin_number` ASC) VISIBLE,
  INDEX `fk_school_1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_school_2_idx` (`social_id` ASC) VISIBLE,
  CONSTRAINT `fk_school_1`
    FOREIGN KEY (`address_id`)
    REFERENCES `eschool`.`addresses` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_school_2`
    FOREIGN KEY (`social_id`)
    REFERENCES `eschool`.`socials` (`social_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`staffs` (
  `staff_id` INT NOT NULL,
  `position_id` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE INDEX `staff_id_UNIQUE` (`staff_id` ASC) VISIBLE,
  INDEX `fk_staffs_4_idx` (`position_id` ASC) VISIBLE,
  CONSTRAINT `fk_staffs_3`
    FOREIGN KEY (`staff_id`)
    REFERENCES `eschool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staffs_4`
    FOREIGN KEY (`position_id`)
    REFERENCES `eschool`.`positions` (`position_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `eschool`.`books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`books` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `book_name` VARCHAR(255) NULL,
  `author` VARCHAR(255) NULL,
  `stocks` INT NULL DEFAULT 0,
  PRIMARY KEY (`book_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eschool`.`class_subject_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`class_subject_book` (
  `class_subject_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`class_subject_id`, `book_id`),
  INDEX `fk_class_subject_book_1_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_class_subject_book_1`
    FOREIGN KEY (`book_id`)
    REFERENCES `eschool`.`books` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_class_subject_book_2`
    FOREIGN KEY (`class_subject_id`)
    REFERENCES `eschool`.`class_subjects` (`class_subject_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eschool`.`exam_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eschool`.`exam_status` (
  `exam_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'NOT PUBLISHED',
  PRIMARY KEY (`exam_id`, `class_id`),
  INDEX `fk_exam_status_2_idx` (`class_id` ASC) VISIBLE,
  CONSTRAINT `fk_exam_status_1`
    FOREIGN KEY (`exam_id`)
    REFERENCES `eschool`.`exam_info` (`exam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exam_status_2`
    FOREIGN KEY (`class_id`)
    REFERENCES `eschool`.`academics` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `eschool`;

DELIMITER $$
USE `eschool`$$
CREATE DEFINER = CURRENT_USER TRIGGER `eschool`.`user_status_AFTER_UPDATE` AFTER UPDATE ON `users` FOR EACH ROW
BEGIN
UPDATE user_status
SET updated_at = CURRENT_TIMESTAMP
WHERE user_id = NEW.user_id;
END$$

USE `eschool`$$
CREATE DEFINER = CURRENT_USER TRIGGER `eschool`.`user_status_BEFORE_UPDATE` BEFORE UPDATE ON `user_status` FOR EACH ROW
BEGIN
SET NEW.updated_at = CURRENT_TIMESTAMP;
IF NEW.password <> OLD.password THEN
SET NEW.password = NEW.password;
SET @chars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
SET @random_key := '';
SET @i := 1;
WHILE @i <= 20 DO
SET @random_key := CONCAT(@random_key, SUBSTRING(@chars, FLOOR(1 + RAND() * 62), 1));
SET @i := @i + 1;
END WHILE;
SET NEW.key = @random_key;
END IF;
END$$

USE `eschool`$$
CREATE DEFINER = CURRENT_USER TRIGGER `eschool`.`users_BEFORE_UPDATE` BEFORE UPDATE ON `users` FOR EACH ROW
BEGIN
UPDATE user_status
SET updated_at = CURRENT_TIMESTAMP
WHERE user_id = NEW.user_id;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
