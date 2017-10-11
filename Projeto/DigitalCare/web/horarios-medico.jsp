<%-- 
    Document   : horários-medico
    Created on : Oct 11, 2017, 11:10:10 AM
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
        <title>Horários do Médico - DigitalCare</title>
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
                        <div class="row">
                            <div class="col-md-8">
                                <h1>Horários Dr(a). André</h1>
                            </div>
                        </div>
                        <hr>
                        <div class="container">
                            <div class="col-md-12">
                                <form action="${pageContext.request.contextPath}/" method="POST">
                                    <fieldset>
                                        <div class="form-row">
                                            <legend>Novo horário</legend>
                                            <div class="form-row">
                                                <div class="col-5">
                                                    <label for="dia-semana">Dia da semana</label>
                                                    <input id="dia-semana" type='text' placeholder='Dia da semana' class='required flexdatalist form-control' 
                                                           data-selection-required='true' data-min-length='0' list='semana' name='dia-semana'>
                                                    <datalist id="semana">
                                                        <option value="Domingo">Domingo</option>
                                                        <option value="Segunda">Segunda-feira</option>
                                                        <option value="Terça">Terça-feira</option>
                                                        <option value="Quarta">Quarta-feira</option>
                                                        <option value="Quinta">Quinta-feira</option>
                                                        <option value="Sexta">Sexta-feira</option>
                                                        <option value="Sábado">Sábado</option>
                                                    </datalist>
                                                </div>
                                                <div class="col">
                                                    <label for="inicio">Início</label>
                                                    <input type="text" id="inicio" name="inicio" class="required hora form-control" placeholder="00:00">
                                                </div>
                                                <div class="col">
                                                    <label for="fim">Fim</label>
                                                    <input type="text" id="fim" name="fim" class="required hora form-control" placeholder="00:00">
                                                </div>
                                                <div class="col">
                                                    <label for="">&nbsp;</label>
                                                    <button type="submit" class="form-control btn btn-digital-yellow"><i class="fa fa-clock-o"></i> Adicionar</button>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                                <hr class="normal-divider">
                                <table class="table">
                                    <thead class="thead-inverse">
                                        <tr>
                                            <th>Domingo</th>
                                            <th>Segunda-feira</th>
                                            <th>Terça-feira</th>
                                            <th>Quarta-feira</th>
                                            <th>Quinta-feira</th>
                                            <th>Sexta-feira</th>
                                            <th>Sábado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>                     
                            </div>
                        </div>


                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>

                <script>
                </script>


            </c:otherwise>
        </c:choose>
    </body>
</html>
