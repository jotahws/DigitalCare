SELECT *
FROM paciente_usuario pu 
INNER JOIN paciente p INNER JOIN endereco e 
INNER JOIN cidade c Inner Join estado es
WHERE p.id = pu.id_paciente
AND p.id = pu.id_paciente AND e.id = pu.id_endereco
AND e.id_cidade = c.id AND c.id_estado = es.id;

select * from paciente;
select email from paciente_usuario where email='jota@gmail.com';
select * from endereco ;
select * from cidade;
select * from medico;

SELECT IF(1>2,2,3);

SELECT IFNULL (
				(select email from paciente_usuario where email='jota@gmail.com'), 
				(select email from medico where email='jota@gmail.com')
			   );
               
SELECT IF((select email from paciente_usuario where email='jota@gmail.com'),'yes','no');