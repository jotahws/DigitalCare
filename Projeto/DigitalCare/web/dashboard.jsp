
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Dashboard - DigitalCare</title>

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
                <!--Calendario-->
                <script>
                    function confirmaCancela(consultaId){
                        swal({
                            title: 'Você tem certeza?',
                            type: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#dc3545',
                            cancelButtonColor: '#bfd9d2',
                            confirmButtonText: 'Desmarcar consulta',
                            cancelButtonText: 'Cancelar',
                        }).then(function () {
                            window.location.href = "EstadoConsultaServlet?action=CancelaConsultaMedico&idConsulta="+consultaId;
                        });
                    }
                    
                    function confirmaConclui(consultaId){
                        swal({
                            title: 'Você tem certeza?',
                            type: 'question',
                            showCancelButton: true,
                            confirmButtonColor: '#68c4af',
                            cancelButtonColor: '#bfd9d2',
                            confirmButtonText: 'Concluir consulta',
                            cancelButtonText: 'Cancelar',
                        }).then(function () {
                            window.location.href = "EstadoConsultaServlet?action=concluiConsulta&idConsulta="+consultaId;
                        });
                    }
                    
                    function confirmaInicia(consultaId){
                        swal({
                            title: 'Você tem certeza?',
                            type: 'question',
                            showCancelButton: true,
                            confirmButtonColor: 'dodgerblue',
                            cancelButtonColor: '#bfd9d2',
                            confirmButtonText: 'Iniciar consulta',
                            cancelButtonText: 'Cancelar',
                        }).then(function () {
                            window.location.href = "EstadoConsultaServlet?action=iniciaConsulta&idConsulta="+consultaId;
                        });
                    }
                    
                    function getCorStatus(status){
                        var cor = '#fff';
                        switch(status) {
                            case 'Cancelado':
                                cor = 'crimson';
                                break;
                            case 'Marcado':
                                cor = 'dodgerblue';
                                break;
                            case 'Em espera':
                                cor = 'goldenrod';
                                break;
                            case 'Concluído':
                                cor = 'green';
                                break;
                            case 'Em andamento':
                                cor = '#68c4af';
                                break;
                            default:
                                cor = 'dodgerblue';
                        }
                        return cor
                    }
                    
                    $(document).ready(function () {
                        new Date($.now());
                        var dt = new Date();
                        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                        $('#resumo-dia').fullCalendar({
                            locale: 'pt-br',
                            editable: false,
                            eventClick: function (event) {
                                var botoes='';
                                if (event.status == 'Marcado' || event.status == 'Em espera') {
                                     botoes = '<br><a onclick="confirmaInicia('+ event.id +')" class="btn btn-info clickable">Iniciar consulta</a> \n\
                                             <a onclick="confirmaConclui('+ event.id +')" class="btn btn-digital-green clickable">Consulta concluída</a> \n\
                                             <a onclick="confirmaCancela('+ event.id +')" class="btn btn-danger clickable">Cancelar consulta</a>';
                                }else if(event.status == 'Em andamento'){
                                    botoes = '<br><a onclick="confirmaConclui('+ event.id +')" class="btn btn-digital-green clickable">Concluir Consulta</a>';
                                }
                                swal({
                                    title: event.title,
                                    html: '<div class="left-text"><h3 class="left-text">Consulta</h3>' +
                                            '<h5>Status: <strong>'+ event.status +'</strong></h5>' +
                                            '<p>Horário: ' + event.horario + '</p>' +
                                            '<p>Duração prevista: 30 min</p>' +
                                            '<h3 class="left-text">Dados Pessoais</h3>' +
                                            '<p><b>Data de Nascimento: '+ event.nascimento +'</b></p>'+
                                            '<p><b>Sexo: '+ event.sexo +'</b></p></div>' + botoes,
                                    showCloseButton: true,
                                    showConfirmButton: false,
                                    width: 600,
                                    padding: 50
                                })
                            },
                            header: {
                                left: 'title',
                                center: '',
                                right: ''
                            },
                            noEventsMessage: 'Não há consultas para hoje',
                            listDayFormat: 'dddd',
                            listDayAltFormat: 'DD [de] MMMM [de] YYYY',
                            titleFormat: "[Resumo para hoje]",
                            timeFormat: 'H:mm',
                            allDaySlot: false,
                            height: 350,
                            slotLabelFormat: "HH:mm",
                            defaultView: 'listDay',
                            columnFormat: 'ddd DD/MM',
                            scrollTime: time,
                            defaultTimedEventDuration: '00:30:00',
                            eventTextColor: '#fff',
                            events: [
                                <c:if test="${consultas.size() > 0}">
                                    <c:forEach begin="0" end="${consultas.size()-1}" var="i" >
                                        {
                                            id: '${consultas.get(i).id}',
                                            idPusu: '${consultas.get(i).paciente.id}',
                                            title: '${consultas.get(i).paciente.nome} ${consultas.get(i).paciente.sobrenome}',
                                            sexo: '${consultas.get(i).paciente.sexo}',
                                            status: '${consultas.get(i).status}',
                                            nascimento: '<fmt:formatDate pattern = "dd/MM/yyyy" value = "${consultas.get(i).paciente.dataNascimento}" />',
                                            horario: '<fmt:formatDate pattern = "HH:mm" value = "${consultas.get(i).dataHora}" />',
                                            start: '<fmt:formatDate pattern = "yyyy-MM-dd" value = "${consultas.get(i).dataHora}" />T<fmt:formatDate pattern = "HH:mm:ss" value = "${consultas.get(i).dataHora}" />',
                                            color: getCorStatus('${consultas.get(i).status}')
                                        },
                                    </c:forEach>
                                </c:if>
                            ]
                        });
                        if ($(window).width() <= 1338) {
                            $('.stats').removeClass('col-md-3');
                            $('.stats').addClass('col-md-6');
                        }
                    });
                </script>
                <!--FIM Calendario-->

                <!-- Navigation -->
                <%@include file="/includes/headerDash.jsp" %>

                <div class="content-wrapper">
                    <div class="container-fluid">
                        <h1>Dashboard</h1>
                        <hr>
                        <c:choose>
                            <c:when test="${(param.status == 'consulta-cancelada')}">
                                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <strong>Sua consulta foi cancelada! </strong>
                                </div>
                            </c:when>
                            <c:when test="${(param.status == 'sem-proxima-consulta')}">
                                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <strong><i class="fa fa-home"></i> Pode ir para casa! </strong> Sem mais consultas para hoje.
                                </div>
                            </c:when>
                        </c:choose>
                        <div style="" class="table-striped " id="resumo-dia"></div><hr class="invisible-divider">
                        <div class="row">
                            <h2 class="col-md-12">Estatísticas</h2>
                        </div>
                        <div class="row">
                            <div class="col-md-3 col-sm-6 stats">
                                <div class="data-box data-box-dark mt-2">
                                    <h2>
                                        <c:forEach items="${stats.get(0)}" var="item">
                                            <c:if test="${item[0] == 'total'}">
                                                ${item[1]}
                                            </c:if>
                                        </c:forEach> pacientes
                                    </h2>
                                    <p>foram consultados por você nos últimos 7 dias pela DigitalCare, sendo eles 
                                        <strong>
                                            <c:set var="vazioM" value="true"/>
                                            <c:forEach items="${stats.get(0)}" var="item">
                                                <c:if test="${item[0] == 'M'}">
                                                    ${item[1]}
                                                    <c:set var="vazioM" value="false"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${vazioM == 'true'}">0</c:if>
                                        </strong>
                                        do sexo masculino e 
                                        <strong>
                                            <c:set var="vazioF" value="true"/>
                                            <c:forEach items="${stats.get(0)}" var="item">
                                                <c:if test="${item[0] == 'F'}">
                                                    ${item[1]}
                                                    <c:set var="vazioM" value="false"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${vazioF == 'true'}">0</c:if>
                                        </strong> 
                                        do sexo feminino.</p>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 stats">
                                <div class="data-box data-box-light mt-2">
                                    <h2>${stats.get(1).get(0)[0]} consultas</h2>
                                    <p>foram realizadas ao todo por você pela DigitalCare</p>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 stats">
                                <div class="data-box data-box-dark mt-2">
                                    <h2>${stats.get(2).get(0)[0]}</h2>
                                    <p>é, na maioria das vezes, o dia da semana que você mais tem consultas marcadas. Você já realizou ${stats.get(2).get(0)[1]} consultas nesse dia!</p>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6 stats">
                                <div class="data-box data-box-light mt-2">
                                    <h2>${stats.get(3).get(0)[0]}%</h2>
                                    <p>dos pacientes que marcaram um horário com você desmarcaram a consulta.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
            </c:otherwise>
        </c:choose>
                <!--1338-->
</html>
