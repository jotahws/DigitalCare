<%-- 
    Document   : configuracoes-clinica
    Created on : Sep 20, 2017, 7:50:42 PM
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
                <jsp:useBean id="clinicaBean" class="beans.Clinica"/>
                <%@include file="/includes/headerDash.jsp" %>
                <div class="content-wrapper">
                    <div class="container-fluid">
                        <h1>Dados da Clínica</h1>
                        <hr>
                        <div class="container">
                            <c:choose>
                                <c:when test="${(param.status == 'alter-error')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Opa! </strong> Ocorreu um erro ao alterar os dados. Tente novamente.
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'alter-ok')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Seus dados foram alterados com sucesso!</strong> 
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'excludeEnd-error')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Opa! </strong> Ocorreu um erro ao excluir o endereço. Tente novamente.
                                    </div>
                                </c:when>
                                <c:when test="${(param.status == 'excludeEnd-ok')}">
                                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>O endereço foi excluído com sucesso!</strong> 
                                    </div>
                                </c:when>
                            </c:choose>  
                            <form action="${pageContext.request.contextPath}/ClinicaServlet?action=alter" method="POST">
                                <fieldset>
                                    <div class="form-row">
                                        <h3 class="col-md-12">Sobre sua Empresa</h3>
                                        <div class="form-group col-md-6">
                                            <label for="nomeFantasia">Nome fantasia:</label>
                                            <input type="text" id="nomeFantasia" name="nomeFantasia" class="required form-control" value="${usuario.nomeFantasia}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="razaoSocial">Razão social:</label>
                                            <input type="text" id="razaoSocial" name="razaoSocial" class="required form-control" value="${usuario.razaoSocial}">
                                        </div>
                                        <div class="form-group col-md-5">
                                            <label for="cnpj">CNPJ:</label>
                                            <input type="text" id="cnpj" name="cnpj" class="cnpj required form-control" disabled value="${usuario.cnpj}">
                                        </div>
                                        <div class="form-group col-md-7">
                                            <label for="site">Site:</label>
                                            <input type="text" id="site" class="required form-control" name="site" value="${usuario.site}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="email">E-mail:</label>
                                            <input type="email" id="email" name="email" disabled class="required form-control" value="${usuario.login.email}">
                                        </div>
                                        <div class="form-group col-md-6 text-right">
                                            <br>
                                            <input type="submit" id="VerificaDados" value="Salvar Alterações" class="btn btn-lg btn-digital-green ">
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                            <hr class="normal-divider">
                            <div class="form-row">
                                <div class="row col-md-12">
                                    <div class="col-md-8">
                                        <h3>Endereço(s)</h3>
                                    </div>
                                    <div id="nova-localizacao" class="col-md-4 text-right">
                                        <a href="${pageContext.request.contextPath}/endereco-clinica.jsp" class="adicionar"><i class="fa fa-fw fa-plus-circle"></i>Adicionar um novo endereço</a>
                                    </div>
                                </div>
                                <div class=" col-md-12">
                                    <table id="tabela" class="table">
                                        <thead class="thead-inverse">
                                            <tr class="row">
                                                <th class="col-md-3">Nome</th>
                                                <th class="col-md-2">CEP</th>
                                                <th class="col-md-3">Rua</th>
                                                <th class="col-md-1">Número</th>
                                                <th class="col-md-3"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${usuario.listaEnderecos}">
                                                <tr class="row">
                                                    <td class="col-md-3">${item.nome}</td>
                                                    <td class="col-md-2">${item.endereco.cep}</td>
                                                    <td class="col-md-3">${item.endereco.rua}</td>
                                                    <td class="col-md-1">${item.endereco.numero}</td>
                                                    <td class="col-md-3">
                                                        <div class="col-md-12">
                                                            <a href="${pageContext.request.contextPath}/endereco-clinica.jsp?id=${item.id}" class="btn btn-outline-warning col-md-4">Alterar</a>
                                                            <a onclick="return confirm('Você tem certeza que deseja excluir este endereço?');" href="${pageContext.request.contextPath}/ClinicaServlet?action=excludeEndereco&id=${item.id}" class="btn btn-outline-danger col-md-4">Excluir</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
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
                            </c:choose>                            <div id="accordion" role="tablist">
                                <div class="card" style="margin: 20px 0px 50px">
                                    <div class="card-header " role="tab" id="headingOne">
                                        <h5 class="mb-0">
                                            <a class="link-digital-green" data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                Alterar Senha
                                            </a>
                                        </h5>
                                    </div>
                                    <div id="collapseOne" class="collapse <c:if test="${(param.status == 'alterSenha-error')}">show</c:if>" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
                                            <div class="card-body">
                                                <form action="${pageContext.request.contextPath}/ClinicaServlet?action=alterSenha" method="POST">
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
                                                <button class="btn btn-danger">Excluir minha conta</button>
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

            </c:otherwise>
        </c:choose>
    </body>
</html>
