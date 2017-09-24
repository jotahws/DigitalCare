-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema digital_care
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema digital_care
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `digital_care` DEFAULT CHARACTER SET utf8 ;
USE `digital_care` ;

-- -----------------------------------------------------
-- Table `digital_care`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`estado` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`estado` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `uf` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`cidade` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`cidade` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_estado` INT(11) NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estado_cidade_idx` (`id_estado` ASC),
  CONSTRAINT `fk_estado_cidade`
    FOREIGN KEY (`id_estado`)
    REFERENCES `digital_care`.`estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`login` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`login` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  `perfil` INT(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`clinica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`clinica` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`clinica` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_login` INT(11) NOT NULL,
  `cnpj` VARCHAR(20) NOT NULL,
  `razao_social` VARCHAR(200) NOT NULL,
  `nome_fantasia` VARCHAR(50) NOT NULL,
  `site` VARCHAR(50) NULL DEFAULT NULL,
  `avaliacao` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC),
  INDEX `fk_login_clinica_idx` (`id_login` ASC),
  CONSTRAINT `fk_login_clinica`
    FOREIGN KEY (`id_login`)
    REFERENCES `digital_care`.`login` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`endereco` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`endereco` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_cidade` INT(11) NOT NULL,
  `cep` VARCHAR(10) NOT NULL,
  `rua` VARCHAR(50) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `complemento` VARCHAR(50) NULL DEFAULT NULL,
  `bairro` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidade_endereco_idx` (`id_cidade` ASC),
  CONSTRAINT `fk_cidade_endereco`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `digital_care`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`clinica_endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`clinica_endereco` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`clinica_endereco` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_clinica` INT NOT NULL,
  `id_endereco` INT(11) NOT NULL,
  `telefone1` VARCHAR(11) NULL DEFAULT NULL,
  `telefone2` VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereco_clinica_endereco_idx` (`id_endereco` ASC),
  INDEX `fk_clinica_clinica_endereco_idx` (`id_clinica` ASC),
  CONSTRAINT `fk_endereco_clinica_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `digital_care`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clinica_clinica_endereco`
    FOREIGN KEY (`id_clinica`)
    REFERENCES `digital_care`.`clinica` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`medico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`medico` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_login` INT(11) NOT NULL,
  `id_estado_crm` INT(11) NOT NULL,
  `num_crm` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(200) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `preco_consulta` DOUBLE NOT NULL,
  `data_nascimento` DATE NULL DEFAULT NULL,
  `telefone` VARCHAR(11) NULL DEFAULT NULL,
  `telefone2` VARCHAR(11) NULL DEFAULT NULL,
  `avaliacao` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estado_medico_idx` (`id_estado_crm` ASC),
  INDEX `fk_login_medico_idx` (`id_login` ASC),
  CONSTRAINT `fk_estado_medico`
    FOREIGN KEY (`id_estado_crm`)
    REFERENCES `digital_care`.`estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_medico`
    FOREIGN KEY (`id_login`)
    REFERENCES `digital_care`.`login` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`paciente` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`paciente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`consulta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`consulta` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`consulta` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_medico` INT(11) NOT NULL,
  `id_paciente` INT(11) NOT NULL,
  `id_clinica_endereco` INT(11) NOT NULL,
  `datahora` VARCHAR(45) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `observacao` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medico_consulta_idx` (`id_medico` ASC),
  INDEX `fk_paciente_consulta_idx` (`id_paciente` ASC),
  INDEX `fk_clinica_endereco_consulta_idx` (`id_clinica_endereco` ASC),
  CONSTRAINT `fk_clinica_endereco_consulta`
    FOREIGN KEY (`id_clinica_endereco`)
    REFERENCES `digital_care`.`clinica_endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_consulta`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_consulta`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`convenio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`convenio` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`convenio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`especialidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`especialidade` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`especialidade` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`medico_clinica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_clinica` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`medico_clinica` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_clinica_endereco` INT(11) NOT NULL,
  `id_medico` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medico_clinica_medico_idx` (`id_medico` ASC),
  INDEX `fk_clinica_endereco_clinica_medico_idx` (`id_clinica_endereco` ASC),
  CONSTRAINT `fk_clinica_endereco_clinica_medico`
    FOREIGN KEY (`id_clinica_endereco`)
    REFERENCES `digital_care`.`clinica_endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_clinica_medico`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`medico_convenio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_convenio` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`medico_convenio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_medico` INT(11) NOT NULL,
  `id_convenio` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_planoxmedico_medico1_idx` (`id_medico` ASC),
  INDEX `fk_planoxmedico_plano_saude1_idx` (`id_convenio` ASC),
  CONSTRAINT `fk_medico_convenio_lig_convenio1`
    FOREIGN KEY (`id_convenio`)
    REFERENCES `digital_care`.`convenio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_convenio_lig_medico1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`medico_especialidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_especialidade` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`medico_especialidade` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_medico` INT(11) NOT NULL,
  `id_especialidade` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medico_medico_especialidade_idx` (`id_medico` ASC),
  INDEX `fk_especialidade_medico_especialidade_idx` (`id_especialidade` ASC),
  CONSTRAINT `fk_especialidade_medico_especialidade`
    FOREIGN KEY (`id_especialidade`)
    REFERENCES `digital_care`.`especialidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_medico_especialidade`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`medico_falta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_falta` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`medico_falta` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_medico` INT(11) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NULL DEFAULT NULL,
  `horario_inicio` TIME(4) NULL DEFAULT NULL,
  `horario_fim` TIME(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medico_medico_falta_idx` (`id_medico` ASC),
  CONSTRAINT `fk_medico_medico_falta`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`medico_horarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_horarios` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`medico_horarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_medico_clinica` INT(11) NOT NULL,
  `dia_semana` INT(11) NOT NULL,
  `horario_inicio` TIME(4) NOT NULL,
  `horario_fim` TIME(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medico_clinica_medico_horarios_idx` (`id_medico_clinica` ASC),
  CONSTRAINT `fk_medico_clinica_medico_horarios`
    FOREIGN KEY (`id_medico_clinica`)
    REFERENCES `digital_care`.`medico_clinica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`notificacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`notificacao` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`notificacao` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_medico` INT(11) NULL DEFAULT NULL,
  `id_paciente` INT(11) NULL DEFAULT NULL,
  `id_clinica` INT(11) NULL DEFAULT NULL,
  `titulo` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medico_notificacao_idx` (`id_medico` ASC),
  INDEX `fk_paciente_notificacao_idx` (`id_paciente` ASC),
  INDEX `fk_clinica_notificacao_idx` (`id_clinica` ASC),
  CONSTRAINT `fk_clinica_notificacao`
    FOREIGN KEY (`id_clinica`)
    REFERENCES `digital_care`.`clinica` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_notificacao`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_notificacao`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`paciente_convenio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`paciente_convenio` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`paciente_convenio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` INT(11) NOT NULL,
  `id_convenio` INT(11) NOT NULL,
  `numero` VARCHAR(100) NULL DEFAULT NULL,
  `validade` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paciente_paciente_convenio_idx` (`id_paciente` ASC),
  INDEX `fk_convenio_paciente_convenio_idx` (`id_convenio` ASC),
  CONSTRAINT `fk_convenio_paciente_convenio`
    FOREIGN KEY (`id_convenio`)
    REFERENCES `digital_care`.`convenio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_paciente_convenio`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`paciente_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`paciente_usuario` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`paciente_usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` INT(11) NOT NULL,
  `id_login` INT(11) NOT NULL,
  `id_endereco` INT(11) NOT NULL,
  `telefone` VARCHAR(11) NULL DEFAULT NULL,
  `telefone2` VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paciente_usuario_idx` (`id_paciente` ASC),
  INDEX `fk_endereco_paciente_usuario_idx` (`id_endereco` ASC),
  INDEX `fk_login_paciente_usuario_idx` (`id_login` ASC),
  CONSTRAINT `fk_endereco_paciente_usuario`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `digital_care`.`endereco` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_paciente_usuario`
    FOREIGN KEY (`id_login`)
    REFERENCES `digital_care`.`login` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_usuario`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`paciente_dependente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`paciente_dependente` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`paciente_dependente` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` INT(11) NOT NULL,
  `id_paciente_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paciente_dependente_idx` (`id_paciente` ASC),
  INDEX `fk_paciente_usuario_dependente_idx` (`id_paciente_usuario` ASC),
  CONSTRAINT `fk_paciente_dependente`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_usuario_dependente`
    FOREIGN KEY (`id_paciente_usuario`)
    REFERENCES `digital_care`.`paciente_usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`prontuario_cab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`prontuario_cab` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`prontuario_cab` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` INT(11) NOT NULL,
  `id_clinica` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paciente_prontuario_cab_idx` (`id_paciente` ASC),
  INDEX `fk_clinica_prontuario_cab_idx` (`id_clinica` ASC),
  CONSTRAINT `fk_clinica_prontuario_cab`
    FOREIGN KEY (`id_clinica`)
    REFERENCES `digital_care`.`clinica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_prontuario_cab`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `digital_care`.`prontuario_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`prontuario_item` ;

CREATE TABLE IF NOT EXISTS `digital_care`.`prontuario_item` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_prontuario_cab` INT(11) NOT NULL,
  `id_consulta` INT(11) NOT NULL,
  `atestado` BLOB NULL DEFAULT NULL,
  `receita` BLOB NULL DEFAULT NULL,
  `exame` BLOB NULL DEFAULT NULL,
  `descricao` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prontuario_cab_item_idx` (`id_prontuario_cab` ASC),
  INDEX `fk_consulta_prontuario_item_idx` (`id_consulta` ASC),
  CONSTRAINT `fk_consulta_prontuario_item`
    FOREIGN KEY (`id_consulta`)
    REFERENCES `digital_care`.`consulta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prontuario_cab_item`
    FOREIGN KEY (`id_prontuario_cab`)
    REFERENCES `digital_care`.`prontuario_cab` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
