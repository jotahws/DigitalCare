ALTER TABLE `digital_care`.`medico` 
DROP FOREIGN KEY `fk_login_medico`;
ALTER TABLE `digital_care`.`medico` 
ADD CONSTRAINT `fk_login_medico`
  FOREIGN KEY (`id_login`)
  REFERENCES `digital_care`.`login` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;
  
ALTER TABLE `digital_care`.`medico_especialidade` 
DROP FOREIGN KEY `fk_medico_medico_especialidade`;
ALTER TABLE `digital_care`.`medico_especialidade` 
ADD CONSTRAINT `fk_medico_medico_especialidade`
  FOREIGN KEY (`id_medico`)
  REFERENCES `digital_care`.`medico` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;
  
ALTER TABLE `digital_care`.`medico_clinica` 
DROP FOREIGN KEY `fk_medico_clinica_medico`;
ALTER TABLE `digital_care`.`medico_clinica` 
ADD CONSTRAINT `fk_medico_clinica_medico`
  FOREIGN KEY (`id_medico`)
  REFERENCES `digital_care`.`medico` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;

ALTER TABLE `digital_care`.`medico_horarios` 
DROP FOREIGN KEY `fk_medico_clinica_medico_horarios`;
ALTER TABLE `digital_care`.`medico_horarios` 
ADD CONSTRAINT `fk_medico_clinica_medico_horarios`
  FOREIGN KEY (`id_medico_clinica`)
  REFERENCES `digital_care`.`medico_clinica` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;

ALTER TABLE `digital_care`.`medico_convenio` 
DROP FOREIGN KEY `fk_medico_convenio_lig_medico1`;
ALTER TABLE `digital_care`.`medico_convenio` 
ADD CONSTRAINT `fk_medico_convenio_lig_medico1`
  FOREIGN KEY (`id_medico`)
  REFERENCES `digital_care`.`medico` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;

ALTER TABLE `digital_care`.`medico_falta` 
DROP FOREIGN KEY `fk_medico_medico_falta`;
ALTER TABLE `digital_care`.`medico_falta` 
ADD CONSTRAINT `fk_medico_medico_falta`
  FOREIGN KEY (`id_medico`)
  REFERENCES `digital_care`.`medico` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;

ALTER TABLE `digital_care`.`consulta` 
DROP FOREIGN KEY `fk_medico_consulta`;
ALTER TABLE `digital_care`.`consulta` 
CHANGE COLUMN `id_medico` `id_medico` INT(11) NULL ;
ALTER TABLE `digital_care`.`consulta` 
ADD CONSTRAINT `fk_medico_consulta`
  FOREIGN KEY (`id_medico`)
  REFERENCES `digital_care`.`medico` (`id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;