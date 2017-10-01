<%-- 
    Document   : configuracoes-medico
    Created on : Sep 20, 2017, 7:56:11 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Configurações - DigitalCare</title>
        <%@include file="/includes/head.jsp" %>
        <!-- Style customizado -->
        <link href="${pageContext.request.contextPath}/stylesheet/dash.css" rel="stylesheet">
    </head>

    <body class="fixed-nav sticky-footer" id="page-top">
        <c:choose>
            <c:when test="${sessionLogin.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil != 2)}">
                <div class="content-wrapper">
                    <div class="container">
                        <%@include file="/includes/header.jsp" %>
                        <h1>Acesso Negado.</h1>
                        <h2>Apenas médicos podem acessar essa página</h2>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Navigation -->
                <%@include file="/includes/headerDash.jsp" %>

                <div class="content-wrapper">
                    <div class="container-fluid">
                        <h1>Configurações</h1>
                        <hr class="large-divider">

                        <div class="container">
                            <div class="row">
                                <form action="${pageContext.request.contextPath}/" method="POST">
                                    <fieldset>
                                        <div class="form-row">
                                            <legend>Sobre Você</legend>
                                            <div class="form-group col-md-6">
                                                <label for="nome">Nome:</label>
                                                <input type="text" id="nome" name="nome"class="required form-control">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label for="sobrenome">Sobrenome:</label>
                                                <input type="text" id="sobrenome" name="sobrenome" class="required form-control">
                                            </div>
                                            <div class="form-group col-md-5">
                                                <label for="cpf">CPF:</label>
                                                <input type="text" id="cpf" name="cpf" class="cpf required form-control">
                                            </div>
                                            <div class="form-group col-md-5">
                                                <label for="datanasc">Data de Nascimento:</label>
                                                <input type="text" id="datanasc" name="datanasc" class="required form-control">
                                            </div>
                                            <div class="form-group col-md-2">
                                                <label for="sexo">Sexo:</label>
                                                <select id="sexo" name="sexo" class="custom-select">
                                                    <option value="M">Masculino</option>
                                                    <option value="F">Feminino</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="tel1">Telefone 1:</label>
                                                <input type="text" id="tel1" class="telresidencial required form-control" name="tel1" placeholder="">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="tel2">Telefone 2:</label>
                                                <input type="text" id="tel2" class="telresidencial form-control" name="tel2" placeholder="">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="email">E-mail:</label>
                                                <input type="email" id="email" name="email" class="required form-control">
                                            </div>
                                            <div id="accordionDados" class="col-md-12" role="tablist">
                                                <div class="card acordeao">
                                                    <div class="card-header" role="tab" id="headingEnd">
                                                        <h5 class="mb-0">
                                                            <a class="link-digital-green" data-toggle="collapse" href="#collapseEnd" aria-expanded="true" aria-controls="collapseEnd">
                                                                Endereço
                                                            </a>
                                                        </h5>
                                                    </div>
                                                    <div id="collapseEnd" class="collapse" role="tabpanel" aria-labelledby="headingEnd" data-parent="#accordionDaos">
                                                        <div class="card-body row">
                                                            <div class="form-group col-md-4">
                                                                <label for="cep">CEP: <a href="http://www.buscacep.correios.com.br/sistemas/buscacep/" target="_blank"><i class="fa fa-fw fa-question-circle-o"></i></a></label>
                                                                <input type="text" id="cep" name="cep" placeholder="" class="required form-control">
                                                            </div>
                                                            <div class="form-group col-md-8">
                                                                <label for="rua">Rua:</label>
                                                                <input type="text" id="rua" name="rua" readonly="true" class="locked form-control">
                                                            </div>
                                                            <div class="form-group col-md-3">
                                                                <label for="numero">Número:</label>
                                                                <input type="text" id="numero" name="numero"  class="required form-control">
                                                            </div>
                                                            <div class="form-group col-md-3">
                                                                <label for="compl">Complemento:</label>
                                                                <input type="text" id="compl" name="compl" class="form-control">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label for="bairro">Bairro:</label>
                                                                <input type="text" id="bairro" name="bairro"  readonly="true" class="locked form-control">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label for="cidade">Cidade:</label>
                                                                <input type="text" id="cidade" name="cidade" readonly="true" class="locked form-control">
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label for="estado">Estado:</label>
                                                                <input type="text" id="estado" name="estado" readonly="true" class="locked form-control">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card acordeao">
                                                    <div class="card-header" role="tab" id="headingMedico">
                                                        <h5 class="mb-0">
                                                            <a class="link-digital-green" class="collapsed" data-toggle="collapse" href="#collapseMedico" aria-expanded="false" aria-controls="collapseMedico">
                                                                Dados do médico
                                                            </a>
                                                        </h5>
                                                    </div>
                                                    <div id="collapseMedico" class="collapse" role="tabpanel" aria-labelledby="headingMedico" data-parent="#accordionDads">
                                                        <div class="card-body row">
                                                            <div class="col-md-8">
                                                                <div class="row">
                                                                    <div class="form-group col-md-8">
                                                                        <label for="crm">CRM:</label>
                                                                        <input type="text" id="crm" name="crm" class="required form-control">
                                                                    </div>
                                                                    <div class="form-group col-md-4">
                                                                        <label for="expedicao">Expedição</label>
                                                                        <select id="expedicao" name="expedicao" class="custom-select">
                                                                            <option value="PR">PR</option>
                                                                            <option value="SC">SC</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <label class="col-md-12" for="valor">Valor cobrado por Consulta</label>
                                                                    <div class="form-group col-md-4">
                                                                        <input type="text" id="valor" name="valor" class="required form-control">
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <label class="col-md-12" for="especialidade">Especialidade(s):
                                                                        <a id="newEspec" class="adicionar-verde"><i class="fa fa-fw fa-plus"></i></a>
                                                                    </label>
                                                                    <div id="especDiv" class="form-group col-md-3">
                                                                        <select id="especialidade" name="especialidade1" class="custom-select">
                                                                            <option value="0">Nenhum...</option>
                                                                            <option value="1">Dermatologia</option>
                                                                            <option value="2">Endocrinologia</option>
                                                                        </select>
                                                                    </div>
                                                                    <div id="especDiv" class="form-group col-md-3">
                                                                        <select id="especialidade" name="especialidade2" class="custom-select">
                                                                            <option value="0">Nenhum...</option>
                                                                            <option value="1">Dermatologia</option>
                                                                            <option value="2">Endocrinologia</option>
                                                                        </select>
                                                                    </div>
                                                                    <div id="especDiv" class="form-group col-md-3">
                                                                        <select id="especialidade" name="especialidade3" class="custom-select">
                                                                            <option value="0">Nenhum...</option>
                                                                            <option value="1">Dermatologia</option>
                                                                            <option value="2">Endocrinologia</option>
                                                                        </select>
                                                                    </div>
                                                                    <div id="especDiv" class="form-group col-md-3">
                                                                        <select id="especialidade" name="especialidade4" class="custom-select">
                                                                            <option value="0">Nenhum...</option>
                                                                            <option value="1">Dermatologia</option>
                                                                            <option value="2">Endocrinologia</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <label class="col-md-12" for="plano1">Plano(s) de Saúde Aceito(s): 
                                                                        <a id="newPlano" class="adicionar-verde"><i class="fa fa-fw fa-plus"></i></a>
                                                                    </label>
                                                                    <div id="planoDiv" class="form-group col-md-12">
                                                                        <div class="row">
                                                                            <div class="form-check col-md-3">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" value="1">
                                                                                    Amil
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-md-3">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" value="2">
                                                                                    Unimed
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-md-3">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" value="3">
                                                                                    Clinipan
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-md-3">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" value="4">
                                                                                    Qualicorp
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-md-3">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" value="5">
                                                                                    Bradesco Saúde
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-md-3">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" value="6">
                                                                                    Sul América
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-md-3">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" value="7">
                                                                                    Nossa Saúde
                                                                                </label>
                                                                            </div>
                                                                            <div class="form-check col-md-3">
                                                                                <label class="form-check-label">
                                                                                    <input class="form-check-input" type="checkbox" value="8">
                                                                                    Transmontano Saúde
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <!--<select id="planos" name="plano1" class="custom-select col-md-4">
                                                                                <option value="empty">Nenhum...</option>
                                                                                <option value="Amil">Amil</option>
                                                                                <option value="Unimed">Unimed</option>
                                                                            </select>-->
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4 border-divider">
                                                                <div class="form-group col-md-12">
                                                                    <label for="clinicas">Clínica(s) Vinculada(s)</label>
                                                                    <input type="text" id="clinicas" name="clinicas" class="required form-control">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-12 text-right">
                                                    <input type="submit" id="VerificaDados"  value="Salvar Alterações" class="btn btn-lg btn-digital-green ">
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                            <hr class="dashed-divider">

                            <h3>Avançado</h3>
                            <div id="accordion" role="tablist">
                                <div class="card acordeao">
                                    <div class="card-header " role="tab" id="headingOne">
                                        <h5 class="mb-0">
                                            <a class="link-digital-green" data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                Alterar Senha
                                            </a>
                                        </h5>
                                    </div>
                                    <div id="collapseOne" class="collapse " role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
                                        <div class="card-body">
                                            <form>
                                                <fieldset>
                                                    <div class="form-row">
                                                        <div class="form-group col-md-4">
                                                            <label for="senha-antiga">Senha atual:</label>
                                                            <input type="password" id="senha" name="senha-antiga" class="required form-control">
                                                        </div>
                                                        <div class="form-group col-md-4">
                                                            <label for="nova-senha">Nova senha:</label>
                                                            <input type="password" id="pssw" name="nova-senha" class="required form-control">
                                                        </div>
                                                        <div class="form-group col-md-4">
                                                            <label for="nova-senha2">Confirmar Senha:</label>
                                                            <input type="password" id="pssw2" name="nova-senha2" class="required form-control">
                                                        </div>
                                                        <div class="form-group col-md-12 text-right">
                                                            <label>&nbsp;</label>
                                                            <input type="submit" id="VerificaSenha" value="Alterar senha" class="btn btn-digital-green ">
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </form>                                      
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header" role="tab" id="headingTwo">
                                        <h5 class="mb-0">
                                            <a class="collapsed link-danger" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                Desativar conta
                                            </a>
                                        </h5>
                                    </div>
                                    <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo" data-parent="#accordion">
                                        <div class="card-body">
                                            <p>
                                                <span style="color: red;">Atenção:</span> Ao desativar a conta você estará <strong>excluindo</strong> todos os seus dados e não poderá desfazer essa ação. 
                                            </p>
                                            <div>
                                                <button class="btn btn-danger">Excluir minha conta</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    $(document).ready(function () {
                        var count1 = 1;
                        var count2 = 1;
                        $("#newPlano").click(function () {
                            count1++;
                            if (count1 < 12) {
                                $("#planoDiv").before("<div class=\"form-group col-md-3\"> \n\
                                                <select id=\"planos\" name=\"planos\" class=\"custom-select col-md-4\"> \n\
                                                        <option value=\"Amil\">Amil</option> \n\
                                                        <option value=\"Unimed\">Unimed</option> \n\
                                                </select>\n\
                                            </div>");
                            }
                        });
                        $("#newEspec").click(function () {
                            count2++;
                            if (count2 < 6) {
                                $("#especDiv").before("<div class=\"form-group col-md-3\"> \n\
                                                <select id=\"planos\" name=\"planos\" class=\"custom-select col-md-4\"> \n\
                                                        <option value=\"Amil\">Dermatologia</option> \n\
                                                        <option value=\"Unimed\">Endocrinologia</option> \n\
                                                </select>\n\
                                            </div>");
                            }
                        });
                    });

                </script>
            </c:otherwise>
        </c:choose>
</html>