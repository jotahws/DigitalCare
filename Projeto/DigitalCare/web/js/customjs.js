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
    $('.money').maskMoney({thousands: '', decimal: '.', allowZero: true});
    $('.hora').mask('99:99');
//------------------indisponibilidade---------------------
    $('#de').mask('99:99');
    $('#ate').mask('99:99');
    $('#dia-inteiro').change(function () {
        if ($(this).is(':checked')) {
            $('#de').attr('readonly', true);
            $('#ate').attr('readonly', true);
            $('#de').val("00:00");
            $('#ate').val("23:59");
            $('#de').removeAttr('placeholder');
            $('#ate').removeAttr('placeholder');
        } else {
            $('#de').attr('readonly', false);
            $('#ate').attr('readonly', false);
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

//--------------------------Validar se input é numero----------------------------

    $('input[type="submit"]').click(function (e) {
        $('.numero').each(function (i, obj) {
            if ($(this).val() != '' && isNaN($(this).val())) {
                $(this).css({
                    "border": "1px solid red",
                    "background": "#FFCECE"
                });
                $(this).after('<span class="clear" style="font-size:0.8em;"> Este campo deve conter apenas numeros </span>');
                e.preventDefault();
            }
        });
    });

//--------------------------RESPONSIVIDADE----------------------------
    if ($(window).width() < 1200) {
        $('.agendamento .data-box').addClass('col-md-6');
        $('.agendamento .data-box').removeClass('col-md-5');
    }

});