<%-- 
    Document   : cadastroClinica
    Created on : Sep 3, 2017, 5:43:50 PM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="includes/head.jsp" %>
        <title>Cadastrar Clínica - DigitalCare</title>
    </head>
    <body class="login">
        <c:choose>
            <c:when test="${sessionLogin.email != null}">
                <c:redirect url="/index.jsp"/>
            </c:when>
        </c:choose>
        <%@include file="/includes/header.jsp" %>
        <div class="row">
            <div class="col-md-3"></div>
            <div  class="panel-default col-md-6 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Novo Cadastro de Clínica</h2>   
                </div>
                <form action="${pageContext.request.contextPath}/ClinicaServlet?action=register" method="POST">
                    <fieldset>
                        <div class="form-row">
                            <legend>Sobre sua Empresa</legend>
                            <div class="form-group col-md-6">
                                <label for="nomeFantasia">Nome fantasia:</label>
                                <input type="text" id="nomeFantasia" name="nomeFantasia" class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="razaoSocial">Razão social:</label>
                                <input type="text" id="razaoSocial" name="razaoSocial" class="required">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="cnpj">CNPJ:</label>
                                <input type="text" id="cnpj" name="cnpj" placeholder="" class="cnpj required">
                            </div>
                            <div class="form-group col-md-7">
                                <label for="site">Site:</label>
                                <input type="text" id="site" class="required" name="site" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="tel1">Telefone 1:</label>
                                <input type="text" id="tel1" class="telresidencial required" name="tel1" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="tel2">Telefone 2:</label>
                                <input type="text" id="tel2" class="telresidencial" name="tel2" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="email">E-mail:</label>
                                <input type="email" id="email" name="email"  class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="senha">Senha:</label>
                                <input type="password" id="pssw" name="senha"class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="senha2">Confirmar Senha:</label>
                                <input type="password" id="pssw2" name="senha2" class="required">
                            </div>
                            <legend>Endereço</legend>
                            <div class="form-group col-md-4">
                                <label for="cep">CEP: <a href="http://www.buscacep.correios.com.br/sistemas/buscacep/" target="_blank"><i class="fa fa-fw fa-question-circle-o"></i></a></label>
                                <input type="text" id="cep" name="cep" placeholder="" class="required">
                            </div>
                            <div class="form-group col-md-8">
                                <label for="rua">Rua:</label>
                                <input type="text" id="rua" name="rua" readonly="true" class="locked required">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="numero">Número:</label>
                                <input type="text" id="numero" name="numero" class="numero required">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="compl">Complemento:</label>
                                <input type="text" id="compl" name="compl" >
                            </div>
                            <div class="form-group col-md-6">
                                <label for="bairro">Bairro:</label>
                                <input type="text" id="bairro" name="bairro"  readonly="true" class="locked required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="cidade">Cidade:</label>
                                <input type="text" id="cidade" name="cidade" readonly="true" class="locked required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="estado">Estado:</label>
                                <input type="text" id="estado" name="estado" readonly="true" class="locked required">
                            </div>
                            <div class="form-group col-md-12">
                                <input id="VerificaDados" type="submit" value="Cadastrar" class="btn btn-digital-green">
                                <div class="text-right">
                                    <a href="${pageContext.request.contextPath}/cadastroPaciente.jsp">É uma pessoa física?</a>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
    <script>
        $(document).ready(function () {


            $('#VerificaDados').click(function (e) {
                if (!isCNPJValid($('#cnpj').val())) {
                    $('#cnpj').css({
                        "border": "1px solid red",
                        "background": "#FFCECE"
                    });
                    $('#cnpj').after('<span class="clear" style="font-size:0.8em;"> CNPJ incorreto </span>');
                }
            });

            function isCNPJValid(cnpj) {
                cnpj = cnpj.replace(/[^\d]+/g, '');
                if (cnpj == '')
                    return false;
                if (cnpj.length != 14)
                    return false;
                // Elimina CNPJs invalidos conhecidos
                if (cnpj == "00000000000000" ||
                        cnpj == "11111111111111" ||
                        cnpj == "22222222222222" ||
                        cnpj == "33333333333333" ||
                        cnpj == "44444444444444" ||
                        cnpj == "55555555555555" ||
                        cnpj == "66666666666666" ||
                        cnpj == "77777777777777" ||
                        cnpj == "88888888888888" ||
                        cnpj == "99999999999999")
                    return false;

                // Valida DVs
                tamanho = cnpj.length - 2
                numeros = cnpj.substring(0, tamanho);
                digitos = cnpj.substring(tamanho);
                soma = 0;
                pos = tamanho - 7;
                for (i = tamanho; i >= 1; i--) {
                    soma += numeros.charAt(tamanho - i) * pos--;
                    if (pos < 2)
                        pos = 9;
                }
                resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
                if (resultado != digitos.charAt(0))
                    return false;

                tamanho = tamanho + 1;
                numeros = cnpj.substring(0, tamanho);
                soma = 0;
                pos = tamanho - 7;
                for (i = tamanho; i >= 1; i--) {
                    soma += numeros.charAt(tamanho - i) * pos--;
                    if (pos < 2)
                        pos = 9;
                }
                resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
                if (resultado != digitos.charAt(1))
                    return false;

                return true;
            }


        });
    </script>
</html>
