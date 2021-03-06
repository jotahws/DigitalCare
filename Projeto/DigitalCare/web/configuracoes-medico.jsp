<%-- 
    Document   : configuracoes-medico
    Created on : Sep 20, 2017, 7:56:11 PM
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
        <title>Configurações - DigitalCare</title>
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
                <!-- Navigation -->
                <%@include file="/includes/headerDash.jsp" %>

                <div class="content-wrapper">
                    <div class="container-fluid">
                        <h1>Configurações</h1>
                        <hr class="large-divider">

                        <div class="container">
                            <c:choose>
                                <c:when test="${(param.status == 'edit-error')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Opa! </strong> Ocorreu um erro ao alterar os dados. Tente novamente.
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'edit-ok')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Seus dados foram alterados com sucesso!</strong> 
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'erro-deleta')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Ocorreu um erro ao deletar sua conta!</strong> 
                                    </div>
                                </c:when>
                            </c:choose> 
                            <div class="row">
                                <jsp:useBean id="medicoBean" class="beans.Medico"/>
                                <form action="${pageContext.request.contextPath}/MedicoServlet?action=edit" method="POST">
                                    <fieldset>
                                        <div class="form-row">
                                            <legend>Sobre Você</legend>
                                            <div class="form-group col-md-6">
                                                <label for="nome">Nome:</label>
                                                <input type="text" id="nome" name="nome"class="required form-control" value="${usuario.nome}">
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label for="sobrenome">Sobrenome:</label>
                                                <input type="text" id="sobrenome" name="sobrenome" class="required form-control" value="${usuario.sobrenome}">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="cpf">CPF:</label>
                                                <input type="text" id="cpf" name="cpf" disabled="" class="cpf required form-control" value="${usuario.cpf}">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="datanasc">Data de Nascimento:</label>
                                                <input type="text" id="datanasc" name="dtnsc" class="required data form-control" value="<fmt:formatDate pattern = "dd/MM/yyyy" value = "${usuario.dataNascimento}"/>"> 
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="email">E-mail:</label>
                                                <input type="email" id="email" name="email" class="required form-control"  value="${usuario.login.email}">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="tel1">Telefone 1:</label>
                                                <input type="text" id="tel1" class="telefone required form-control" name="telefone1"  value="${usuario.telefone1}">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="tel2">Telefone 2:</label>
                                                <input type="text" id="tel2" class="telresidencial form-control" name="telefone2"  value="${usuario.telefone2}">
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
                                                            <div class="col-md-8">
                                                                <div class="row">
                                                                    <div class="form-group col-md-8">
                                                                        <label for="crm">CRM:</label>
                                                                        <input type="text" id="crm" name="crm" class="required form-control" disabled="" value="${usuario.numeroCrm}">
                                                                    </div>
                                                                    <div class="form-group col-md-4">
                                                                        <label for="expedicao">Expedição</label>
                                                                        <input type="text" id="expedicao" name="expedicao" class="required form-control" disabled="" value="${usuario.estadoCrm.uf}">
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <label class="col-md-12" for="valor">Valor cobrado por Consulta</label>
                                                                    <div class="form-group col-md-4">
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon" id="basic-addon1">R$</span>
                                                                            <input type="text" id="valor" name="precoConsulta" class="required form-control money"  value="${usuario.precoConsulta}">
                                                                        </div>
                                                                    </div>

                                                                </div>
                                                                <div class="row">
                                                                    <label class="col-md-12" for="especialidade">Especialidade(s):
                                                                    </label>
                                                                    <jsp:useBean id="especialidade" class="beans.Especialidade"/>

                                                                    <div class='col-md-12'>
                                                                        <input type='text'
                                                                               value='<c:forEach items="${especMedico}" var="item">${item.id}, </c:forEach>'
                                                                                   class='flexdatalist form-control'
                                                                                   data-data='[<c:forEach begin='0' end="${espec.size()-1}" var="i"> {"id":"${espec.get(i).id}","nome":"${espec.get(i).nome}"}<c:if test="${i != espec.size()-1}">,</c:if></c:forEach>]'
                                                                                       data-search-in='nome'
                                                                                       data-visible-properties='nome'
                                                                                       data-selection-required='true'
                                                                                       data-value-property='id'
                                                                                       data-text-property='{nome}'
                                                                                       data-min-length='0'
                                                                                       multiple='multiple'
                                                                                       name='especialidades'>
                                                                               </div>
                                                                        </div><hr class='invisible-divider'>
                                                                        <div class="row">
                                                                            <label class="col-md-12" for="planos">Plano(s) de Saúde Aceito(s):
                                                                            </label>
                                                                    <jsp:useBean id="conveniosM" class="beans.Convenio"/>

                                                                    <div class='col-md-12'>
                                                                        <input type='text'
                                                                               value='<c:forEach items="${conveniosMedico}" var="item">${item.id}, </c:forEach>'
                                                                                   class='flexdatalist form-control'
                                                                                   data-data='[<c:forEach begin='0' end="${convenios.size()-1}" var="i"> {"id":"${convenios.get(i).id}","nome":"${convenios.get(i).nome}"}<c:if test="${i != convenios.size()-1}">,</c:if></c:forEach>]'
                                                                                       data-search-in='nome'
                                                                                       data-visible-properties='nome'
                                                                                       data-selection-required='true'
                                                                                       data-value-property='id'
                                                                                       data-text-property='{nome}'
                                                                                       data-min-length='0'
                                                                                       multiple='multiple'
                                                                                       name='convenios'>
                                                                               </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4 border-divider">
                                                                        <div class="form-group col-md-12">
                                                                            <label for="clinicas">Clínica(s) Vinculada(s)</label>
                                                                        <c:forEach items="${clinicas}" var="clinica">
                                                                            <h5>${clinica.nome}</h5>
                                                                        </c:forEach>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-12 text-right">
                                                            <input type="submit" id="VerificaDados"  value="Salvar Alteralções" class="btn btn-lg btn-digital-green ">
                                                        </div>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </div>
                                    <hr class="dashed-divider">
                                    <h3>Avançado</h3>
                            <c:choose>
                                <c:when test="${(param.status == 'alterSenha-error')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Opa! </strong> A senha atual digitada está incorreta!
                                    </div>
                                </c:when>

                                <c:when test="${(param.status == 'alterSenha-ok')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Nova Senha Editada com Sucesso!</strong> 
                                    </div>
                                </c:when>
                            </c:choose> 
                            <div id="accordion" role="tablist">
                                <div class="card acordeao">
                                    <div class="card-header " role="tab" id="headingOne">
                                        <h5 class="mb-0">
                                            <a class="link-digital-green" data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                Alterar Senha
                                            </a>
                                        </h5>
                                    </div>
                                    <div id="collapseOne" class="collapse <c:if test="${(param.status == 'alterSenha-error')}">show</c:if>" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
                                            <div class="card-body">
                                                <form action="${pageContext.request.contextPath}/MedicoServlet?action=alterSenha" method="POST">
                                                <fieldset>
                                                    <div class="form-row">
                                                        <div class="form-group col-md-4">
                                                            <label for="senha-antiga">Senha atual:</label>
                                                            <input type="password" id="senha" name="senha-antiga" class="required form-control">
                                                        </div>
                                                        <div class="form-group col-md-4">
                                                            <label for="nova-senha">Nova senha:</label>
                                                            <input type="password" id="pssw" name="nova-senha" class="required form-control">
                                                        </div>
                                                        <div class="form-group col-md-4">
                                                            <label for="nova-senha2">Confirmar Senha:</label>
                                                            <input type="password" id="pssw2" name="nova-senha2" class="required form-control">
                                                        </div>
                                                        <div class="form-group col-md-12 text-right">
                                                            <label>&nbsp;</label>
                                                            <input type="submit" id="VerificaSenha" value="Alterar senha" class="btn btn-digital-green ">
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </form>                                      
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header" role="tab" id="headingTwo">
                                        <h5 class="mb-0">
                                            <a class="collapsed link-danger" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                Desativar conta
                                            </a>
                                        </h5>
                                    </div>
                                    <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo" data-parent="#accordion">
                                        <div class="card-body">
                                            <p>
                                                <span style="color: red;">Atenção:</span> Ao desativar a conta você estará <strong>excluindo</strong> todos os seus dados e não poderá desfazer essa ação. 
                                            </p>
                                            <div>
                                                <a id="deletarPerfil" style="color: white; cursor: pointer" class="btn btn-danger">Excluir minha conta </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div> 

                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
                <script>
                    $(document).ready(function () {

                        $("#deletarPerfil").click(function () {
                            swal({
                                title: 'Você tem certeza?',
                                text: "Você não poderá desfazer isso!",
                                type: 'warning',
                                showCancelButton: true,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Sim, exclua!',
                                cancelButtonText: 'cancelar!',
                            }).then(function () {
                                window.location.href = "MedicoServlet?action=excluir";
                            }, function (dismiss) {
                                if (dismiss === 'cancel') {
                                    swal(
                                            'Operação cancelada',
                                            'Sua conta não foi apagada :)',
                                            'error'
                                            )
                                }
                            })

                        });
                    });

                </script>
            </c:otherwise>
        </c:choose>
</html>
