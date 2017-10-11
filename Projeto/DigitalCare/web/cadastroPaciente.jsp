<%-- 
    Document   : cadastroPaciente
    Created on : Sep 3, 2017, 5:04:03 PM
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
        <title>Cadastrar - DigitalCare</title>
    </head>
    <body class="login">
        <c:choose>
            <c:when test="${sessionLogin.email != null}">
                <c:redirect url="/index.jsp"/>
            </c:when>
        </c:choose>
        <%@include file="/includes/header.jsp" %>
        <div class="row">
            <div class="col-md-2"></div>
            <div  class="panel-default col-md-8 col-sm-12">
                <div class="title-login">
                    <p class="text-center"><img src="images/logo-peq.png" class="page-title-logo"></p>
                    <h2>Novo Cadastro</h2>   
                </div>
                <form action="${pageContext.request.contextPath}/PacienteServlet?action=register" method="POST">
                    <fieldset>
                        <div class="form-row">
                            <legend>Sobre você</legend>
                            <div class="form-group col-md-6">
                                <label for="nome">Nome:</label>
                                <input type="text" id="nome" name="nome" class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="sobrenome">Sobrenome:</label>
                                <input type="text" id="sobrenome" name="sobrenome" class="required">
                            </div>
                            <div class="form-group col-md-5">
                                <label for="cpf">CPF:</label>
                                <input type="text" id="cpf" name="cpf"  class="required">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="dtnsc">Data de Nascimento:</label>
                                <input type="text" id="dtnsc" class="data required" name="dtnsc"  class="required">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="sexo">Sexo:</label>
                                <select id="sexo" name="sexo" class="custom-select">
                                    <option value="M">Masculino</option>
                                    <option value="F">Feminino</option>
                                </select>
                            </div>
                            <legend>Seus Dados</legend>
                            <div class="form-group col-md-4">
                                <label for="tel1">Telefone 1:</label>
                                <input type="text" id="tel1" class="telefone required" name="tel1">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="tel2">Telefone 2:</label>
                                <input type="text" id="tel2" class="telefone" name="tel2" placeholder="">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="email">E-mail:</label>
                                <input type="email" id="email" name="email"class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="pssw">Senha:</label>
                                <input type="password" id="pssw" name="pssw"  class="required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="pssw2">Confirmar Senha:</label>
                                <input type="password" id="pssw2" name="pssw2"  class="required">
                            </div>
                            <legend>Endereço</legend>
                            <div class="form-group col-md-4">
                                <label for="cep">CEP: <a href="http://www.buscacep.correios.com.br/sistemas/buscacep/" target="_blank"><i class="fa fa-fw fa-question-circle-o"></i></a></label>
                                <input type="text" id="cep" name="cep" placeholder="" class="required">
                            </div>
                            <div class="form-group col-md-8">
                                <label for="rua">Rua:</label>
                                <input type="text" id="rua" name="rua"  readonly="true" class="locked required">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="numero">Número:</label>
                                <input type="text" id="numero" name="numero"  class="numero required">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="compl">Complemento:</label>
                                <input type="text" id="compl" name="compl" >
                            </div>
                            <div class="form-group col-md-6">
                                <label for="bairro">Bairro:</label>
                                <input type="text" id="bairro" name="bairro" placeholder="" readonly="true" class="locked required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="cidade">Cidade:</label>
                                <input type="text" id="cidade" name="cidade" placeholder="" readonly="true" class="locked required">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="estado">Estado:</label>
                                <input type="text" id="estado" name="estado" placeholder="" readonly="true" class="locked required">
                            </div>
                            <div class="form-group col-md-12">
                                <input id="VerificaDados" type="submit" value="Cadastrar" class="btn btn-digital-green">
                                <div class="text-right">
                                    <a href="${pageContext.request.contextPath}/cadastroClinica.jsp">Deseja cadastrar sua clínica?</a>
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
                if ($('#cpf').val() != '') {
                    if (!TestaCPF($('#cpf').val())) {
                        $('#cpf').css({
                            "border": "1px solid red",
                            "background": "#FFCECE"
                        });
                        $('#cpf').after('<span class="clear" style="font-size:0.8em;"> CPF incorreto </span>');
                        e.preventDefault();
                    }
                }
            });

            function TestaCPF(strCPF) {
                strCPF = strCPF.replace(/[^\d]+/g, '');

                var Soma;
                var Resto;
                Soma = 0;
                if (strCPF == "00000000000")
                    return false;

                for (i = 1; i <= 9; i++)
                    Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (11 - i);
                Resto = (Soma * 10) % 11;

                if ((Resto == 10) || (Resto == 11))
                    Resto = 0;
                if (Resto != parseInt(strCPF.substring(9, 10)))
                    return false;

                Soma = 0;
                for (i = 1; i <= 10; i++)
                    Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (12 - i);
                Resto = (Soma * 10) % 11;

                if ((Resto == 10) || (Resto == 11))
                    Resto = 0;
                if (Resto != parseInt(strCPF.substring(10, 11)))
                    return false;
                return true;
            }

        });
    </script>
</html>
