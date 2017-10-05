/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {

//----------------------mascaras---------------------------
    $('.data').mask('99/99/9999');
    $('.telefone').mask('(99)99999-9999');
    $('.telresidencial').mask('(99)9999-9999');
    $('#cep').mask('99.999-999');
    $('.cep').mask('99.999-999');
    $('#cpf').mask('999.999.999-99');
    $('.cnpj').mask('99.999.999/9999-99');
//------------------indisponibilidade---------------------
    $('#de').mask('99:99');
    $('#ate').mask('99:99');
    $('#dia-inteiro').change(function () {
        if ($(this).is(':checked')) {
            $('#de').attr('disabled', true);
            $('#ate').attr('disabled', true);
            $('#de').val("00:00");
            $('#ate').val("23:59");
            $('#de').removeAttr('placeholder');
            $('#ate').removeAttr('placeholder');
        } else {
            $('#de').attr('disabled', false);
            $('#ate').attr('disabled', false);
            $('#de').val(null);
            $('#ate').val(null);
            $('#de').attr('placeholder', 'Ex. 13:00');
            $('#ate').attr('placeholder', 'Ex. 16:00');
        }
    });
//---------------------------CEP-------------------------
    function limpa_formulario_cep() {
        // Limpa valores do formulário de cep.
        $("#rua").val("");
        $("#bairro").val("");
        $("#cidade").val("");
        $("#estado").val("");
    }
//Quando o campo cep perde o foco.
    $("#cep").blur(function () {
//Nova variável "cep" somente com dígitos.
        var cep = $(this).val().replace(/\D/g, '');
        //Verifica se campo cep possui valor informado.
        if (cep != "") {
//Expressão regular para validar o CEP.
            var validacep = /^[0-9]{8}$/;
            //Valida o formato do CEP.
            if (validacep.test(cep)) {
//Preenche os campos com "..." enquanto consulta webservice.
                $("#rua").val("Carregando...");
                $("#bairro").val("Carregando...");
                $("#cidade").val("Carregando...");
                $("#estado").val("Carregando...");
                //Consulta o webservice viacep.com.br/
                $.getJSON("//viacep.com.br/ws/" + cep + "/json/?callback=?", function (dados) {
                    if (!("erro" in dados)) {
                        //Atualiza os campos com os valores da consulta.
                        $("#rua").val(dados.logradouro);
                        $("#bairro").val(dados.bairro);
                        $("#cidade").val(dados.localidade);
                        $("#estado").val(dados.uf);
                    } //end if.
                    else {
                        //CEP pesquisado não foi encontrado.
                        limpa_formulario_cep();
                    }
                });
            } //end if.
            else {
//cep é inválido.
                limpa_formulario_cep();
            }
        } //end if.
        else {
//cep sem valor, limpa formulário.
            limpa_formulario_cep();
        }
    });
//---------------------Verifica os campos obrigatórios-----------------
    if (($('input[type="submit"]').attr('id') !== 'VerificaSenha') && ($('input[type="submit"]').attr('id') !== 'VerificaDados')) {
        $('input[type="submit"]').click(function (e) {
            var isValid = true;
            $('span.clear').remove();
            $('.required').each(function () {
                if ($.trim($(this).val()) === '') {
                    isValid = false;
                    $(this).css({
                        "border": "1px solid red",
                        "background": "#FFCECE"
                    });
                    $(this).after('<span class="clear" style="font-size:0.8em;">Campo Obrigatorio</span>');
                } else {
                    $(this).css({
                        "border": "",
                        "background": ""
                    });
                }
            });
            if ($('#pssw').val() !== $('#pssw2').val()) {
                isValid = false;
                $('#pssw2').css({
                    "border": "1px solid red",
                    "background": "#FFCECE"
                });
                $("#pssw2").after('<span class="clear" style="font-size:0.8em;">Os campos devem ser iguais</span>');
            }
            if (isValid === false)
                e.preventDefault();
        });
    } else {
        $('#VerificaDados').click(function (e) {
            var isValid = true;
            $('span.clear').remove();
            $('input[type="text"].required').each(function () {
                if ($.trim($(this).val()) === '') {
                    isValid = false;
                    $(this).css({
                        "border": "1px solid red",
                        "background": "#FFCECE"
                    });
                    $(this).after('<span class="clear" style="font-size:0.8em;">Campo Obrigatorio</span>');
                } else {
                    $(this).css({
                        "border": "",
                        "background": ""
                    });
                }
            });
            $('input[type="email"].required').each(function () {
                if ($.trim($(this).val()) === '') {
                    isValid = false;
                    $(this).css({
                        "border": "1px solid red",
                        "background": "#FFCECE"
                    });
                    $(this).after('<span class="clear" style="font-size:0.8em;">Campo Obrigatorio</span>');
                } else {
                    $(this).css({
                        "border": "",
                        "background": ""
                    });
                }
            });
            if (isValid === false)
                e.preventDefault();
        });
        $('#VerificaSenha').click(function (e) {
            var isValid = true;
            $('span.clear').remove();
            $('input[type="password"].required').each(function () {
                if ($.trim($(this).val()) === '') {
                    isValid = false;
                    $(this).css({
                        "border": "1px solid red",
                        "background": "#FFCECE"
                    });
                    $(this).after('<span class="clear" style="font-size:0.8em;">Campo Obrigatorio</span>');
                } else {
                    $(this).css({
                        "border": "",
                        "background": ""
                    });
                }
            });
            if ($('#pssw').val() !== $('#pssw2').val()) {
                isValid = false;
                $('#pssw2').css({
                    "border": "1px solid red",
                    "background": "#FFCECE"
                });
                $("#pssw2").after('<span class="clear" style="font-size:0.8em;">Os campos devem ser iguais</span>');
            }
            if (isValid === false)
                e.preventDefault();
        });
    }

//--------------------------Validar CNPJ----------------------------

    function validarCNPJ(cnpj) {

        cnpj = cnpj.replace(/[^\d]+/g, '');

        if (cnpj === '')
            return false;

        if (cnpj.length !== 14)
            return false;

        // Elimina CNPJs invalidos conhecidos
        if (cnpj === "00000000000000" ||
                cnpj === "11111111111111" ||
                cnpj === "22222222222222" ||
                cnpj === "33333333333333" ||
                cnpj === "44444444444444" ||
                cnpj === "55555555555555" ||
                cnpj === "66666666666666" ||
                cnpj === "77777777777777" ||
                cnpj === "88888888888888" ||
                cnpj === "99999999999999")
            return false;

        // Valida DVs
        tamanho = cnpj.length - 2
        numeros = cnpj.substring(0, tamanho);
        digitos = cnpj.substring(tamanho);
        soma = 0;
        pos = tamanho - 7;
        for (i = tamanho; i >= 1; i--) {
            soma += numeros.charAt(tamanho - i) * pos--;
            if (pos < 2)
                pos = 9;
        }
        resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
        if (resultado !== digitos.charAt(0))
            return false;

        tamanho = tamanho + 1;
        numeros = cnpj.substring(0, tamanho);
        soma = 0;
        pos = tamanho - 7;
        for (i = tamanho; i >= 1; i--) {
            soma += numeros.charAt(tamanho - i) * pos--;
            if (pos < 2)
                pos = 9;
        }
        resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
        if (resultado !== digitos.charAt(1))
            return false;

        return true;

    }

//--------------------------Validar CPF----------------------------
    function TestaCPF(strCPF) {
        var Soma;
        var Resto;
        Soma = 0;
        if (strCPF === "00000000000")
            return false;

        for (i = 1; i <= 9; i++)
            Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (11 - i);
        Resto = (Soma * 10) % 11;

        if ((Resto === 10) || (Resto === 11))
            Resto = 0;
        if (Resto !== parseInt(strCPF.substring(9, 10)))
            return false;

        Soma = 0;
        for (i = 1; i <= 10; i++)
            Soma = Soma + parseInt(strCPF.substring(i - 1, i)) * (12 - i);
        Resto = (Soma * 10) % 11;

        if ((Resto === 10) || (Resto === 11))
            Resto = 0;
        if (Resto !== parseInt(strCPF.substring(10, 11)))
            return false;
        return true;
    }

//--------------------------RESPONSIVIDADE----------------------------
    if ($(window).width() < 1200) {
        $('.agendamento .data-box').addClass('col-md-6');
        $('.agendamento .data-box').removeClass('col-md-5');
    }



});