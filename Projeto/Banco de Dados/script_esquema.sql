CREATE DATABASE  IF NOT EXISTS `digital_care` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `digital_care`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: digital_care
-- ------------------------------------------------------
-- Server version	5.6.37-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cidade`
--

DROP TABLE IF EXISTS `cidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_estado` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_estado_cidade_idx` (`id_estado`),
  CONSTRAINT `fk_estado_cidade` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5565 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinica`
--

DROP TABLE IF EXISTS `clinica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_login` int(11) NOT NULL,
  `cnpj` varchar(20) NOT NULL,
  `razao_social` varchar(200) NOT NULL,
  `nome_fantasia` varchar(50) NOT NULL,
  `site` varchar(50) DEFAULT NULL,
  `avaliacao` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj_UNIQUE` (`cnpj`),
  KEY `fk_login_clinica_idx` (`id_login`),
  CONSTRAINT `fk_login_clinica` FOREIGN KEY (`id_login`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinica_endereco`
--

DROP TABLE IF EXISTS `clinica_endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinica_endereco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_clinica` int(11) NOT NULL,
  `id_endereco` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `telefone1` varchar(11) NOT NULL,
  `telefone2` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_clinica_endereco` (`id_clinica`,`id_endereco`),
  KEY `fk_endereco_clinica_endereco_idx` (`id_endereco`),
  KEY `fk_clinica_clinica_endereco_idx` (`id_clinica`),
  CONSTRAINT `fk_endereco_clinica_endereco` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consulta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_medico` int(11) DEFAULT NULL,
  `id_paciente` int(11) NOT NULL,
  `id_clinica_endereco` int(11) NOT NULL,
  `datahora` datetime NOT NULL,
  `status` varchar(50) NOT NULL,
  `observacao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_medico_consulta_idx` (`id_medico`),
  KEY `fk_paciente_consulta_idx` (`id_paciente`),
  KEY `fk_clinica_endereco_consulta_idx` (`id_clinica_endereco`),
  CONSTRAINT `fk_clinica_endereco_consulta` FOREIGN KEY (`id_clinica_endereco`) REFERENCES `clinica_endereco` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_consulta` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_consulta` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `convenio`
--

DROP TABLE IF EXISTS `convenio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `convenio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cidade` int(11) NOT NULL,
  `cep` varchar(10) NOT NULL,
  `rua` varchar(50) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `complemento` varchar(50) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cidade_endereco_idx` (`id_cidade`),
  CONSTRAINT `fk_cidade_endereco` FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `especialidade`
--

DROP TABLE IF EXISTS `especialidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `especialidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `uf` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `senha` varchar(200) NOT NULL,
  `perfil` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medicamento_anvisa`
--

DROP TABLE IF EXISTS `medicamento_anvisa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicamento_anvisa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `principio_ativo` varchar(255) DEFAULT NULL,
  `ean` varchar(18) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26051 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_login` int(11) NOT NULL,
  `id_estado_crm` int(11) NOT NULL,
  `num_crm` varchar(10) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `sobrenome` varchar(200) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `preco_consulta` double DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `telefone2` varchar(11) DEFAULT NULL,
  `avaliacao` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_cpf_medico` (`cpf`),
  KEY `fk_estado_medico_idx` (`id_estado_crm`),
  KEY `fk_login_medico_idx` (`id_login`),
  CONSTRAINT `fk_estado_medico` FOREIGN KEY (`id_estado_crm`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_medico` FOREIGN KEY (`id_login`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico_clinica`
--

DROP TABLE IF EXISTS `medico_clinica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_clinica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_clinica_endereco` int(11) NOT NULL,
  `id_medico` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_medico_clinica` (`id_clinica_endereco`,`id_medico`),
  KEY `fk_medico_clinica_medico_idx` (`id_medico`),
  KEY `fk_clinica_endereco_clinica_medico_idx` (`id_clinica_endereco`),
  CONSTRAINT `fk_clinica_endereco_clinica_medico` FOREIGN KEY (`id_clinica_endereco`) REFERENCES `clinica_endereco` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_clinica_medico` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico_convenio`
--

DROP TABLE IF EXISTS `medico_convenio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_convenio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_medico` int(11) NOT NULL,
  `id_convenio` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_medico_convenio` (`id_medico`,`id_convenio`),
  KEY `fk_planoxmedico_medico1_idx` (`id_medico`),
  KEY `fk_planoxmedico_plano_saude1_idx` (`id_convenio`),
  CONSTRAINT `fk_medico_convenio_lig_convenio1` FOREIGN KEY (`id_convenio`) REFERENCES `convenio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_convenio_lig_medico1` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico_especialidade`
--

DROP TABLE IF EXISTS `medico_especialidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_especialidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_medico` int(11) NOT NULL,
  `id_especialidade` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_medico_especialidade` (`id_medico`,`id_especialidade`),
  KEY `fk_medico_medico_especialidade_idx` (`id_medico`),
  KEY `fk_especialidade_medico_especialidade_idx` (`id_especialidade`),
  CONSTRAINT `fk_especialidade_medico_especialidade` FOREIGN KEY (`id_especialidade`) REFERENCES `especialidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_medico_especialidade` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico_falta`
--

DROP TABLE IF EXISTS `medico_falta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_falta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_medico` int(11) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_fim` date DEFAULT NULL,
  `horario_inicio` time(4) DEFAULT NULL,
  `horario_fim` time(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_medico_medico_falta_idx` (`id_medico`),
  CONSTRAINT `fk_medico_medico_falta` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medico_horarios`
--

DROP TABLE IF EXISTS `medico_horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medico_horarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_medico_clinica` int(11) NOT NULL,
  `dia_semana` int(11) NOT NULL,
  `horario_inicio` time(4) NOT NULL,
  `horario_fim` time(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_medico_clinica_medico_horarios_idx` (`id_medico_clinica`),
  CONSTRAINT `fk_medico_clinica_medico_horarios` FOREIGN KEY (`id_medico_clinica`) REFERENCES `medico_clinica` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notificacao`
--

DROP TABLE IF EXISTS `notificacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notificacao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_medico` int(11) DEFAULT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `id_clinica` int(11) DEFAULT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_medico_notificacao_idx` (`id_medico`),
  KEY `fk_paciente_notificacao_idx` (`id_paciente`),
  KEY `fk_clinica_notificacao_idx` (`id_clinica`),
  CONSTRAINT `fk_clinica_notificacao` FOREIGN KEY (`id_clinica`) REFERENCES `clinica` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_medico_notificacao` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_notificacao` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpf` varchar(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `sobrenome` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paciente_convenio`
--

DROP TABLE IF EXISTS `paciente_convenio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente_convenio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` int(11) NOT NULL,
  `id_convenio` int(11) NOT NULL,
  `numero` varchar(100) DEFAULT NULL,
  `validade` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_paciente_convenio` (`id_paciente`,`id_convenio`),
  KEY `fk_paciente_paciente_convenio_idx` (`id_paciente`),
  KEY `fk_convenio_paciente_convenio_idx` (`id_convenio`),
  CONSTRAINT `fk_convenio_paciente_convenio` FOREIGN KEY (`id_convenio`) REFERENCES `convenio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_paciente_convenio` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paciente_dependente`
--

DROP TABLE IF EXISTS `paciente_dependente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente_dependente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` int(11) NOT NULL,
  `id_paciente_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_paciente_dependente_idx` (`id_paciente`),
  KEY `fk_paciente_usuario_dependente_idx` (`id_paciente_usuario`),
  CONSTRAINT `fk_paciente_dependente` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_usuario_dependente` FOREIGN KEY (`id_paciente_usuario`) REFERENCES `paciente_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paciente_usuario`
--

DROP TABLE IF EXISTS `paciente_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` int(11) NOT NULL,
  `id_login` int(11) NOT NULL,
  `id_endereco` int(11) NOT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `telefone2` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_paciente_usuario_idx` (`id_paciente`),
  KEY `fk_endereco_paciente_usuario_idx` (`id_endereco`),
  KEY `fk_login_paciente_usuario_idx` (`id_login`),
  CONSTRAINT `fk_endereco_paciente_usuario` FOREIGN KEY (`id_endereco`) REFERENCES `endereco` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_login_paciente_usuario` FOREIGN KEY (`id_login`) REFERENCES `login` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_usuario` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prontuario_cab`
--

DROP TABLE IF EXISTS `prontuario_cab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prontuario_cab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` int(11) NOT NULL,
  `id_clinica` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_paciente_prontuario_cab_idx` (`id_paciente`),
  KEY `fk_clinica_prontuario_cab_idx` (`id_clinica`),
  CONSTRAINT `fk_clinica_prontuario_cab` FOREIGN KEY (`id_clinica`) REFERENCES `clinica` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_prontuario_cab` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prontuario_item`
--

DROP TABLE IF EXISTS `prontuario_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prontuario_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_prontuario_cab` int(11) DEFAULT NULL,
  `id_consulta` int(11) NOT NULL,
  `atestado` blob,
  `receita` blob,
  `exame` blob,
  `descricao` blob,
  PRIMARY KEY (`id`),
  KEY `fk_prontuario_cab_item_idx` (`id_prontuario_cab`),
  KEY `fk_consulta_prontuario_item_idx` (`id_consulta`),
  CONSTRAINT `fk_consulta` FOREIGN KEY (`id_consulta`) REFERENCES `consulta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_prontuario_cab_item` FOREIGN KEY (`id_prontuario_cab`) REFERENCES `prontuario_cab` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-26  9:14:29
