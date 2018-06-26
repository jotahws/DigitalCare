# Digital Care

O projeto Digital Care é um sistema de agendamento de consultas, administração de clínicas médicas, organização de prontuários e criação de receitas para clínicas médicas.
O software foi desenvolvido como requisito para aprovação no curso de Análise e Desenvolvimento de Sistemas da Universidade Federal do Paraná (UFPR).

## Desenvolvido com

* [NetBeans](https://netbeans.org/downloads/) - IDE utilizada
* [Java EE](http://www.oracle.com/technetwork/java/javaee/overview/index.html) - Linguagem de Programação
* [Tomcat](http://tomcat.apache.org) - Servidor Web
* [MySQL](https://www.mysql.com) - Sistema de gerenciamento de banco de dados

## Instrução para implantação do sistema

1. Baixar este arquivo Git;
1. Criar uma conexão com um servidor MySQL (versão recomendada: 5.7.x);
1. Rodar o arquivo `/Projeto/Banco De Dados/script_completo.sql` na sua conexão;
    a. Obs.: Caso deseje criar o banco de dados não populado, rodar arquivo `script_esquema.sql`;
1. Alterar o arquivo `/Projeto/DigitalCare/src/java/conexao/bancoDados.properties` para conter a URL do seu servidor MySQL, usuário e senha;
1. Rodar o projeto no NetBeans
    a. Obs.: O servidor Tomcat deve estar instalado
*Em caso de dúvidas ver arquivo `/Projeto/LEIA-ME.pdf`*

## Documentação

A Documentação do sistema se encontra em `/Documentação/Monografia.pdf`

## Autores

* **Gabriel Rossetto Marques** - [russoetto](https://github.com/russoetto)
* **João Henrique Wind** - [jotahws](https://github.com/jotahws)
* **Maurício de Araújo Sforça** - [araujoito](https://github.com/araujoito)
