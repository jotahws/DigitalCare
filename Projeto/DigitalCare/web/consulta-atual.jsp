<%-- 
    Document   : consultaAtual
    Created on : Sep 16, 2017, 11:52:53 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <%@include file="/includes/head.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/components/jsTree/tree.css" >
        <script src="${pageContext.request.contextPath}/components/jsTree/tree.js" ></script>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Consulta atual - DigitalCare</title>

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
                        <div class="row">
                            <h1 class="col-9">Consulta em andamento</h1>
                        </div>
                        <hr>
                        <div class='container'>
                            <div class='row'>
                                <div class="card col-md-8">
                                    <div class="card-header row" role="tab" id="dadosPaciente">
                                        <div class='col-md-8 text-left'>
                                            Dados do paciente
                                        </div>
                                        <div class='col-md-4 text-right'>
                                            <a class='link-digital-green' data-toggle="collapse" href="#collapseDados" aria-expanded="true" aria-controls="collapseDados">
                                                (Mostrar mais...)
                                            </a>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <h4 class="card-title">Nome: ~José da Silva~</h4><hr class='small-invisible-divider'>
                                        <h6 class="card-subtitle mb-2 text-muted">Sexo: ~Masculino~</h6><hr class='small-invisible-divider'>
                                        <h6 class="card-subtitle mb-2 text-muted">Data de nascimento: ~13/05/1997~</h6>
                                    </div>
                                    <div id="collapseDados" class="collapse" role="tabpanel" aria-labelledby="dadosPaciente" data-parent="#accordion">
                                        <div class="card-body">
                                            <table class='col-12'>
                                                <tr>
                                                    <th>Plano(s) de saúde</th>
                                                    <th>Email</th>
                                                </tr>
                                                <tr>
                                                    <td>~Plano 1~</td>
                                                    <td>~email@email.com~</td>
                                                </tr>
                                                <tr>
                                                    <td>~Plano 2~</td>
                                                </tr>
                                            </table><Br>
                                            <a href="#" class="card-link">Ver perfil completo</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <a id="receita" class="btn btn-lg btn-outline-dark clickable col-12"><i class="fa fa-fw fa-file-text-o"></i> Receita Médica</a><br><br>
                                    <a id="atestado" class="btn btn-lg btn-outline-dark clickable col-12"><i class="fa fa-fw fa-stethoscope"></i> Atestado Médico</a><br><br>
                                    <a id="exame" class="btn btn-lg btn-outline-dark clickable col-12"><i class="fa fa-fw fa-files-o"></i> Solicitar Exame</a>
                                </div>
                            </div>
                            <hr class="invisible-divider">
                            <div class='row'>
                                <div class='col-md-6'>
                                    <div class="row">
                                        <div class='row col-12'>
                                            <h3>Prontuário atual</h3><a><i class="fa fa-fw fa-question-circle-o"></i></a>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <form class="form">
                                            <div class="form-group">
                                                <textarea class="form-control" cols="51" rows="7"></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-12 text-right">
                                        <button class="btn clickable btn-outline-success"><i class="fa fa-fw fa-files-o"></i> Anexar exame</button>                                            
                                    </div>
                                </div>
                                <div class="card col-md-6 row border-info">
                                    <div class="card-header row">Prescrições</div>
                                    <div class="card-body text-info">
                                        <h4 class="card-title">Histórico de prontuários</h4>
                                        <div class="tree row">
                                            <ul>
                                                <li>
                                                    <span><i class="fa fa-fw fa-folder"></i> 19/03/2017</span>
                                                    <ul>
                                                        <li>
                                                            <span><i class="icon-minus-sign"></i> Child</span>
                                                        </li>
                                                        <li>
                                                            <span><i class="icon-minus-sign"></i> Child</span>
                                                            <ul>
                                                                <li>
                                                                    <span><i class="icon-leaf"></i> Grand Child</span>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <li>
                                                    <span><i class="fa fa-fw fa-folder"></i> 12/07/2005</span>
                                                    <ul>
                                                        <li>
                                                            <span><i class="icon-leaf"></i> Child</span>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-right mt-3">
                                <button class="btn btn-lg clickable btn-digital-green"><i class="fa fa-fw fa-check-circle-o"></i> Encerrar Consulta</button>
                            </div>
                        </div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>

                <script>
                    $(document).ready(function () {
                        $('#receita').click(function () {
                            swal({
                                title: 'Nova receita',
                                html: '<form class="form">' +
                                        '<div class="form-group">' +
                                        '<input class="form-control" cols="51" rows="7">' +
                                        '</div>' +
                                        '<div class="form-group">' +
                                        '<textarea class="form-control" disabled cols="51" rows="7"></textarea>' +
                                        '</div>' +
                                        '</form>',
                                showCancelButton: true,
                                width: 600,
                                confirmButtonColor: '#68c4af',
                                cancelButtonColor: '#bfd9d2',
                                cancelButtonText: 'Cancelar',
                                confirmButtonText: 'Salvar Arquivo'
                            });
                        });
                        $('#exame').click(function () {
                            swal({
                                title: 'Solicitar exame',
                                html: '<form class="form">' +
                                        '<div class="form-group">' +
                                        '<input class="form-control" cols="51" rows="7">' +
                                        '</div>' +
                                        '</form>',
                                showCancelButton: true,
                                width: 600,
                                confirmButtonColor: '#68c4af',
                                cancelButtonColor: '#bfd9d2',
                                cancelButtonText: 'Cancelar',
                                confirmButtonText: 'Solicitar'
                            });
                        });
                        $('#atestado').click(function () {
                            swal({
                                title: 'Novo Atestado',
                                html: '<form class="form">' +
                                        '<div class="form-group">' +
                                        '<input class="form-control" cols="51" rows="7">' +
                                        '</div>' +
                                        '<div class="form-group">' +
                                        '<textarea class="form-control" disabled cols="51" rows="7"></textarea>' +
                                        '</div>' +
                                        '</form>',
                                showCancelButton: true,
                                width: 600,
                                confirmButtonColor: '#68c4af',
                                cancelButtonColor: '#bfd9d2',
                                cancelButtonText: 'Cancelar',
                                confirmButtonText: 'Salvar Arquivo'
                            });
                        });
                    });
                </script>
            </c:otherwise>
        </c:choose>
    </body>
</html>