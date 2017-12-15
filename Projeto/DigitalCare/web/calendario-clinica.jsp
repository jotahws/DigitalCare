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
                                <form id="buscaMedico">
                                    <div class="row justify-content-between">
                                        <div class="col-md-9">
                                            <input class="form-control" id="medicoInput" placeholder="Pesquisar...">
                                        </div>
                                        <div class="pr-3 text-right">
                                            <button type="submit" id="" class="btn btn-digital-green"><i class="fa fa-search"></i></button>                                    
                                        </div>
                                    </div>
                                </form>
                                <hr class="small-invisible-divider">
                                <div id="listaMedicos" class="list-group listgroup-medicos">
                                    <div class="text-center">
                                        <i class="text-muted fa fa-spinner fa-spin fa-pulse fa-3x fa-fw"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9">
                                <c:choose>
                                    <c:when test="${(param.status == 'consulta-cancelada')}">
                                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <strong>A consulta foi cancelada! </strong>
                                        </div>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${(param.idMedico == null)}">
                                        <div class="card text-center">
                                            <div class="card-header">
                                              Calendário
                                            </div>
                                            <div class="card-body">
                                              <h4 class="card-title">Selecione um médico ao lado</h4>
                                              <i class="text-muted fa fa-fw fa-5x fa-hand-o-left"></i>
                                              <p class="card-text">O calendário mostra apenas os médicos que estão cadastrados em sua clínica.</p>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div style="" id="calendar"></div>
                                    </c:otherwise>
                                </c:choose>
                                
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="/includes/footer.jsp" %>
                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    
                    function confirmaEmEspera(consultaId){
                        swal({
                            title: 'Você tem certeza?',
                            text: 'Você estará avisando o médico que o paciente se encontra na sala de espera',
                            type: 'question',
                            showCancelButton: true,
                            confirmButtonColor: 'goldenrod',
                            cancelButtonColor: '#bfd9d2',
                            confirmButtonText: 'Mudar status',
                            cancelButtonText: 'Cancelar',
                        }).then(function () {
                            window.location.href = "EstadoConsultaServlet?action=pacienteEmEspera&idConsulta="+consultaId;
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
                            window.location.href = "EstadoConsultaServlet?action=concluiConsultaClinica&idConsulta="+consultaId;
                        });
                    }
                    
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
                            window.location.href = "EstadoConsultaServlet?action=CancelaConsultaClinica&idConsulta="+consultaId;
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
                            case 'Falta':
                                cor = '#888';
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
                                     botoes = '<br><a onclick="confirmaEmEspera('+ event.id +')" class="btn btn-warning clickable">Paciente em espera</a> \n\
                                             <a onclick="confirmaCancela('+ event.id +')" class="btn btn-danger clickable">Cancelar consulta</a>';
                                }else if(event.status == 'Em andamento'){
                                    botoes = '<br><a onclick="confirmaConclui('+ event.id +')" class="btn btn-digital-green clickable">Concluir Consulta</a>';
                                }
                                if (event.status != 'Falta') {
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
                                    });
                                }else{
                                    swal({
                                        title: event.title,
                                        html: '<br><h5>O médico não estará disponível nesse horário.</h5></div>' + botoes,
                                        showCloseButton: true,
                                        showConfirmButton: false,
                                        width: 600,
                                        padding: 50
                                    });
                                }
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
                            height: 800,
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
                                <c:if test="${faltas.size() > 0}">
                                    <c:forEach begin="0" end="${faltas.size()-1}" var="i" >
                                        {
                                            id: '${faltas.get(i).id}',
                                            title: 'Indisponível',
                                            status: 'Falta',
                                            start: '<fmt:formatDate pattern = "yyyy-MM-dd" value = "${faltas.get(i).dataInicio.time}" />T<fmt:formatDate pattern = "HH:mm:ss" value = "${faltas.get(i).dataInicio.time}" />',
                                            end: '<fmt:formatDate pattern = "yyyy-MM-dd" value = "${faltas.get(i).dataFim.time}" />T<fmt:formatDate pattern = "HH:mm:ss" value = "${faltas.get(i).dataFim.time}" />',
                                            color: getCorStatus('Falta')
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
                        $("#buscaMedico").on('submit', function () {
                            $('#listaMedicos').empty();
                            buscaMedico($("#medicoInput").val());
                            return false;
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
