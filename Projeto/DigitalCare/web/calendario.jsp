<%-- 
    Document   : calendar
    Created on : Sep 14, 2017, 11:33:46 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-br">

    <head>
        <meta charset="UTF-8">
        <%@include file="/includes/head.jsp" %>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Calendário - DigitalCare</title>
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
                        <div class="row justify-content-between ml-1">       
                            <h1 class="">Calendário</h1>       
                            <div class="align-self-center">           
                                <a href="${pageContext.request.contextPath}/ConsultaServlet?action=indisponibilidade" class=" btn-lg pl-0">
                                    <i class="fa fa-fw fa-clock-o"></i>Marcar indisponibilidade
                                </a>
                            </div>   
                        </div>
                        <hr>
                        <div class="row">

                            <div class="col-md-3">
                                <div class="data-box-sm data-box data-box-light ">
                                    <h2>
                                        <c:set var="isNull" value="true"/>
                                        <c:forEach items="${statusConsultas}" var="status">
                                            <c:if test="${status[0] == 'Em espera'}">
                                                ${status[1]}
                                                <c:set var="isNull" value="false"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${isNull == 'true'}">
                                            0
                                        </c:if>
                                    </h2>
                                    <p>Paciente(s) na sala de espera</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="data-box bg-warning-light data-box-sm">
                                    <h2>
                                        <c:set var="isNull" value="true"/>
                                        <c:forEach items="${statusConsultas}" var="status">
                                            <c:if test="${status[0] == 'Marcado'}">
                                                ${status[1]}
                                                <c:set var="isNull" value="false"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${isNull == 'true'}">
                                            0
                                        </c:if>
                                    </h2>
                                    <p>Paciente(s) Restante(s) para hoje</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="data-box bg-danger-light data-box-sm">
                                    <h2>
                                        <c:set var="isNull" value="true"/>
                                        <c:forEach items="${statusConsultas}" var="status">
                                            <c:if test="${status[0] == 'Cancelado'}">
                                                ${status[1]}
                                                <c:set var="isNull" value="false"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${isNull == 'true'}">
                                            0
                                        </c:if>
                                    </h2>
                                    <p>Paciente(s) Cancelado(s) para hoje</p>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <a onclick="confirmaProximoPaciente()" class="clickable btn-data-box-row btn btn-digital-green"><i class="fa fa-2x pull-right fa-arrow-circle-o-right"></i>Chamar Próximo Paciente</a>
                            </div>
                        </div>
                        <div style="" id="calendar"></div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
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
                    
                    function confirmaProximoPaciente(){
                        swal({
                            title: 'Chamar próximo paciente?',
                            type: 'question',
                            showCancelButton: true,
                            confirmButtonColor: '#68c4af',
                            cancelButtonColor: '#bfd9d2',
                            confirmButtonText: 'Sim',
                            cancelButtonText: 'Não',
                        }).then(function () {
                            window.location.href = "EstadoConsultaServlet?action=proximaConsulta";
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
                        $('#calendar').fullCalendar({
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
                                            '<p>Status: '+ event.status +'</p>' +
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
                                left: 'prev,next today myCustomButton',
                                center: 'title',
                                right: 'month,agendaWeek,agendaDay'
                            },
                            timeFormat: 'H:mm',
                            buttonText: {
                                today: 'Hoje',
                                month: 'Mês',
                                week: 'Semana',
                                day: 'Dia',
                                list: 'Lista'
                            },
                            allDaySlot: false,
                            slotLabelFormat: "HH:mm",
                            defaultView: 'agendaWeek',
                            columnFormat: 'ddd DD/MM',
                            scrollTime: time,
                            height: 600,
                            defaultTimedEventDuration: '00:30:00',
                            eventTextColor: '#fff',
                            events: [
                                <c:if test="${consultas.size() > 0}">
                                    <c:forEach begin="0" end="${consultas.size()-1}" var="i" >
                                        {
                                            id: '${consultas.get(i).id}',
                                            title: '${consultas.get(i).paciente.nome}',
                                            sobrenome: '${consultas.get(i).paciente.sobrenome}',
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
                        if ($(window).width() < 992) {
                            $('#calendar').fullCalendar('changeView', 'agendaDay');
                        }
                    });
                </script>
                <!--FIM Calendario-->
            </c:otherwise>
        </c:choose>
    </body>
</html>
