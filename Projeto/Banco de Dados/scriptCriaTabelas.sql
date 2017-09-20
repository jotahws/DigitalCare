-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema digital_care
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `digital_care` ;

-- -----------------------------------------------------
-- Schema digital_care
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `digital_care` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `digital_care` ;

-- -----------------------------------------------------
-- Table `digital_care`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`estado` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `uf` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`login` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`login` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(200) NOT NULL,
  `perfil` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`medico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`medico` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_login` INT NOT NULL,
  `id_estado_crm` INT NOT NULL,
  `num_crm` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(200) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `preco_consulta` DOUBLE NOT NULL,
  `data_nascimento` DATE NULL,
  `telefone` VARCHAR(11) NULL,
  `telefone2` VARCHAR(11) NULL,
  `avaliacao` DOUBLE NULL,
  PRIMARY KEY (`id`),
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
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_estado_medico_idx` ON `digital_care`.`medico` (`id_estado_crm` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_login_medico_idx` ON `digital_care`.`medico` (`id_login` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`paciente` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`paciente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` VARCHAR(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `cpf_UNIQUE` ON `digital_care`.`paciente` (`cpf` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`especialidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`especialidade` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`especialidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` VARCHAR(300) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `nome_UNIQUE` ON `digital_care`.`especialidade` (`nome` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`clinica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`clinica` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`clinica` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_login` INT NOT NULL,
  `cnpj` VARCHAR(20) NOT NULL,
  `razao_social` VARCHAR(200) NOT NULL,
  `nome_fantasia` VARCHAR(50) NOT NULL,
  `site` VARCHAR(50) NULL,
  `avaliacao` DOUBLE NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_login_clinica`
    FOREIGN KEY (`id_login`)
    REFERENCES `digital_care`.`login` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `cnpj_UNIQUE` ON `digital_care`.`clinica` (`cnpj` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_login_clinica_idx` ON `digital_care`.`clinica` (`id_login` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`prontuario_cab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`prontuario_cab` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`prontuario_cab` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_paciente` INT NOT NULL,
  `id_clinica` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_paciente_prontuario_cab`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clinica_prontuario_cab`
    FOREIGN KEY (`id_clinica`)
    REFERENCES `digital_care`.`clinica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_paciente_prontuario_cab_idx` ON `digital_care`.`prontuario_cab` (`id_paciente` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_clinica_prontuario_cab_idx` ON `digital_care`.`prontuario_cab` (`id_clinica` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`cidade` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`cidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_estado` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_estado_cidade`
    FOREIGN KEY (`id_estado`)
    REFERENCES `digital_care`.`estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_estado_cidade_idx` ON `digital_care`.`cidade` (`id_estado` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`endereco` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_cidade` INT NOT NULL,
  `cep` VARCHAR(10) NOT NULL,
  `rua` VARCHAR(50) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `complemento` VARCHAR(50) NULL,
  `bairro` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cidade_endereco`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `digital_care`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_cidade_endereco_idx` ON `digital_care`.`endereco` (`id_cidade` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`clinica_endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`clinica_endereco` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`clinica_endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_medico_clinica` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `telefone1` VARCHAR(11) NULL,
  `telefone2` VARCHAR(11) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_endereco_clinica_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `digital_care`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clinica_clinica_endereco`
    FOREIGN KEY (`id_medico_clinica`)
    REFERENCES `digital_care`.`clinica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_endereco_clinica_endereco_idx` ON `digital_care`.`clinica_endereco` (`id_endereco` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_clinica_clinica_endereco_idx` ON `digital_care`.`clinica_endereco` (`id_medico_clinica` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`consulta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`consulta` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`consulta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_medico` INT NOT NULL,
  `id_paciente` INT NOT NULL,
  `id_clinica_endereco` INT NOT NULL,
  `datahora` VARCHAR(45) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `observacao` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_medico_consulta`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_consulta`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clinica_endereco_consulta`
    FOREIGN KEY (`id_clinica_endereco`)
    REFERENCES `digital_care`.`clinica_endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_medico_consulta_idx` ON `digital_care`.`consulta` (`id_medico` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_paciente_consulta_idx` ON `digital_care`.`consulta` (`id_paciente` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_clinica_endereco_consulta_idx` ON `digital_care`.`consulta` (`id_clinica_endereco` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`convenio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`convenio` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`convenio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`medico_convenio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_convenio` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`medico_convenio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_medico` INT NOT NULL,
  `id_convenio` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_medico_convenio_lig_medico1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_convenio_lig_convenio1`
    FOREIGN KEY (`id_convenio`)
    REFERENCES `digital_care`.`convenio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_planoxmedico_medico1_idx` ON `digital_care`.`medico_convenio` (`id_medico` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_planoxmedico_plano_saude1_idx` ON `digital_care`.`medico_convenio` (`id_convenio` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`medico_especialidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_especialidade` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`medico_especialidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_medico` INT NOT NULL,
  `id_especialidade` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_medico_medico_especialidade`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_especialidade_medico_especialidade`
    FOREIGN KEY (`id_especialidade`)
    REFERENCES `digital_care`.`especialidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_medico_medico_especialidade_idx` ON `digital_care`.`medico_especialidade` (`id_medico` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_especialidade_medico_especialidade_idx` ON `digital_care`.`medico_especialidade` (`id_especialidade` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`paciente_convenio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`paciente_convenio` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`paciente_convenio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_paciente` INT NOT NULL,
  `id_convenio` INT NOT NULL,
  `numero` VARCHAR(100) NULL,
  `validade` DATE NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_paciente_paciente_convenio`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_convenio_paciente_convenio`
    FOREIGN KEY (`id_convenio`)
    REFERENCES `digital_care`.`convenio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_paciente_paciente_convenio_idx` ON `digital_care`.`paciente_convenio` (`id_paciente` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_convenio_paciente_convenio_idx` ON `digital_care`.`paciente_convenio` (`id_convenio` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`medico_clinica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_clinica` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`medico_clinica` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_clinica_endereco` INT NOT NULL,
  `id_medico` INT NOT NULL,
  PRIMARY KEY (`id`),
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
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_medico_clinica_medico_idx` ON `digital_care`.`medico_clinica` (`id_medico` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_clinica_endereco_clinica_medico_idx` ON `digital_care`.`medico_clinica` (`id_clinica_endereco` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`prontuario_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`prontuario_item` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`prontuario_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_prontuario_cab` INT NOT NULL,
  `id_consulta` INT NOT NULL,
  `atestado` BLOB NULL,
  `receita` BLOB NULL,
  `exame` BLOB NULL,
  `descricao` BLOB NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_prontuario_cab_item`
    FOREIGN KEY (`id_prontuario_cab`)
    REFERENCES `digital_care`.`prontuario_cab` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_prontuario_item`
    FOREIGN KEY (`id_consulta`)
    REFERENCES `digital_care`.`consulta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_prontuario_cab_item_idx` ON `digital_care`.`prontuario_item` (`id_prontuario_cab` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_consulta_prontuario_item_idx` ON `digital_care`.`prontuario_item` (`id_consulta` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`medico_horarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_horarios` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`medico_horarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_medico_clinica` INT NOT NULL,
  `dia_semana` INT NOT NULL,
  `horario_inicio` TIME(4) NOT NULL,
  `horario_fim` TIME(4) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_medico_clinica_medico_horarios`
    FOREIGN KEY (`id_medico_clinica`)
    REFERENCES `digital_care`.`medico_clinica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_medico_clinica_medico_horarios_idx` ON `digital_care`.`medico_horarios` (`id_medico_clinica` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`medico_falta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`medico_falta` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`medico_falta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_medico` INT NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_fim` DATE NULL,
  `horario_inicio` TIME(4) NULL,
  `horario_fim` TIME(4) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_medico_medico_falta`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_medico_medico_falta_idx` ON `digital_care`.`medico_falta` (`id_medico` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`notificacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`notificacao` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`notificacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_medico` INT NULL,
  `id_paciente` INT NULL,
  `id_clinica` INT NULL,
  `titulo` VARCHAR(100) NULL,
  `descricao` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_medico_notificacao`
    FOREIGN KEY (`id_medico`)
    REFERENCES `digital_care`.`medico` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_notificacao`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clinica_notificacao`
    FOREIGN KEY (`id_clinica`)
    REFERENCES `digital_care`.`clinica` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_medico_notificacao_idx` ON `digital_care`.`notificacao` (`id_medico` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_paciente_notificacao_idx` ON `digital_care`.`notificacao` (`id_paciente` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_clinica_notificacao_idx` ON `digital_care`.`notificacao` (`id_clinica` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`paciente_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`paciente_usuario` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`paciente_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_paciente` INT NOT NULL,
  `id_login` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `telefone` VARCHAR(11) NULL,
  `telefone2` VARCHAR(11) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_paciente_usuario`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `digital_care`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_paciente_usuario`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `digital_care`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_paciente_usuario`
    FOREIGN KEY (`id_login`)
    REFERENCES `digital_care`.`login` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_paciente_usuario_idx` ON `digital_care`.`paciente_usuario` (`id_paciente` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_endereco_paciente_usuario_idx` ON `digital_care`.`paciente_usuario` (`id_endereco` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_login_paciente_usuario_idx` ON `digital_care`.`paciente_usuario` (`id_login` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `digital_care`.`paciente_dependente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `digital_care`.`paciente_dependente` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `digital_care`.`paciente_dependente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_paciente` INT NOT NULL,
  `id_paciente_usuario` INT NOT NULL,
  PRIMARY KEY (`id`),
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
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_paciente_dependente_idx` ON `digital_care`.`paciente_dependente` (`id_paciente` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_paciente_usuario_dependente_idx` ON `digital_care`.`paciente_dependente` (`id_paciente_usuario` ASC);

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
