<%-- 
    Document   : configuracoes-clinica
    Created on : Sep 20, 2017, 7:50:42 PM
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
            <c:when test="${(sessionLogin.perfil != 3)}">
                <div class="content-wrapper">
                    <div class="container">
                        <%@include file="/includes/header.jsp" %>
                        <h1>Acesso Negado.</h1>
                        <h2>Apenas Clínicas podem acessar a essa página</h2>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Navigation -->
                <%@include file="/includes/headerDash.jsp" %>
                <div class="content-wrapper">
                    <div class="container-fluid">
                        <h1>Dados da Clínica</h1>
                        <hr>
                        <form action="${pageContext.request.contextPath}/ClinicaServlet?action=alter" method="POST">
                            <fieldset>
                                <div class="form-row">
                                    <legend>Sobre sua Empresa</legend>
                                    <div class="form-group col-md-6">
                                        <label for="nomeFantasia">Nome fantasia:</label>
                                        <input type="text" id="nomeFantasia" name="nomeFantasia"class="required form-control">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="razaoSocial">Razão social:</label>
                                        <input type="text" id="razaoSocial" name="razaoSocial" class="required form-control">
                                    </div>
                                    <div class="form-group col-md-5">
                                        <label for="cnpj">CNPJ:</label>
                                        <input type="text" id="cnpj" name="cnpj"class="cnpj required form-control">
                                    </div>
                                    <div class="form-group col-md-7">
                                        <label for="site">Site:</label>
                                        <input type="text" id="site" class="required form-control" name="site">
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
                                    <legend><hr>Empresa Matriz:</legend>
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
                                    <div class="form-group" id="nova-localizacao">
                                        <a id="btn-localizacao" class="adicionar"><i class="fa fa-fw fa-plus-circle"></i>Adicionar uma nova localização</a>
                                    </div>
                                    <div class="form-group col-md-12 text-right">
                                        <input type="submit" id="VerificaDados" value="Salvar Alterações" class="btn btn-lg btn-digital-green ">
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                        <hr class="dashed-divider">

                        <h3>Avançado</h3>
                        <div id="accordion" role="tablist">
                            <div class="card" style="margin: 20px 0px 50px">
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
                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    $('#btn-localizacao').click(function () {
                        $('#nova-localizacao').before(" <legend><hr>Endereço Secundário:</legend> \n\
                                    <div class=\"form-group col-md-4\"> \n\
                                        <label for=\"cep\">CEP: <a href=\"http://www.buscacep.correios.com.br/sistemas/buscacep/\" target=\"_blank\"><i class=\"fa fa-fw fa-question-circle-o\"></i></a></label> \n\
                                        <input type=\"text\" id=\"cep\" name=\"cep\" placeholder=\"\" class=\"cep required form-control\"> \n\
                                    </div> \n\
                                    <div class=\"form-group col-md-8\"> \n\
                                        <label for=\"rua\">Rua:</label> \n\
                                        <input type=\"text\" id=\"rua\" name=\"rua\" readonly=\"true\" class=\"locked form-control\"> \n\
                                    </div> \n\
                                    <div class=\"form-group col-md-3\"> \n\
                                        <label for=\"numero\">Número:</label> \n\
                                        <input type=\"text\" id=\"numero\" name=\"numero\"  class=\"required form-control\"> \n\
                                    </div> \n\
                                    <div class=\"form-group col-md-3\"> \n\
                                        <label for=\"compl\">Complemento:</label> \n\
                                        <input type=\"text\" id=\"compl\" name=\"compl\" class=\"form-control\"> \n\
                                    </div> \n\
                                    <div class=\"form-group col-md-6\"> \n\
                                        <label for=\"bairro\">Bairro:</label> \n\
                                        <input type=\"text\" id=\"bairro\" name=\"bairro\"  readonly=\"true\" class=\"locked form-control\"> \n\
                                    </div> \n\
                                    <div class=\"form-group col-md-6\"> \n\
                                        <label for=\"cidade\">Cidade:</label> \n\
                                        <input type=\"text\" id=\"cidade\" name=\"cidade\" readonly=\"true\" class=\"locked form-control\"> \n\
                                    </div> \n\
                                    <div class=\"form-group col-md-6\"> \n\
                                        <label for=\"estado\">Estado:</label> \n\
                                        <input type=\"text\" id=\"estado\" name=\"estado\" readonly=\"true\" class=\"locked form-control\"> \n\
                                    </div> \n\
                                    ");
                    });
                </script>
            </c:otherwise>
        </c:choose>
    </body>
</html>
