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
DROP FOREIGN KEY `fk_medico_clinica_medico`,
DROP FOREIGN KEY `fk_clinica_endereco_clinica_medico`;
ALTER TABLE `digital_care`.`medico_clinica` 
ADD CONSTRAINT `fk_medico_clinica_medico`
  FOREIGN KEY (`id_medico`)
  REFERENCES `digital_care`.`medico` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_clinica_endereco_clinica_medico`
  FOREIGN KEY (`id_clinica_endereco`)
  REFERENCES `digital_care`.`clinica_endereco` (`id`)
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
DROP FOREIGN KEY `fk_clinica_endereco_consulta`,
DROP FOREIGN KEY `fk_paciente_consulta`, 
DROP FOREIGN KEY `fk_medico_consulta`;
ALTER TABLE `digital_care`.`consulta` 
CHANGE COLUMN `id_medico` `id_medico` INT(11) NULL ;
ALTER TABLE `digital_care`.`consulta` 
ADD CONSTRAINT `fk_clinica_endereco_consulta`
  FOREIGN KEY (`id_clinica_endereco`)
  REFERENCES `digital_care`.`clinica_endereco` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_paciente_consulta`
  FOREIGN KEY (`id_paciente`)
  REFERENCES `digital_care`.`paciente` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_medico_consulta`
  FOREIGN KEY (`id_medico`)
  REFERENCES `digital_care`.`medico` (`id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION;
  
ALTER TABLE `digital_care`.`clinica` 
DROP FOREIGN KEY `fk_login_clinica`;
ALTER TABLE `digital_care`.`clinica` 
ADD CONSTRAINT `fk_login_clinica`
  FOREIGN KEY (`id_login`)
  REFERENCES `digital_care`.`login` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;

ALTER TABLE `digital_care`.`prontuario_cab` 
DROP FOREIGN KEY `fk_clinica_prontuario_cab`,
DROP FOREIGN KEY `fk_paciente_prontuario_cab`;
ALTER TABLE `digital_care`.`prontuario_cab` 
ADD CONSTRAINT `fk_clinica_prontuario_cab`
  FOREIGN KEY (`id_clinica`)
  REFERENCES `digital_care`.`clinica` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_paciente_prontuario_cab`
  FOREIGN KEY (`id_paciente`)
  REFERENCES `digital_care`.`paciente` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;

ALTER TABLE `digital_care`.`prontuario_item` 
DROP FOREIGN KEY `fk_consulta_prontuario_item`,
DROP FOREIGN KEY `fk_prontuario_cab_item`;
ALTER TABLE `digital_care`.`prontuario_item` 
CHANGE COLUMN `id_consulta` `id_consulta` INT(11) NULL ;
ALTER TABLE `digital_care`.`prontuario_item` 
ADD CONSTRAINT `fk_consulta_prontuario_item`
  FOREIGN KEY (`id_consulta`)
  REFERENCES `digital_care`.`consulta` (`id`)
  ON DELETE SET NULL
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_prontuario_cab_item`
  FOREIGN KEY (`id_prontuario_cab`)
  REFERENCES `digital_care`.`prontuario_cab` (`id`)
  ON DELETE CASCADE
  ON UPDATE NO ACTION;


ALTER TABLE `digital_care`.`clinica_endereco` 
ADD COLUMN `nome` VARCHAR(50) NOT NULL AFTER `id_endereco`;

ALTER TABLE `digital_care`.`medico_clinica` 
ADD UNIQUE INDEX `ix_medico_clinica` (`id_clinica_endereco` ASC, `id_medico` ASC);

ALTER TABLE `digital_care`.`medico` 
ADD UNIQUE INDEX `ix_cpf_medico` (`cpf` ASC);

ALTER TABLE `digital_care`.`clinica_endereco` 
ADD UNIQUE INDEX `ix_clinica_endereco` (`id_clinica` ASC, `id_endereco` ASC);

ALTER TABLE `digital_care`.`login` 
ADD UNIQUE INDEX `ix_email` (`email` ASC);

ALTER TABLE `digital_care`.`medico_convenio` 
ADD UNIQUE INDEX `ix_medico_convenio` (`id_medico` ASC, `id_convenio` ASC);

ALTER TABLE `digital_care`.`medico_especialidade` 
ADD UNIQUE INDEX `ix_medico_especialidade` (`id_medico` ASC, `id_especialidade` ASC);

ALTER TABLE `digital_care`.`paciente_convenio` 
ADD UNIQUE INDEX `ix_paciente_convenio` (`id_paciente` ASC, `id_convenio` ASC);
