SELECT *
FROM paciente_usuario pu 
INNER JOIN paciente p INNER JOIN endereco e 
INNER JOIN cidade c Inner Join estado es
WHERE p.id = pu.id_paciente
AND p.id = pu.id_paciente AND e.id = pu.id_endereco
AND e.id_cidade = c.id AND c.id_estado = es.id;

select * from paciente;
select * from paciente_usuario;
select * from endereco;
select * from cidade;
select * from login;
select * from medico;

select * 
from paciente_usuario pu INNER JOIN login l INNER JOIN paciente p INNER JOIN endereco e 
ON pu.id_login = l.id AND pu.id_endereco = e.id AND pu.id_paciente = p.id
where l.email = 'jota@gmail.com' AND l.senha='123';

SELECT * FROM cidade c INNER JOIN estado e ON c.id_estado = e.id WHERE c.id = ?









