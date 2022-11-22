-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema SAE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SAE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SAE` ;
USE `SAE` ;

-- -----------------------------------------------------
-- Table `SAE`.`tb_professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAE`.`tb_professor` (
  `id_professor` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_professor` VARCHAR(100) NOT NULL,
  `materia` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_professor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE`.`tb_turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAE`.`tb_turma` (
  `id_turma` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_turma` VARCHAR(60) NOT NULL,
  `periodo` VARCHAR(30) NOT NULL,
  `tb_professor_id_professor` BIGINT NOT NULL,
  PRIMARY KEY (`id_turma`),
  INDEX `fk_tb_turma_tb_professor1_idx` (`tb_professor_id_professor` ASC) VISIBLE,
  CONSTRAINT `fk_tb_turma_tb_professor1`
    FOREIGN KEY (`tb_professor_id_professor`)
    REFERENCES `SAE`.`tb_professor` (`id_professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE`.`tb_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAE`.`tb_aluno` (
  `id_aluno` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_aluno` VARCHAR(160) NOT NULL,
  `media` DOUBLE NOT NULL,
  `situacao` VARCHAR(20) NOT NULL,
  `tb_turma_id_turma` BIGINT NOT NULL,
  PRIMARY KEY (`id_aluno`),
  INDEX `fk_tb_aluno_tb_turma1_idx` (`tb_turma_id_turma` ASC) VISIBLE,
  CONSTRAINT `fk_tb_aluno_tb_turma1`
    FOREIGN KEY (`tb_turma_id_turma`)
    REFERENCES `SAE`.`tb_turma` (`id_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE`.`tb_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAE`.`tb_user` (
  `id_user` BIGINT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(120) NOT NULL,
  `cpf` VARCHAR(30) NOT NULL,
  `login` VARCHAR(30) NOT NULL,
  `senha` VARCHAR(10) NOT NULL,
  `tb_professor_id_professor` BIGINT NOT NULL,
  PRIMARY KEY (`id_user`),
  INDEX `fk_tb_user_tb_professor_idx` (`tb_professor_id_professor` ASC) VISIBLE,
  CONSTRAINT `fk_tb_user_tb_professor`
    FOREIGN KEY (`tb_professor_id_professor`)
    REFERENCES `SAE`.`tb_professor` (`id_professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE`.`tb_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAE`.`tb_materia` (
  `id_materia` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_materia` VARCHAR(100) NOT NULL,
  `turmas` VARCHAR(30) NOT NULL,
  `tb_turma_id_turma` BIGINT NOT NULL,
  PRIMARY KEY (`id_materia`),
  INDEX `fk_tb_materia_tb_turma1_idx` (`tb_turma_id_turma` ASC) VISIBLE,
  CONSTRAINT `fk_tb_materia_tb_turma1`
    FOREIGN KEY (`tb_turma_id_turma`)
    REFERENCES `SAE`.`tb_turma` (`id_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SAE`.`tb_avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SAE`.`tb_avaliacao` (
  `id_avaliacao` BIGINT NOT NULL AUTO_INCREMENT,
  `data_aplicacao` DATE NOT NULL,
  `nota_avaliacao` DOUBLE NOT NULL,
  `aprovado` TINYINT NOT NULL,
  `especificacao` VARCHAR(255) NOT NULL,
  `tb_professor_id_professor` BIGINT NOT NULL,
  `tb_aluno_id_aluno` BIGINT NOT NULL,
  `tb_materia_id_materia` BIGINT NOT NULL,
  PRIMARY KEY (`id_avaliacao`),
  INDEX `fk_tb_avaliacao_tb_professor1_idx` (`tb_professor_id_professor` ASC) VISIBLE,
  INDEX `fk_tb_avaliacao_tb_aluno1_idx` (`tb_aluno_id_aluno` ASC) VISIBLE,
  INDEX `fk_tb_avaliacao_tb_materia1_idx` (`tb_materia_id_materia` ASC) VISIBLE,
  CONSTRAINT `fk_tb_avaliacao_tb_professor1`
    FOREIGN KEY (`tb_professor_id_professor`)
    REFERENCES `SAE`.`tb_professor` (`id_professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_avaliacao_tb_aluno1`
    FOREIGN KEY (`tb_aluno_id_aluno`)
    REFERENCES `SAE`.`tb_aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_avaliacao_tb_materia1`
    FOREIGN KEY (`tb_materia_id_materia`)
    REFERENCES `SAE`.`tb_materia` (`id_materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
