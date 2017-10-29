<%-- 
    Document   : resultado-pesquisa-consulta
    Created on : Oct 11, 2017, 8:00:25 PM
    Author     : JotaWind
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta - DigitalCare</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/carousel.css">
        <%@include file="/includes/head.jsp" %>
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionLogin.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:when test="${(sessionLogin.perfil != 1)}">
                <div class="container" style="margin-top: 50px">
                    <%@include file="/includes/header.jsp" %>
                    <h1>Acesso Negado.</h1>
                    <h2>Apenas pacientes podem acessar essa página</h2>
                </div>
            </c:when>
            <c:otherwise>
                <%@include file="/includes/header.jsp" %>
                <div class="container paciente">
                    <div class="row">
                        <div class="col-md-12">
                            <h1>Horários disponíveis para ${tipoConsulta.nome}</h1>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="container ">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="filtro-lateral">
                                <div class="text-center">
                                    <h6>Filtrar resultados</h6><hr>
                                </div>
                                <div>
                                    <form>
                                        <div class="row">
                                            <div id="checks" class="form-group col-md-12">
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        Apenas meu plano de saúde
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        Consultas particulares
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        Apenas minha cidade
                                                    </label>
                                                </div><hr>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        ~Clínica 1~
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="">
                                                        ~Clínica 2~
                                                    </label>
                                                </div><hr class="invisible-divider">
                                                <div class="form-check">
                                                    <button type="submit" class="form-control btn btn-digital-green">
                                                        <i class="fa fa-fw fa-filter "></i> Filtrar
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <c:forEach begin="0" end="${horarios.size()-1}" var="i">
                                    <li class="nav-item">
                                        <a class="nav-link link-digital-green <c:if test="${i == 3}">active</c:if>" id="dia${i}" data-toggle="tab" href="#content${i}" role="tab" aria-controls="content${i}" aria-selected="true">
                                            <fmt:formatDate pattern = "dd/MM/yyyy" value = "${horarios.get(i).dia}" />
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                            <div class="tab-content" id="myTabContent">
                                <c:forEach begin="0" end="${horarios.size()-1}" var="i">
                                    <div class="tab-pane fade <c:if test="${i == 3}">show active</c:if>" id="content${i}" role="tabpanel" aria-labelledby="profile-tab">
                                        <div id="horarios${i}" data-children=".item${i}">
                                            <c:set var="diaVazio" value="true"/>
                                            <c:forEach items="${horarios.get(i).listaHorariosDisponiveis}" var="horarioVazio">
                                                <c:if test="${horarioVazio.listaConsultasDisponiveis.size() > 0}">
                                                    <c:set var="diaVazio" value="false"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${diaVazio == 'true'}">
                                                    <h3 class="mt-4 text-muted">Não há consultas disponíveis para este dia.</h3>
                                                </c:when>
                                                <c:otherwise>
                                                    <h5 class="mt-3">Selecione um horário</h5>
                                                    <div class="row">
                                                        <c:forEach begin="0" end="${horarios.get(i).listaHorariosDisponiveis.size()-1}" var="k">
                                                            <div class="item${i} col-md-2">
                                                                <a data-toggle="collapse" data-parent="#horarios${i}" href="#hora${k}-${i}" aria-expanded="true" aria-controls="hora${k}-${i}">
                                                                    <fmt:formatDate pattern = "HH:mm" value = "${horarios.get(i).listaHorariosDisponiveis.get(k).horario}" />
                                                                </a>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                    <c:forEach begin="0" end="${horarios.get(i).listaHorariosDisponiveis.size()-1}" var="k">
                                                        <div class="item${i}">
                                                            <div id="hora${k}-${i}" class="collapse" role="tabpanel">
                                                                <hr class="invisible-divider">
                                                                <h4><fmt:formatDate pattern = "HH:mm" value = "${horarios.get(i).listaHorariosDisponiveis.get(k).horario}" /></h4>
                                                                <c:choose>
                                                                    <c:when test="${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.size() > 0}">
                                                                        <table id="tabela" class="table table-sm">
                                                                            <thead class="thead-default">
                                                                                <tr>
                                                                                    <th>Clínica</th>
                                                                                    <th>Médico</th>
                                                                                    <th></th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <c:forEach begin="0" end="${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.size()-1}" var="j">
                                                                                    <tr>
                                                                                        <td>${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.get(j).clinica.nome}</td>
                                                                                        <td>${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.get(j).medico.nome} ${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.get(j).medico.sobrenome}</td>
                                                                                        <td>
                                                                                            <div class="col-md-12 text-right">
                                                                                                <a id="detalhe" onclick="Detalhe(${i}, ${k}, ${j})" class="clickable btn btn-sm btn-outline-secondary ">Detalhes</a>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </c:forEach>
                                                                            </tbody>
                                                                        </table>
                                                                    </c:when>
                                                                    <c:when test="${horarios.get(i).listaHorariosDisponiveis.get(k).listaConsultasDisponiveis.size() <= 0}">
                                                                        <h5 class="text-muted">Não há consultas disponíveis para esse horário</h5>
                                                                    </c:when>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="/includes/footer.jsp" %>
            </c:otherwise>
        </c:choose>
    </body>
    <script>
        $(document).ready(function () {

        });
        var horarios = '${horariosJSON}';
        horarios = $.parseJSON(horarios);
        function Detalhe(i, k, j) {
            swal({
                title: horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.nome,
                html: '<div class="left-text"><h3 class="left-text">Consulta</h3>' +
                        '<p>Data: ' + getFormattedDate(new Date(horarios[i].dia)) + ', ' + getFormattedHour(new Date(horarios[i].listaHorariosDisponiveis[k].horario)) + '</p>' +
                        '<p>Duração prevista: 30 min</p>' +
                        '<h3>Clínica</h3>' +
                        '<p><strong>Local: ' + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.nome + '</strong></p>' +
                        '<p>Endereço: ' + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.endereco.rua + ', ' +
                        horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.endereco.numero + ' ' +
                        horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.endereco.complemento + ' - ' +
                        horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.endereco.bairro + ', ' +
                        horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.endereco.cidade.nome + '</p>' +
                        '<p>Telefone: ' + getFormattedPhone(horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.telefone1) + '</p>' +
                        '<p>Site: ' + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].clinica.clinica.site + '</p>' +
                        '<h3>Médico</h3>' +
                        '<p>Nome: ' + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].medico.nome + ' ' +
                        horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].medico.sobrenome + '</p>' +
                        '<p>Preço particular: R$' + horarios[i].listaHorariosDisponiveis[k].listaConsultasDisponiveis[j].medico.precoConsulta + '</p>',
                showCloseButton: true,
                showConfirmButton: true,
                showCancelButton: true,
                confirmButtonColor: '#68c4af',
                cancelButtonColor: '#d33',
                cancelButtonText: 'Cancelar',
                confirmButtonText: 'Marcar consulta',
                width: 600,
                padding: 30
            });
        }

        function getFormattedDate(date) {
            var year = date.getFullYear();

            var month = (1 + date.getMonth()).toString();
            month = month.length > 1 ? month : '0' + month;

            var day = date.getDate().toString();
            day = day.length > 1 ? day : '0' + day;

            return day + '/' + month + '/' + year;
        }

        function getFormattedHour(hour) {

            var h = hour.getHours();
            h = (h < 10) ? ("0" + h) : h;

            var m = hour.getMinutes();
            m = (m < 10) ? ("0" + m) : m;

            return h + ':' + m;
        }

        function getFormattedPhone(number) {
            return number.replace(/(\d{2})(\d{4})(\d{4})/, '($1)$2-$3');
        }
    </script>
</html>
