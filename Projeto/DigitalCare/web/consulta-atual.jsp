<%-- 
    Document   : consultaAtual
    Created on : Sep 16, 2017, 11:52:53 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
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
            <c:when test="${param.status == 'sem-proxima-consulta'}">
                <c:redirect url="/ConsultaServlet?action=Dashboard&status=sem-proxima-consulta"/>
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
                                            <a id="showMore" class='link-digital-green' data-toggle="collapse" href="#collapseDados" aria-expanded="true" aria-controls="collapseDados">
                                                (Mostrar mais...)
                                            </a>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <h4 class="card-title">Nome: ${consultaAtual.pacienteUsuario.paciente.nome} ${consultaAtual.pacienteUsuario.paciente.sobrenome}</h4><hr class='small-invisible-divider'>
                                        <h5 class="card-subtitle mb-2 text-muted">
                                            Sexo: 
                                            <c:choose>
                                                <c:when test="${consultaAtual.pacienteUsuario.paciente.sexo == 'M'}">
                                                    Masculino
                                                </c:when>
                                                <c:when test="${consultaAtual.pacienteUsuario.paciente.sexo == 'F'}">
                                                    Feminino
                                                </c:when>
                                                <c:otherwise>
                                                    ${consultaAtual.pacienteUsuario.paciente.sexo}
                                                </c:otherwise>
                                            </c:choose>
                                        </h6>
                                        <hr class='small-invisible-divider'>
                                        <h6 class="card-subtitle mb-2 text-muted">
                                            Telefone:
                                            <c:if test="${consultaAtual.pacienteUsuario.telefone != ''}">
                                                <c:out value="(${fn:substring(consultaAtual.pacienteUsuario.telefone, 0, 2)})${fn:substring(consultaAtual.pacienteUsuario.telefone, 2, 7)}-${fn:substring(consultaAtual.pacienteUsuario.telefone, 7, fn:length(consultaAtual.pacienteUsuario.telefone))}"/>
                                            </c:if>
                                        </h6>
                                        <hr class='small-invisible-divider'>
                                        <h6 class="card-subtitle mb-2 text-muted">Data de nascimento: <fmt:formatDate pattern = "dd/MM/yyyy" value = "${consultaAtual.pacienteUsuario.paciente.dataNascimento}"/></h6>
                                    </div>
                                    <div id="collapseDados" class="collapse" role="tabpanel" aria-labelledby="dadosPaciente" data-parent="#accordion">
                                        <div class="card-body">
                                            <label><strong>Plano(s) de saúde</strong></label>
                                            <table class='col-12'>
                                                <tr>
                                                    <th>Convênio</th>
                                                    <th>Número</th>
                                                </tr>
                                                <c:forEach items="${consultaAtual.pacienteUsuario.paciente.listaConvenios}" var="item">
                                                    <tr>
                                                        <td>${item.convenio.nome}</td>
                                                        <td>${item.numero}</td>
                                                    </tr>
                                                </c:forEach>
                                            </table><Br>
                                            <a href="${pageContext.request.contextPath}/PacienteServlet?action=perfilPacienteMedico&id=${consultaAtual.pacienteUsuario.id}&idPac=${consultaAtual.pacienteUsuario.paciente.id}" class="card-link">Ver perfil completo</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <button id="receita" type="button" class="btn btn-lg btn-outline-dark clickable col-12" data-toggle="modal" data-target="#receitaModal">
                                        <i class="fa fa-fw fa-file-text-o"></i> Receita Médica
                                    </button><br><br>
                                    <button id="atestado" type="button" class="btn btn-lg btn-outline-dark clickable col-12" data-toggle="modal" data-target="#atestadoModal">
                                        <i class="fa fa-fw fa-stethoscope"></i> Atestado Médico
                                    </button><br><br>
                                    <button id="exame" type="button" class="btn btn-lg btn-outline-dark clickable col-12" data-toggle="modal" data-target="#exameModal">
                                        <i class="fa fa-fw fa-files-o"></i> Solicitar Exame
                                    </button>
                                </div>
                            </div>
                            <hr class="invisible-divider">
                            <div class='row'>
                                <div class='col-md-8'>
                                    <div class="row">
                                        <div class='row col-12'>
                                            <h3>Prontuário atual</h3>
                                            <a tabindex="0" class="clickable no-focus" role="button" 
                                               data-toggle="popover" data-trigger="hover" title="Prontuário" data-content="É aqui que devem ser feitas todas as anotações sobre a consulta, como anamnese e exame físico.">
                                                <i class="fa fa-fw fa-question-circle-o"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="row col-md-12 pl-0">
                                        <form id="prontuarioForm" class="form w-100">
                                            <div class="form-group">
                                                <textarea id="prontuario" class="form-control" rows="13"></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-12 row justify-content-end">
                                        <button class="btn clickable btn-outline-success"><i class="fa fa-fw fa-files-o"></i> Anexar exame</button>                                            
                                    </div>
                                </div>
                                <div class="card col-md-4 row border-info">
                                    <div class="card-header row">Linha do Tempo</div>
                                    <div class="card-body px-0 text-info">
                                        <h4 class="card-title text-center">Histórico de prontuários</h4>
                                        <div class="tree justify-content-center row">
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
                                <a href="javascript:void(0);" onclick="confirmaConclui(${consultaAtual.id});" class="btn btn-lg clickable btn-digital-green">
                                    <i class="fa fa-fw fa-check-circle-o"></i> Encerrar Consulta
                                </a>
                            </div>
                            <!--Modal receita-->
                            <div class="modal" id="receitaModal" tabindex="-1" role="dialog" aria-labelledby="receitaModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="receitaModalLabel">Nova Receita Médica</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form class="form">
                                                <div class="form-group">
                                                    <input id="receitaForm" class="form-control">
                                                    <small class="text-muted">Use Enter ↵ ou vírgila para adicionar medicamentos à lista</small>
                                                </div>
                                                <div id="medicamentosSelecionados" class="form-group"></div>
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                                            <button type="button" class="btn btn-primary">Salvar arquivo</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Modal Atestado-->
                            <div class="modal" id="atestadoModal" tabindex="-1" role="dialog" aria-labelledby="atestadoModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="atestadoModalLabel">Novo Atestado Médico</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form class="form-row mb-2">
                                                <div class="form-group col-7">
                                                    <div class="input-group">
                                                        <input id="afastamentoForm" class="form-control" placeholder="Tempo de afastamento (dias)" required >
                                                    </div>
                                                </div>
                                                <div class="form-group col-5">
                                                    <input id="cidForm" class="form-control" placeholder="CID-10 (Opcional)">
                                                </div>
                                            </form>
                                            <div>
                                                <h5 class="text-justify" id="atestadoText">
                                                    <i class="fa fa-2x fa-quote-left"></i>
                                                    &nbsp;&nbsp;Atesto que ${consultaAtual.pacienteUsuario.paciente.nome} ${consultaAtual.pacienteUsuario.paciente.sobrenome} 
                                                    foi atendido(a) nesta clínica, nesta data e que necessita de <span id="afastamentoSpan">________</span> dia(s) de afastamento do trabalho para tratamento de saúde.<br>
                                                    CID: <span id="cidSpan">________</span>
                                                </h5>
                                                <div class="row">
                                                    <jsp:useBean id="now" class="java.util.Date"/>
                                                    <h5 class="col-6"><fmt:formatDate value="${now}" pattern="dd/MM/yyyy" /></h5>
                                                    <i class="fa fa-2x fa-quote-right text-right col-6"></i>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                                            <button id="btnAtestado" type="button" class="btn btn-primary">Salvar arquivo</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Modal Exame-->
                            <div class="modal" id="exameModal" tabindex="-1" role="dialog" aria-labelledby="exameModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exameModalLabel">Solicitar exames ao paciente</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form class="form">
                                                <div class="form-group">
                                                    <input id="examesForm" class="form-control" cols="51" rows="7">
                                                    <small class="text-muted">Use Enter ↵ ou vírgila para adicionar exames à lista</small>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                                            <button type="button" class="btn btn-primary">Salvar arquivo</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>
                <script src="${pageContext.request.contextPath}/components/latinize.js" ></script>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    //colocar temporariamente na sessão o que ele digitou até ele voltar para a pagina
                    window.onbeforeunload = function () {
                        sessionStorage.setItem('prontuarioSession', $('#prontuario').val());
                    };
                    window.onload = function () {
                        var name = sessionStorage.getItem('prontuarioSession');
                        if (name !== null)
                            $('#prontuario').val(name);
                    };
                    $('#prontuarioForm').submit(function () {
                        sessionStorage.removeItem('prontuarioSession');
                    });
                    //fim sessão
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
                    $(document).ready(function () {
                        $('#collapseDados').on('hide.bs.collapse', function () {
                            $('#showMore').html('(Mostrar mais...)');
                        });
                        $('#collapseDados').on('show.bs.collapse', function () {
                            $('#showMore').html('(Mostrar menos...)');
                        });
                        $('.modal').on('show.bs.modal', function (e) {
                            $(this).addClass('animated').addClass('bounceIn').addClass('animate-faster');
                        })
                        $("[data-toggle=popover]").popover();
                        //Atestado----------------------------------------------
                        $('#afastamentoForm').on('keypress keyup', function(){
                            if ($('#afastamentoForm').val() != '') {
                                $('#afastamentoSpan').html($('#afastamentoForm').val());
                            }else{
                                $('#afastamentoSpan').html('________');
                            }
                        });
                        $('#cidForm').on('keypress keyup', function(){
                            if ($('#cidForm').val() != '') {
                                $('#cidSpan').html($('#cidForm').val());
                            }else{
                                $('#cidSpan').html('________');
                            }
                        });
                        $('#btnAtestado').click(function(){
                            $.ajax({
                                url: '<%=request.getContextPath()%>' + '/ProntuarioServlet?action=atestado',
                                type: 'GET',
                                dataType: 'text',
                                contentType: 'application/pdf',
                                data: {
                                    "texto": $('#atestadoText').html()
                                },
                                success: function (data) {
                                    console.log(data);
                                    window.open(data,'_blank');
//                                    displayBook(opn);
//                                    ebookStore.add(opn);
//                                    ebookStore.sync();
                                },
                                error: function () {
                                    
                                }
                            });
                        });
                        //Fim Atestado------------------------------------------
                        $('#examesForm').flexdatalist({
                            data: '',
                            selectionRequired: 0,
                            multiple: true
                        });
                        
                        $('#receitaForm').flexdatalist({
                            data: '',
                            searchIn: 'nome',
                            visibleProperties: ['nome', '({principioAtivo})'],
                            minLength: 1,
                            multiple: true,
                            searchByWord: true,
                            focusFirstResult: true,
                            normalizeString: function (string) {
                                string = string.replace(/(^|\s)\S/g, l => l.toUpperCase());
                                return latinize(string);
                            }
                        });
                                                
                        $("#receitaForm-flexdatalist").on("keyup keypress", function() {
                            if ($(this).val().length == 1) {
                                buscaMedicamentos($(this).val());
                            }
                        });
                        
                        $('#receitaForm').on('change:flexdatalist', function () {
                            $('#medicamentosSelecionados').html('');
                            $.each($(this).flexdatalist('value'), function(key, value){
//                                console.log(key + value);
                                $('#medicamentosSelecionados').append('<div class="form-inline justify-content-between mb-1">\n\
                                                                            <div class="col-md-4 row"><h6>' + value + '</h6></div>\n\
                                                                            <div class="">\n\
                                                                                <input type="text" placeholder="Dose" name="dose[]" class="form-control form-control-sm">\n\
                                                                                <input type="text" placeholder="Via" name="via[]" class="form-control form-control-sm">\n\
                                                                                <input type="text" placeholder="Quantidade" name="quantidade[]" class="form-control form-control-sm">\n\
                                                                            </div>\n\
                                                                        </div>');
                            });
                        });
                    });
                    
                    function buscaMedicamentos(name){
                        $.ajax({
                            url: '<%=request.getContextPath()%>'+'/MedicamentoServlet?action=receitaAjax',
                            type: 'GET',
                            dataType: 'json',
                            data: {
                                'nome': name
                            },
                            success: function (result){
                                $('#receitaForm').flexdatalist('data', result);
                            },
                            error: function (result){
                                console.log(result);
                            }
                        })
                    }
                    
                   
                    
                </script>
            </c:otherwise>
        </c:choose>
    </body>
</html>