<%-- 
    Document   : novo-medico
    Created on : Sep 21, 2017, 10:28:49 AM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Novo Médico - DigitalCare</title>
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
                        <h1>Cadastrar um novo médico</h1>
                        <hr>
                        <div style="" class="table-striped " id="resumo-dia"></div>
                        <div class="container">
                            <c:choose>
                                <c:when test="${(param.status == 'cadastro-ok')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Cadastro efetuado!</strong> O médico deverá completar o seu cadastro para poder realizar consultas
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'cadastro-erro')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Cadastro efetuado!</strong> O médico deverá completar o seu cadastro para poder realizar consultas
                                    </div>
                                </c:when>                            </c:choose>
                            <form action="${pageContext.request.contextPath}/MedicoServlet?action=register" method="POST">
                                <fieldset>
                                    <div class="form-row">
                                        <legend>Dados do médico</legend>
                                        <div class="form-group col-md-4">
                                            <label for="nome">Nome:</label>
                                            <input type="text" id="nome" name="nome"class="required form-control">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="sobrenome">Sobrenome:</label>
                                            <input type="text" id="sobrenome" name="sobrenome" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="email">E-mail:</label>
                                            <input type="email" id="email" name="email" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="dtnsc">Data de Nascimento:</label>
                                            <input type="text" id="dtnsc" class="data required form-control" name="dtnsc" >
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="cpf">CPF:</label>
                                            <input type="text" id="cpf" name="cpf" class="cpf required form-control">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="datanasc">CRM:</label>
                                            <input type="text" id="numeroCrm" name="numeroCrm" class="numero required form-control">
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label for="expedicao">Expedição</label>
                                            <jsp:useBean id="estado" class="beans.Estado"/>
                                            <c:set var="lista" value="${estados}"/>
                                            <select id="expedicao" name="expedicao" class="custom-select">
                                                <c:forEach var="item" items="${lista}">
                                                    <option value="<c:out value="${item.id}"/>"><c:out value="${item.uf}"/></option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="senha1">Senha:</label>
                                            <input type="password" id="pssw" name="senha1" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="senha2">Confirmar Senha:</label>
                                            <input type="password" id="pssw2" name="senha2" class="required form-control">
                                        </div>
                                        <div class="form-group col-md-4 ">
                                            <label for="">&nbsp;</label>
                                            <div class="form-group col-md-6 ">
                                                <input type="submit" value="Cadastrar" class="VerificaDados btn btn-digital-green form-control">
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    $(document).ready(function () {


                        $('.VerificaDados').click(function (e) {
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
            </c:otherwise>
        </c:choose>
    </body>
</html>