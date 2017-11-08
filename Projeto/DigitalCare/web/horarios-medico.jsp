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
                                <h2>Dr(a). ${medico.nome} ${medico.sobrenome}</h2>
                            </div>
                        </div>
                        <hr>
                        <div class="container">
                            <c:choose>
                                <c:when test="${(param.status == 'adiciona-ok')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Horário anotado!</strong>
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'adiciona-erro')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Ocorreu um erro...</strong> Verifique os horários digitados e tente novamente
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'delete-ok')}">
                                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Horário apagado!</strong>
                                    </div>
                                </c:when>
                            </c:choose>
                            <c:forEach items="${medico.listaClinicaEndereco}" var="item">
                                <c:if test="${item.clinica.id == usuario.id}">
                                    <hr class="invisible-divider">


                                    <div class="card" >
                                        <div class="card-body">
                                            <h4 class="card-title">Horários de ${item.nome}</h4>
                                            <h6 class="card-subtitle mb-2 text-muted">${item.endereco.rua}, ${item.endereco.numero} - ${item.endereco.bairro}</h6>
                                                <table class="table table-inverse table-bordered">
                                                    <thead class="thead">
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
                                                    <c:set var="domingo" value=""/>
                                                    <c:set var="segunda" value=""/>
                                                    <c:set var="terca" value=""/>
                                                    <c:set var="quarta" value=""/>
                                                    <c:set var="quinta" value=""/>
                                                    <c:set var="sexta" value=""/>
                                                    <c:set var="sabado" value=""/>
                                                    <c:forEach items="${medico.listaHorarios}" var="horario">
                                                        <c:choose>
                                                            <c:when test="${horario.diaSemana == 1 && item.id == horario.clinicaEndereco.id}">
                                                                <c:set var="domingo" value="${domingo} ${horario.horaInicio} até ${horario.horaFim}
                                                                       <a id='${horario.id}' class='clickable deleteHora' style='color:#f1b0b7'><i class='fa fa-trash fa'></i></a><br>"/>
                                                            </c:when>
                                                            <c:when test="${horario.diaSemana == 2 && item.id == horario.clinicaEndereco.id}">
                                                                <c:set var="segunda" value="${segunda} ${horario.horaInicio} até ${horario.horaFim}
                                                                       <a id='${horario.id}' class='clickable deleteHora' style='color:#f1b0b7'><i class='fa fa-trash fa'></i></a><br>"/>
                                                            </c:when>
                                                            <c:when test="${horario.diaSemana == 3 && item.id == horario.clinicaEndereco.id}">
                                                                <c:set var="terca" value="${terca} ${horario.horaInicio} até ${horario.horaFim}
                                                                       <a id='${horario.id}' class='clickable deleteHora' style='color:#f1b0b7'><i class='fa fa-trash fa'></i></a><br>"/>
                                                            </c:when>
                                                            <c:when test="${horario.diaSemana == 4 && item.id == horario.clinicaEndereco.id}">
                                                                <c:set var="quarta" value="${quarta} ${horario.horaInicio} até ${horario.horaFim} 
                                                                       <a id='${horario.id}' class='clickable deleteHora' style='color:#f1b0b7'><i class='fa fa-trash fa'></i></a><br>"/>
                                                            </c:when>
                                                            <c:when test="${horario.diaSemana == 5 && item.id == horario.clinicaEndereco.id}">
                                                                <c:set var="quinta" value="${quinta} ${horario.horaInicio} até ${horario.horaFim}
                                                                       <a id='${horario.id}' class='clickable deleteHora' style='color:#f1b0b7'><i class='fa fa-trash fa'></i></a><br>"/>
                                                            </c:when>
                                                            <c:when test="${horario.diaSemana == 6 && item.id == horario.clinicaEndereco.id}">
                                                                <c:set var="sexta" value="${sexta} ${horario.horaInicio} até ${horario.horaFim}
                                                                       <a id='${horario.id}' class='clickable deleteHora' style='color:#f1b0b7'><i class='fa fa-trash fa'></i></a><br>"/>
                                                            </c:when>
                                                            <c:when test="${horario.diaSemana == 7 && item.id == horario.clinicaEndereco.id}">
                                                                <c:set var="sabado" value="${sabado} ${horario.horaInicio} até ${horario.horaFim}
                                                                       <a id='${horario.id}' class='clickable deleteHora' style='color:#f1b0b7'><i class='fa fa-trash fa'></i></a><br>"/>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                    <tbody>
                                                        <tr>
                                                            <td>${domingo}</td>
                                                            <td>${segunda}</td>
                                                            <td>${terca}</td>
                                                            <td>${quarta}</td>
                                                            <td>${quinta}</td>
                                                            <td>${sexta}</td>
                                                            <td>${sabado}</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <form action="${pageContext.request.contextPath}/HorarioServlet?action=adicionarHorario" method="POST">
                                                    <fieldset>
                                                        <div class="form-row">
                                                            <div class="col-3">
                                                                <label for="dia-semana">Dia da semana</label>
                                                                <select id="semana" name="dia-semana" class="custom-select form-control">
                                                                    <option value="1">Domingo</option>
                                                                    <option value="2" selected>Segunda-feira</option>
                                                                    <option value="3">Terça-feira</option>
                                                                    <option value="4">Quarta-feira</option>
                                                                    <option value="5">Quinta-feira</option>
                                                                    <option value="6">Sexta-feira</option>
                                                                    <option value="7">Sábado</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-2">
                                                                <label for="inicio">Início</label>
                                                                <input type="hidden" name="idMedico" value="${medico.login.id}"/>
                                                                <input type="hidden" name="idClinicaEnd" value="${item.id}"/>
                                                                <input type="text" id="inicio" name="inicio" class="required hora form-control" required placeholder="00:00">
                                                            </div>
                                                            <div class="col-2">
                                                                <label for="fim">Fim</label>
                                                                <input type="text" id="fim" name="fim" class="required hora form-control" required placeholder="00:00">
                                                            </div>
                                                            <div class="col-3">
                                                                <label for="">&nbsp;</label>
                                                                <button type="submit" class="form-control btn btn-digital-yellow"><i class="fa fa-clock-o"></i> Adicionar</button>
                                                            </div>
                                                        </div>
                                                    </fieldset>
                                                </form>
                                        </div>
                                    </div>
                                    <hr class="large-invisible-divider">
                                </c:if>
                            </c:forEach>
                        </div>


                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>

                <script>
                    $(document).ready(function () {
                        $(".deleteHora").click(function () {
                            var idMedico = '${medico.login.id}'
                            var idHora = $(this).attr('id');
                            swal({
                                title: 'Você tem certeza?',
                                type: 'warning',
                                showCancelButton: true,
                                confirmButtonColor: '#68c4af',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Excluir',
                                cancelButtonText: 'Cancelar',
                            }).then(function () {
                                window.location.href = "HorarioServlet?action=deletarHorario&idHorario=" + idHora + "&idMedico=" + idMedico;
                            }, function (dismiss) {
                                swal({
                                    title: 'Operação cancelada',
                                    timer: 1000
                                }).then(function () {},
                                        // handling the promise rejection
                                                function (dismiss) {
                                                    if (dismiss === 'timer') {
                                                        console.log('I was closed by the timer')
                                                    }
                                                });
                                    });

                        });
                    });

                </script>


            </c:otherwise>
        </c:choose>
    </body>
</html>
