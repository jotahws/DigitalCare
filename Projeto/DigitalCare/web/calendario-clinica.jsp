<%-- 
    Document   : calendario-clinica
    Created on : Sep 20, 2017, 7:44:31 PM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Calendário - DigitalCare</title>
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
                        <h1>Calendário</h1>
                        <h4>Selecione um médico para ver seu calendário</h4>
                        <hr>
                        <div class="col-md-12 row">
                            <div class="col-md-3">
                                <div class="row ">
                                    <div class="col-md-9">
                                        <input class="form-control" id="medicoInput" placeholder="Pesquisar...">
                                    </div>
                                    <div class="col-md-3 row text-right">
                                        <button type="submit" id="buscaMedico" class="btn btn-digital-green"><i class="fa fa-search"></i></button>                                    
                                    </div>
                                </div>
                                <hr class="small-invisible-divider">
                                <div id="listaMedicos" class="list-group listgroup-medicos">
                                    <div class="text-center">
                                        <h3 class="color-disabled">Médicos</h3>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div style="" id="calendar"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="/includes/footer.jsp" %>
                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    $(document).ready(function () {
                        new Date($.now());
                        var dt = new Date();
                        var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                        $('#calendar').fullCalendar({
                            locale: 'pt-br',
                            editable: false,
                            eventClick: function (event) {
                                swal({
                                    title: event.title +' '+ event.sobrenome,
                                    html: '<div class="left-text"><h3 class="left-text">Consulta</h3>' +
                                            '<p>Status: '+ event.status +'</p>' +
                                            '<p>Horário: ' + event.horario + '</p>' +
                                            '<p>Duração prevista: 30 min</p>' +
                                            '<h3 class="left-text">Dados Pessoais</h3>' +
                                            '<p><b>Data de Nascimento: '+ event.nascimento +'</b></p>'+
                                            '<p><b>Sexo: '+ event.sexo +'</b></p>',
                                    showCloseButton: true,
                                    showConfirmButton: true,
                                    width: 600,
                                    padding: 50
                                });
                            },
                            header: {
                                left: 'prev,next today myCustomButton',
                                center: 'title',
                                right: 'month,agendaWeek,agendaDay'
                            },
                            timeFormat: 'H(:mm)',
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
                            height: 800,
                            defaultTimedEventDuration: '00:30:00',
                            events: [
                                <c:if test="${consultas.size() > 0}">
                                    <c:forEach begin="0" end="${consultas.size()-1}" var="i" >
                                        {
                                            id: '${i}',
                                            title: '${consultas.get(i).paciente.nome}',
                                            sobrenome: '${consultas.get(i).paciente.sobrenome}',
                                            sexo: '${consultas.get(i).paciente.sexo}',
                                            status: '${consultas.get(i).status}',
                                            nascimento: '<fmt:formatDate pattern = "dd/MM/yyyy" value = "${consultas.get(i).paciente.dataNascimento}" />',
                                            horario: '<fmt:formatDate pattern = "HH:mm" value = "${consultas.get(i).dataHora}" />',
                                            start: '<fmt:formatDate pattern = "yyyy-MM-dd" value = "${consultas.get(i).dataHora}" />T<fmt:formatDate pattern = "HH:mm:ss" value = "${consultas.get(i).dataHora}" />'
                                        },
                                    </c:forEach>
                                </c:if>
                            ]
                        });
                        function buscaMedico(nome) {
                            var calendarioMedicoAtual = '${param.idMedico}';
                            $.post(
                                    "ListaMedicoServlet",
                                    {action: 'PesquisaAJAX', nome: nome}, //meaasge you want to send
                                    function (result) {
                                        $.each(result, function (index, medico) {
                                            $("<a>").appendTo($("#listaMedicos")).append("Dr(a). " + medico.nome + " " + medico.sobrenome).addClass("list-group-item list-group-item-action")
                                                    .attr("href", "ConsultaServlet?action=ClinicaBuscaConsultasMedico&idMedico=" + medico.login.id)
                                                    .attr("id", "medico" + medico.id);
                                            if (medico.login.id == calendarioMedicoAtual) {
                                                $("#medico" + medico.id).addClass("active");
                                            }
                                        });
                                    });
                        }

                        $('#listaMedicos').empty();
                        buscaMedico($("#medicoInput").val());
                        $("#buscaMedico").click(function (e) {
                            $('#listaMedicos').empty();
                            buscaMedico($("#medicoInput").val());
                        });
                        if ($(window).width() < 992) {
                            $('#calendar').fullCalendar('changeView', 'agendaDay');
                        }
                    });
                </script>
            </c:otherwise>
        </c:choose>
    </body>

</html>
