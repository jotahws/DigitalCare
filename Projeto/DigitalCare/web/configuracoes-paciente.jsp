<%-- 
    Document   : configuracoes-paciente
    Created on : Sep 29, 2017, 11:02:10 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Configurações - DigitalCare</title>
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
                        <div class="col-md-7">
                            <h1 class="">Configurações</h1>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="container">
                    <c:choose>
                        <c:when test="${(param.status == 'altera-ok')}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <strong>Alteração efetuada com sucesso!</strong> 
                            </div>
                        </c:when>
                    </c:choose>
                    <div class="row">
                        <div class="col-md-12">                            
                            <form action="${pageContext.request.contextPath}/PacienteServlet?action=alteraPerfil" method="POST">
                                <fieldset>
                                    <jsp:useBean id="pacienteEdita" class="beans.PacienteUsuario"/>
                                    <c:set var="item" value="${paciente}"/>
                                    <div class="form-row">
                                        <c:choose>
                                            <c:when test="${(param.status == 'senhas-erro')}">
                                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                    <strong>Senhas erradas!</strong> 
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
                                        <legend>Sobre Você</legend>
                                        <div class="form-group col-md-6">
                                            <label for="nome">Nome:</label>
                                            <input type="text" id="nome" name="nome"class="required form-control" value="${item.paciente.nome}">
                                            <input type="hidden" id="idPaciente" name="idPaciente" class="required form-control" value="${item.paciente.id}">

                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="sobrenome">Sobrenome:</label>
                                            <input type="text" id="sobrenome" name="sobrenome" class="required form-control" value="${item.paciente.sobrenome}">
                                        </div>
                                        <div class="form-group col-md-5">
                                            <label for="cpf">CPF:</label>
                                            <input type="text" id="cpf" name="cpf" class="cpf required form-control" value="${item.paciente.cpf}">
                                        </div>
                                        <div class="form-group col-md-5">
                                            <label for="dtnsc">Data de Nascimento:</label>
                                            <input type="text" id="dtnsc" name="dtnsc" class="required form-control" value="<fmt:formatDate type='both' pattern='dd/MM/yyyy' value='${item.paciente.dataNascimento}'/>" >
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label for="sexo">Sexo:</label>
                                            <select id="sexo" name="sexo" class="custom-select" value="">
                                                <option <c:if test="${item.paciente.sexo == 'M'}">selected</c:if> value='M'>Masculino</option>
                                                <option <c:if test="${item.paciente.sexo == 'F'}">selected</c:if> value="F">Feminino</option>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="tel1">Telefone 1:</label>
                                                <input type="text" id="tel1" class="telresidencial required form-control" name="tel1" placeholder="" value="${item.telefone}">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="tel2">Telefone 2:</label>
                                            <input type="text" id="tel2" class="telresidencial form-control" name="tel2" placeholder="" value="${item.telefone2}">
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="email">E-mail:</label>
                                            <input type="email" id="email" name="email" class="required form-control" value="${item.login.email}">
                                        </div>
                                        <legend><hr>Endereço</legend>
                                        <div class="form-group col-md-4">
                                            <label for="cep">CEP: <a href="http://www.buscacep.correios.com.br/sistemas/buscacep/" target="_blank"><i class="fa fa-fw fa-question-circle-o"></i></a></label>
                                            <input type="text" id="cep" name="cep" placeholder="" class="required form-control" value="${item.endereco.cep}">
                                        </div>
                                        <div class="form-group col-md-8">
                                            <label for="rua">Rua:</label>
                                            <input type="text" id="rua" name="rua" readonly="true" class="locked form-control" value="${item.endereco.rua}">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="numero">Número:</label>
                                            <input type="text" id="numero" name="numero"  class="required form-control" value="${item.endereco.numero}">
                                        </div>
                                        <div class="form-group col-md-3">
                                            <label for="compl">Complemento:</label>
                                            <input type="text" id="compl" name="compl" class="form-control" value="${item.endereco.complemento}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="bairro">Bairro:</label>
                                            <input type="text" id="bairro" name="bairro"  readonly="true" class="locked form-control" value="${item.endereco.bairro}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="cidade">Cidade:</label>
                                            <input type="text" id="cidade" name="cidade" readonly="true" class="locked form-control" value="${item.endereco.cidade.nome}" >
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="estado">Estado:</label>
                                            <input type="text" id="estado" name="estado" readonly="true" class="locked form-control" value="${item.endereco.cidade.estado.uf}">
                                        </div>
                                        <legend><hr>Plano(s) de Saúde</legend>
                                            <jsp:useBean id="conveniosM" class="beans.Convenio"/>
                                            <c:if test="${conveniosPaciente.size() > 0}">
                                                <c:forEach var = "i" begin = "0" end = "${conveniosPaciente.size()-1}">
                                                <div id="especDiv2" class="form-group col-md-4">
                                                    <label for="convenio">Convênio: </label>
                                                    <select id="convenios${i+1}" name="idconvenio${i+1}" class="custom-select">
                                                        <option value="0">Escolha...</option>
                                                        <option value="<c:out value="${conveniosPaciente.get(i).convenio.id}"/>" selected><c:out value="${conveniosPaciente.get(i).convenio.nome}"/></option>
                                                        <c:forEach var="item" items="${convenios}">
                                                            <c:if test="${conveniosPaciente.get(i).id != item.id}">
                                                                <option value="<c:out value="${item.id}"/>"><c:out value="${item.nome}"/></option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="convenio">Número: </label>
                                                    <input type="text" id="convenio" name="nconvenio${i+1}" class=" form-control" value="${conveniosPaciente.get(i).numero}"/>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="convenio">Validade: </label>
                                                    <input type="text" id="convenio" name="vconvenio${i+1}" class="data form-control" value="<fmt:formatDate type='both' pattern='dd/MM/yyyy' value='${conveniosPaciente.get(i).validade}'/>"/>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                        <c:forEach var = "i" begin = "${conveniosPaciente.size()}" end = "1">
                                            <div id="especDiv2" class="form-group col-md-4">
                                                <label for="convenio">Convênio: </label>
                                                <select id="convenios${i+1}" name="idconvenio${i+1}" class="custom-select vazio">
                                                    <option value="0">Escolha...</option>
                                                    <c:forEach var="item" items="${convenios}">
                                                        <option value="<c:out value="${item.id}"/>"><c:out value="${item.nome}"/></option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="convenio">Número: </label>
                                                <input type="text" id="convenio" name="nconvenio${i+1}" class=" form-control" value="${item.endereco.cep}">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="convenio">Validade: </label>
                                                <input type="text" id="convenio" name="vconvenio${i+1}" class="data form-control" value="${item.endereco.cep}">
                                            </div>
                                        </c:forEach>
                                        <div class="form-group col-md-12 text-right">
                                            <input type="submit" id="VerificaDados"  value="Salvar Alterações" class="btn btn-lg btn-digital-green ">
                                        </div>

                                    </div>
                                </fieldset>
                            </form>
                            <hr class="dashed-divider">

                            <h3>Avançado</h3>
                            <c:choose>
                                <c:when test="${(param.status == 'error-senha')}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Opa! </strong> A senha atual digitada está incorreta!
                                    </div>
                                </c:when>

                                <c:when test="${(param.status == 'alterar-senha-ok')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Nova Senha Editada com Sucesso!</strong> 
                                    </div>
                                </c:when>
                                
                                <c:when test="${(param.status == 'error-criptografa')}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <strong>Ocorreu algum erro ao criptografar a senha!</strong> 
                                    </div>
                                </c:when>
                            </c:choose>
                            
                            <div id="accordion" role="tablist">
                                <div class="card " style="margin: 20px 0px 50px">
                                    <div class="card-header" role="tab" id="headingOne">
                                        <h5 class="mb-0">
                                            <a class="link-digital-green" data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                Alterar Senha
                                            </a>
                                        </h5>
                                    </div>
                                    <div id="collapseOne" class="collapse <c:if test="${(param.status == 'ok')}">show</c:if>" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
                                            <div class="card-body">
                                                <form action="${pageContext.request.contextPath}/PacienteServlet?action=alteraSenha" method="POST">
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
            </c:otherwise>
        </c:choose>
    </body>

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
                    confirmButtonClass: 'btn btn-success',
                    cancelButtonClass: 'btn btn-danger',
                    buttonsStyling: false
                }).then(function () {
                    window.location.href = "PacienteServlet?action=deletaUsuario";
                }, function (dismiss) {
                    if (dismiss === 'cancel') {
                        swal(
                                'Operação cancelada',
                                'Sua conta não foi apagada :)',
                                'error'
                                )
                    }
                })

            })

        });

    </script>
</html>

