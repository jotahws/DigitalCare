<%-- 
    Document   : vincular-medico
    Created on : Oct 9, 2017, 1:01:32 PM
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
        <title>Vincular Médico - DigitalCare</title>
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
                                <h1>Adicionar um novo Médico</h1>
                            </div>
                        </div>
                        <hr>
                        <div class="container">
                            <div class="col-md-12">
                                <form action="${pageContext.request.contextPath}/ListaClinicaServlet?action=PesquisaVinculaMedico" method="POST">
                                    <fieldset>
                                        <div class="form-row">
                                            <legend></legend>
                                            <div class="form-group col-md-4">
                                                <label for="cpf">Digite o CPF do médico que deseja vincular</label>
                                                <input type="text" id="cpf" value="${medico.cpf}" name="cpf" class="cpf required form-control">
                                            </div>
                                            <div class="form-group col-md-2">
                                                <label for="">&nbsp;</label>
                                                <div class="form-group col-md-12 ">
                                                    <input type="submit" value="Pesquisar" class="btn btn-digital-green form-control">
                                                </div>
                                            </div>
                                            <div class="col-md-6  form-group">
                                                <label for="">&nbsp;</label>
                                                <div class="form-group col-md-12 ">
                                                    ou&nbsp;&nbsp;&nbsp;
                                                    <a href="${pageContext.request.contextPath}/ListaMedicoServlet?action=listaRegisterMedico" class="btn btn-digital-yellow">
                                                        <i class="fa fa-fw fa-plus"></i>Cadastrar um novo Médico
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>

                        <c:if test="${medico != null}">
                            <div class="container">
                                <hr class="normal-divider">
                                <div class="col-md-12">
                                    <label>Selecione o endereço da clínica:&nbsp;&nbsp;&nbsp;</label>
                                    <select id="clinicaEnd" name="clinicaEnd" class="custom-select col-md-6">
                                        <c:forEach var="item" items="${usuario.listaEnderecos}">
                                            <option value="${item.id}">${item.endereco.rua}, ${item.endereco.numero} - ${item.endereco.bairro}, ${item.endereco.cidade.nome} (${item.endereco.cidade.estado.uf})</option>
                                        </c:forEach>
                                    </select>
                                </div><hr class="invisible-divider">

                                <table class="table">
                                    <thead class="thead-inverse">
                                        <tr>
                                            <th>Nome</th>
                                            <th>CRM</th>
                                            <th>Telefone</th>
                                            <th>Email</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td> ${medico.nome} ${medico.sobrenome}</td>
                                            <td> ${medico.numeroCrm} (${medico.estadoCrm.uf})</td>
                                            <td> ${medico.telefone1}</td>
                                            <td> ${medico.login.email}</td>
                                            <td>
                                                <div class="col-md-12 text-right">
                                                    <a id="vincular" class="btn btn-outline-success clickable">Vincular à Clínica</a>
                                                </div> 
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>                     
                            </div>
                        </c:if>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    $(document).ready(function () {
                        var idMedico = '${medico.id}';
                        $('#vincular').click(function () {
                            swal({
                                title: 'Adicionar médico?',
                                text: "Você poderá desfazer isso indo na sua lista de médicos.",
                                type: 'question',
                                showCancelButton: true,
                                confirmButtonColor: '#68c4af',
                                cancelButtonColor: '#bfd9d2',
                                cancelButtonText: 'Cancelar',
                                confirmButtonText: 'Adicionar'
                            }).then(function () {
                                window.location.href = "ClinicaServlet?action=vincularMedico&idMedico=" + idMedico + "&idClinicaEndereco=" + $('#clinicaEnd').val();
                            });
                        });
                    });
                </script>
            </c:otherwise>
        </c:choose>
    </body>
</html>