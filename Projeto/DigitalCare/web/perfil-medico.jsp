<%-- 
    Document   : perfil-medico
    Created on : Oct 8, 2017, 3:11:21 PM
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
        <title>Medicos - DigitalCare</title>
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
                                <h1>Perfil do médico</h1>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="container ">
                                <div class="form-row">
                                    <div class="row col-md-12">
                                        <div class="col-md-8">
                                            <h4>Sobre o médico</h4> 
                                        </div>
                                        <div class="text-right col-md-4">
                                            <a href="${pageContext.request.contextPath}/horarios-medico.jsp" class="btn btn-digital-green">
                                                <i class="fa fa-fw fa-calendar-o"></i>&nbsp;&nbsp;Editar os horários desse médico
                                            </a>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="nome">Nome:</label>
                                        <input readonly type="text" id="nome" name="nome" class="required form-control" value="${medico.nome} ${medico.sobrenome}">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="cpf">CPF:</label>
                                        <input readonly type="text" id="cpf" name="cpf"   class="cpf required form-control" value="${medico.cpf}">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="datanasc">Data de Nascimento:</label>
                                        <input readonly type="text" id="datanasc" name="dtnsc" class="required data form-control" value="<fmt:formatDate pattern = "dd/MM/yyyy" value = "${medico.dataNascimento}"/>"> 
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="email">E-mail:</label>
                                        <input readonly type="email" id="email" name="email" class="required form-control"  value="${medico.login.email}">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="tel1">Telefone 1:</label>
                                        <input readonly type="text" id="tel1" class="telefone required form-control" name="telefone1"  value="${medico.telefone1}">
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="tel2">Telefone 2:</label>
                                        <input readonly type="text" id="tel2" class="telresidencial form-control" name="telefone2"  value="${medico.telefone2}">
                                    </div>
                                    <div id="accordionDados" class="col-md-12" role="tablist">
                                        <div class="card acordeao">
                                            <div class="card-header" role="tab" id="headingMedico">
                                                <h5 class="mb-0">
                                                    <a class="link-digital-green" class="collapsed" data-toggle="collapse" href="#collapseMedico" aria-expanded="false" aria-controls="collapseMedico">
                                                        Dados médicos
                                                    </a>
                                                </h5>
                                            </div>
                                            <div id="collapseMedico" class="collapse show" role="tabpanel" aria-labelledby="headingMedico" data-parent="#accordionDads">
                                                <div class="card-body row">
                                                    <div class="col-md-12">
                                                        <div class="row">
                                                            <div class="form-group col-md-4">
                                                                <label for="crm">CRM:</label>
                                                                <input readonly type="text" id="crm" name="crm" class="required form-control"   value="${medico.numeroCrm} (${medico.estadoCrm.uf})">
                                                            </div>
                                                            <div class="form-group col-md-4">
                                                                <label for="valor">Valor cobrado por Consulta</label>
                                                                <div class="form-group">
                                                                    <div class="input-group">
                                                                        <span class="input-group-addon" id="basic-addon1">R$</span>
                                                                        <input readonly type="text" id="valor" name="precoConsulta" class="required form-control"  value="${medico.precoConsulta}">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-md-12" for="especialidade">Especialidade(s):</label>
                                                            <c:forEach var="espec" items="${medico.listaEspecialidades}">
                                                                <div class="col-md-3">
                                                                    <input readonly type="text" id="valor" name="precoConsulta" class="required form-control"  value="${espec.nome}">
                                                                </div>
                                                            </c:forEach>
                                                            <br><br><br>
                                                        </div>
                                                        <div class="row">
                                                            <label class="col-md-12" for="planos">Planos(s) de Saúde aceito(s):</label>
                                                            <c:forEach var="conv" items="${medico.listaConvenios}">
                                                                <div class="col-md-3">
                                                                    <input readonly type="text" id="valor" name="precoConsulta" class="required form-control"  value="${conv.nome}">
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-right col-md-12">
                                    <a style=" cursor: pointer" id="desvincular" class="btn btn-lg btn-digital-yellow"><i class="fa fa-fw fa-minus-circle"></i>Desvincular médico</a><br>
                                    <small>
                                        (Você estará desvinculando o médico do endereço ${clinicaEndereco.endereco.rua}, ${clinicaEndereco.endereco.numero} - ${clinicaEndereco.endereco.bairro})
                                    </small>
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
        <script>
            $("#desvincular").click(function () {
                var idMedico = "${medico.id}";
                var idClinica = "${clinicaEndereco.id}";
                swal({
                    title: 'Você tem certeza?',
                    text: "O médico desvinculado não poderá mais realizar consultas nesta clínica",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'desvincular',
                    cancelButtonText: 'cancelar',
                    confirmButtonClass: 'btn btn-success',
                    cancelButtonClass: 'btn btn-danger',
                    buttonsStyling: false
                }).then(function () {
                    window.location.href = "MedicoServlet?action=desvinculaMedico&idMedico=" + idMedico +"&idClinica=" + idClinica;
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                                'Operação cancelada',
                                '',
                                'error'
                                )
                    }
                })

            });
        </script>
    </body>
</html>
