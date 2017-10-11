<%-- 
    Document   : nova-localizacao-clinica
    Created on : Oct 4, 2017, 10:23:07 AM
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
        <title>
            <c:choose>
                <c:when test="${param.id == null}">
                    Novo endereço - DigitalCare
                </c:when>
                <c:when test="${param.id != null}">
                    Alterar endereço - DigitalCare
                </c:when>
            </c:choose>
        </title>
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
                        <c:choose>
                            <c:when test="${param.id == null}">
                                <h1>Novo endereço da Clínica</h1>
                            </c:when>
                            <c:when test="${param.id != null}">
                                <h1>Alterar endereço da Clínica</h1>
                            </c:when>
                        </c:choose>
                        <hr>

                        <div class="container">
                            <c:choose>
                                <c:when test="${(param.status == 'editEnd-ok')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Alteração efetuada com sucesso!</strong> 
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'editEnd-erro')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Ocorreu um erro!</strong> Certifique-se de que o endereço foi carregado antes de clicar em alterar.
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'newEnd-ok')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Novo endereço cadastrado com sucesso!</strong> 
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'newEnd-erro')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Ocorreu um erro!</strong> Certifique-se de que o endereço foi carregado antes de clicar em alterar.
                                    </div>
                                </c:when>
                            </c:choose>
                            <c:forEach var="item" items="${usuario.listaEnderecos}">
                                <c:if test="${item.id == param.id}">
                                    <c:set var="clinicaEndereco" value="${item}"/>
                                </c:if>
                            </c:forEach>
                            <form 
                                <c:choose>
                                    <c:when test="${param.id == null}">
                                        action="${pageContext.request.contextPath}/ClinicaServlet?action=newEndereco"
                                    </c:when>
                                    <c:when test="${param.id != null}">
                                        action="${pageContext.request.contextPath}/ClinicaServlet?action=editEndereco"
                                    </c:when>
                                </c:choose>
                                method="POST">
                                <fieldset>
                                    <div class="form-row">
                                        <legend>Dados da sede:</legend>
                                        <input type="hidden" id="idPaciente" name="id" class="required form-control" value="${clinicaEndereco.id}">
                                        <div class="form-group col-md-4">
                                            <label for="tel1">Telefone 1:</label>
                                            <input type="text" id="tel1" class="telresidencial required form-control" name="tel1" value="${clinicaEndereco.telefone1}">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="tel2">Telefone 2:</label>
                                            <input type="text" id="tel2" class="telresidencial form-control" name="tel2" value="${clinicaEndereco.telefone2}">
                                        </div>
                                        <legend>Endereço:</legend>
                                        <div class="form-group col-md-4">
                                            <label for="cep">CEP: <a href="http://www.buscacep.correios.com.br/sistemas/buscacep/" target="_blank"><i class="fa fa-fw fa-question-circle-o"></i></a></label>
                                            <input type="text" id="cep" name="cep" class="required form-control" value="${clinicaEndereco.endereco.cep}">
                                        </div>
                                        <div class="form-group col-md-8">
                                            <label for="rua">Rua:</label>
                                            <input type="text" id="rua" name="rua" readonly="true" class="locked required form-control" value="${clinicaEndereco.endereco.rua}">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="numero">Número:</label>
                                            <input type="text" id="numero" name="numero"  class="numero required form-control" value="${clinicaEndereco.endereco.numero}">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="compl">Complemento:</label>
                                            <input type="text" id="compl" name="compl" class="form-control" value="${clinicaEndereco.endereco.complemento}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="bairro">Bairro:</label>
                                            <input type="text" id="bairro" name="bairro"  readonly="true" class="locked required form-control" value="${clinicaEndereco.endereco.bairro}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="cidade">Cidade:</label>
                                            <input type="text" id="cidade" name="cidade" readonly="true" class="locked required form-control" value="${clinicaEndereco.endereco.cidade.nome}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="estado">Estado:</label>
                                            <input type="text" id="estado" name="estado" readonly="true" class="locked required form-control" value="${clinicaEndereco.endereco.cidade.estado.nome}">
                                        </div>
                                        <div class="form-group col-md-12 text-right">
                                            <input type="submit" id="VerificaDados" value="Salvar Alterações" class="btn btn-lg btn-digital-green ">
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div> 
                <%@include file="/includes/footer.jsp" %>

                <!-- JS customizado -->
                <script src="js/dash.js"></script>
            </c:otherwise>
        </c:choose>
    </body>
</html>
