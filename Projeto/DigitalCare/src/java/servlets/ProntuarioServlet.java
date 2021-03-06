/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Consulta;
import beans.Prontuario;
import conexao.ConnectionFactory;
import dtos.ExameDTO;
import dtos.ReceitaDTO;
import facade.Facade;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.sql.Blob;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

/**
 *
 * @author joao.wind
 */
@WebServlet(name = "ProntuarioServlet", urlPatterns = {"/ProntuarioServlet"})
public class ProntuarioServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String status = "";

        if (null != action) {
            switch (action) {
                case "atestado":
                    //1. Emitir PDF
                    //2. Salvar PDF no BD
                    //3. Retornar STATUS na jsp

                    try {
                        Connection con = new ConnectionFactory().getConnection();

                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");

                        String jasper = request.getContextPath() + "/jasper/atestado.jasper";
                        String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                        URL jasperURL = new URL(host + jasper);
                        HashMap params = new HashMap();

                        params.put("ATESTADO", request.getParameter("texto"));
                        params.put("CLINICA_NOME", consultaAtual.getClinicaEndereco().getClinica().getNomeFantasia());
                        params.put("PACIENTE_NOME", consultaAtual.getPacienteUsuario().getPaciente().getNome() + " " + consultaAtual.getPacienteUsuario().getPaciente().getSobrenome());
                        params.put("PACIENTE_END", consultaAtual.getPacienteUsuario().getEndereco().getRua() + ", " + consultaAtual.getPacienteUsuario().getEndereco().getNumero() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getBairro() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getCidade().getNome());
                        params.put("CLINICA_NOME_ENDERECO", consultaAtual.getClinicaEndereco().getNome());
                        params.put("CLINICA_ENDERECO", consultaAtual.getClinicaEndereco().getEndereco().getRua() + ", " + consultaAtual.getClinicaEndereco().getEndereco().getNumero() + " " + consultaAtual.getClinicaEndereco().getEndereco().getComplemento() + " - " + consultaAtual.getClinicaEndereco().getEndereco().getBairro());
                        params.put("CLINICA_TELEFONE", "(" + consultaAtual.getClinicaEndereco().getTelefone1().substring(0, 2) + ")" + consultaAtual.getClinicaEndereco().getTelefone1().substring(2, 6) + "-" + consultaAtual.getClinicaEndereco().getTelefone1().substring(6, 10)); //
                        params.put("CLINICA_CNPJ", consultaAtual.getClinicaEndereco().getClinica().getCnpj());
                        ServletContext context = getServletContext();
                        File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                        InputStream fi = new FileInputStream(digital_logo);
                        params.put("DIGITAL_LOGO", fi);

                        byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                        if (bytes != null) {
                            //Coloca arquivo PDF no Banco de Dados
                            Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
                            Prontuario prontuario = new Prontuario();
                            prontuario.setAtestado(blob);
                            prontuario.setConsulta(consultaAtual);
                            Facade.inserirAtestado(prontuario);
                            response.setCharacterEncoding("UTF-8");
                            response.setStatus(HttpServletResponse.SC_OK);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "atestadoPDF":
                    //1. Emitir PDF
                    //2. Retornar PDF na jsp

                    try {
                        Connection con = new ConnectionFactory().getConnection();

                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");

                        String jasper = request.getContextPath() + "/jasper/atestado.jasper";
                        String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                        URL jasperURL = new URL(host + jasper);
                        HashMap params = new HashMap();

                        params.put("ATESTADO", request.getParameter("texto"));
                        params.put("CLINICA_NOME", consultaAtual.getClinicaEndereco().getClinica().getNomeFantasia());
                        params.put("PACIENTE_NOME", consultaAtual.getPacienteUsuario().getPaciente().getNome() + " " + consultaAtual.getPacienteUsuario().getPaciente().getSobrenome());
                        params.put("PACIENTE_END", consultaAtual.getPacienteUsuario().getEndereco().getRua() + ", " + consultaAtual.getPacienteUsuario().getEndereco().getNumero() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getBairro() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getCidade().getNome());
                        params.put("CLINICA_NOME_ENDERECO", consultaAtual.getClinicaEndereco().getNome());
                        params.put("CLINICA_ENDERECO", consultaAtual.getClinicaEndereco().getEndereco().getRua() + ", " + consultaAtual.getClinicaEndereco().getEndereco().getNumero() + " " + consultaAtual.getClinicaEndereco().getEndereco().getComplemento() + " - " + consultaAtual.getClinicaEndereco().getEndereco().getBairro());
                        params.put("CLINICA_TELEFONE", "(" + consultaAtual.getClinicaEndereco().getTelefone1().substring(0, 2) + ")" + consultaAtual.getClinicaEndereco().getTelefone1().substring(2, 6) + "-" + consultaAtual.getClinicaEndereco().getTelefone1().substring(6, 10)); //
                        params.put("CLINICA_CNPJ", consultaAtual.getClinicaEndereco().getClinica().getCnpj());
                        ServletContext context = getServletContext();
                        File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                        InputStream fi = new FileInputStream(digital_logo);
                        params.put("DIGITAL_LOGO", fi);

                        byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                        if (bytes != null) {
                            response.setContentType("application/pdf");
                            OutputStream ops = response.getOutputStream();
                            ops.write(bytes);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "receitaPDF":
                    //1. Emitir PDF
                    //2. Retornar PDF na jsp

                    try {
                        String[] doses = request.getParameter("nomeDose").split(";");
                        String[] vias = request.getParameter("nomeVia").split(";");
                        String[] quantidades = request.getParameter("nomeQuantidade").split(";");
                        String[] medicamentos = request.getParameter("nomeMedicacao").split(";");
                        List<ReceitaDTO> receitaMedicamentos = new ArrayList<>();
                        if (quantidades != null) {
                            for (int i = 0; i < medicamentos.length; i++) {
                                ReceitaDTO receita = new ReceitaDTO();
                                try {
                                    receita.setDose(doses[i]);
                                } catch (Exception ex) {
                                    receita.setDose("");
                                }
                                try {
                                    receita.setVia(vias[i]);
                                } catch (Exception ex) {
                                    receita.setVia("");
                                }
                                try {
                                    receita.setQuantidade(quantidades[i]);
                                } catch (Exception ex) {
                                    receita.setQuantidade("");
                                }
                                receita.setMedicamento(medicamentos[i]);
                                receitaMedicamentos.add(receita);
                            }
                        } else {
                            throw new Exception("A lista de medicamentos não pode estar vazia.");
                        }

                        Connection con = new ConnectionFactory().getConnection();
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");

                        String jasper = request.getContextPath() + "/jasper/receituario.jasper";
                        String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                        URL jasperURL = new URL(host + jasper);
                        HashMap params = new HashMap();
                        JRBeanCollectionDataSource receitaJRBean = new JRBeanCollectionDataSource(receitaMedicamentos);
                        params.put("RECEITA", receitaJRBean);
                        params.put("CLINICA_NOME", consultaAtual.getClinicaEndereco().getClinica().getNomeFantasia());
                        params.put("PACIENTE_NOME", consultaAtual.getPacienteUsuario().getPaciente().getNome() + " " + consultaAtual.getPacienteUsuario().getPaciente().getSobrenome());
                        params.put("PACIENTE_END", consultaAtual.getPacienteUsuario().getEndereco().getRua() + ", " + consultaAtual.getPacienteUsuario().getEndereco().getNumero() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getBairro() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getCidade().getNome());
                        params.put("CLINICA_NOME_ENDERECO", consultaAtual.getClinicaEndereco().getNome());
                        params.put("CLINICA_ENDERECO", consultaAtual.getClinicaEndereco().getEndereco().getRua() + ", " + consultaAtual.getClinicaEndereco().getEndereco().getNumero() + " " + consultaAtual.getClinicaEndereco().getEndereco().getComplemento() + " - " + consultaAtual.getClinicaEndereco().getEndereco().getBairro());
                        params.put("CLINICA_TELEFONE", "(" + consultaAtual.getClinicaEndereco().getTelefone1().substring(0, 2) + ")" + consultaAtual.getClinicaEndereco().getTelefone1().substring(2, 6) + "-" + consultaAtual.getClinicaEndereco().getTelefone1().substring(6, 10)); //
                        params.put("CLINICA_CNPJ", consultaAtual.getClinicaEndereco().getClinica().getCnpj());
                        ServletContext context = getServletContext();
                        File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                        InputStream fi = new FileInputStream(digital_logo);
                        params.put("DIGITAL_LOGO", fi);

                        byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                        if (bytes != null) {
                            response.setContentType("application/pdf");
                            OutputStream ops = response.getOutputStream();
                            ops.write(bytes);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "receita":
                    //1. Emitir PDF
                    //2. Salvar PDF no BD
                    //3. Retornar STATUS na jsp

                    try {
                        String[] doses = request.getParameterValues("dose[]");
                        String[] vias = request.getParameterValues("via[]");
                        String[] quantidades = request.getParameterValues("quantidade[]");
                        String[] medicamentos = request.getParameterValues("nomeMedicacao[]");
                        List<ReceitaDTO> receitaMedicamentos = new ArrayList<>();
                        if (quantidades != null) {
                            for (int i = 0; i < medicamentos.length; i++) {
                                receitaMedicamentos.add(new ReceitaDTO(doses[i], vias[i], quantidades[i], medicamentos[i]));
                            }
                        } else {
                            throw new Exception("A lista de medicamentos não pode estar vazia.");
                        }

                        Connection con = new ConnectionFactory().getConnection();
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");

                        String jasper = request.getContextPath() + "/jasper/receituario.jasper";
                        String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                        URL jasperURL = new URL(host + jasper);
                        HashMap params = new HashMap();
                        JRBeanCollectionDataSource receitaJRBean = new JRBeanCollectionDataSource(receitaMedicamentos);
                        params.put("RECEITA", receitaJRBean);
                        params.put("CLINICA_NOME", consultaAtual.getClinicaEndereco().getClinica().getNomeFantasia());
                        params.put("PACIENTE_NOME", consultaAtual.getPacienteUsuario().getPaciente().getNome() + " " + consultaAtual.getPacienteUsuario().getPaciente().getSobrenome());
                        params.put("PACIENTE_END", consultaAtual.getPacienteUsuario().getEndereco().getRua() + ", " + consultaAtual.getPacienteUsuario().getEndereco().getNumero() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getBairro() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getCidade().getNome());
                        params.put("CLINICA_NOME_ENDERECO", consultaAtual.getClinicaEndereco().getNome());
                        params.put("CLINICA_ENDERECO", consultaAtual.getClinicaEndereco().getEndereco().getRua() + ", " + consultaAtual.getClinicaEndereco().getEndereco().getNumero() + " " + consultaAtual.getClinicaEndereco().getEndereco().getComplemento() + " - " + consultaAtual.getClinicaEndereco().getEndereco().getBairro());
                        params.put("CLINICA_TELEFONE", "(" + consultaAtual.getClinicaEndereco().getTelefone1().substring(0, 2) + ")" + consultaAtual.getClinicaEndereco().getTelefone1().substring(2, 6) + "-" + consultaAtual.getClinicaEndereco().getTelefone1().substring(6, 10)); //
                        params.put("CLINICA_CNPJ", consultaAtual.getClinicaEndereco().getClinica().getCnpj());
                        ServletContext context = getServletContext();
                        File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                        InputStream fi = new FileInputStream(digital_logo);
                        params.put("DIGITAL_LOGO", fi);

                        byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                        if (bytes != null) {
                            //Coloca arquivo PDF no Banco de Dados
                            Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
                            Prontuario prontuario = new Prontuario();
                            prontuario.setReceita(blob);
                            prontuario.setConsulta(consultaAtual);
                            Facade.inserirReceita(prontuario);
                            response.setCharacterEncoding("UTF-8");
                            response.setStatus(HttpServletResponse.SC_OK);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "examePDF":
                    //1. Emitir PDF
                    //2. Retornar PDF na jsp

                    try {
                        String[] exames = request.getParameter("nomeExames").split(",");
                        List<ExameDTO> listaExames = new ArrayList<>();
                        if (exames != null) {
                            for (String exame : exames) {
                                listaExames.add(new ExameDTO(exame));
                            }
                        } else {
                            throw new Exception("A lista de exames não pode estar vazia.");
                        }
                        Connection con = new ConnectionFactory().getConnection();
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");

                        String jasper = request.getContextPath() + "/jasper/exame.jasper";
                        String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                        URL jasperURL = new URL(host + jasper);
                        HashMap params = new HashMap();
                        JRBeanCollectionDataSource receitaJRBean = new JRBeanCollectionDataSource(listaExames);
                        params.put("EXAME", receitaJRBean);
                        params.put("CLINICA_NOME", consultaAtual.getClinicaEndereco().getClinica().getNomeFantasia());
                        params.put("PACIENTE_NOME", consultaAtual.getPacienteUsuario().getPaciente().getNome() + " " + consultaAtual.getPacienteUsuario().getPaciente().getSobrenome());
                        params.put("PACIENTE_END", consultaAtual.getPacienteUsuario().getEndereco().getRua() + ", " + consultaAtual.getPacienteUsuario().getEndereco().getNumero() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getBairro() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getCidade().getNome());
                        params.put("CLINICA_NOME_ENDERECO", consultaAtual.getClinicaEndereco().getNome());
                        params.put("CLINICA_ENDERECO", consultaAtual.getClinicaEndereco().getEndereco().getRua() + ", " + consultaAtual.getClinicaEndereco().getEndereco().getNumero() + " " + consultaAtual.getClinicaEndereco().getEndereco().getComplemento() + " - " + consultaAtual.getClinicaEndereco().getEndereco().getBairro());
                        params.put("CLINICA_TELEFONE", "(" + consultaAtual.getClinicaEndereco().getTelefone1().substring(0, 2) + ")" + consultaAtual.getClinicaEndereco().getTelefone1().substring(2, 6) + "-" + consultaAtual.getClinicaEndereco().getTelefone1().substring(6, 10)); //
                        params.put("CLINICA_CNPJ", consultaAtual.getClinicaEndereco().getClinica().getCnpj());
                        ServletContext context = getServletContext();
                        File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                        InputStream fi = new FileInputStream(digital_logo);
                        params.put("DIGITAL_LOGO", fi);

                        byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                        if (bytes != null) {
                            response.setContentType("application/pdf");
                            OutputStream ops = response.getOutputStream();
                            ops.write(bytes);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "exame":
                    //1. Emitir PDF
                    //2. Salvar PDF no BD
                    //3. Retornar STATUS na jsp

                    try {
                        String[] exames = request.getParameterValues("exames[]");
                        List<ExameDTO> listaExames = new ArrayList<>();
                        if (exames != null) {
                            for (String exame : exames) {
                                listaExames.add(new ExameDTO(exame));
                            }
                        } else {
                            throw new Exception("A lista de exames não pode estar vazia.");
                        }

                        Connection con = new ConnectionFactory().getConnection();
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");

                        String jasper = request.getContextPath() + "/jasper/exame.jasper";
                        String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                        URL jasperURL = new URL(host + jasper);
                        HashMap params = new HashMap();
                        JRBeanCollectionDataSource receitaJRBean = new JRBeanCollectionDataSource(listaExames);
                        params.put("EXAME", receitaJRBean);
                        params.put("CLINICA_NOME", consultaAtual.getClinicaEndereco().getClinica().getNomeFantasia());
                        params.put("PACIENTE_NOME", consultaAtual.getPacienteUsuario().getPaciente().getNome() + " " + consultaAtual.getPacienteUsuario().getPaciente().getSobrenome());
                        params.put("PACIENTE_END", consultaAtual.getPacienteUsuario().getEndereco().getRua() + ", " + consultaAtual.getPacienteUsuario().getEndereco().getNumero() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getBairro() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getCidade().getNome());
                        params.put("CLINICA_NOME_ENDERECO", consultaAtual.getClinicaEndereco().getNome());
                        params.put("CLINICA_ENDERECO", consultaAtual.getClinicaEndereco().getEndereco().getRua() + ", " + consultaAtual.getClinicaEndereco().getEndereco().getNumero() + " " + consultaAtual.getClinicaEndereco().getEndereco().getComplemento() + " - " + consultaAtual.getClinicaEndereco().getEndereco().getBairro());
                        params.put("CLINICA_TELEFONE", "(" + consultaAtual.getClinicaEndereco().getTelefone1().substring(0, 2) + ")" + consultaAtual.getClinicaEndereco().getTelefone1().substring(2, 6) + "-" + consultaAtual.getClinicaEndereco().getTelefone1().substring(6, 10)); //
                        params.put("CLINICA_CNPJ", consultaAtual.getClinicaEndereco().getClinica().getCnpj());
                        ServletContext context = getServletContext();
                        File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                        InputStream fi = new FileInputStream(digital_logo);
                        params.put("DIGITAL_LOGO", fi);

                        byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                        if (bytes != null) {
                            //Coloca arquivo PDF no Banco de Dados
                            Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
                            Prontuario prontuario = new Prontuario();
                            prontuario.setExame(blob);
                            prontuario.setConsulta(consultaAtual);
                            Facade.inserirExame(prontuario);
                            response.setCharacterEncoding("UTF-8");
                            response.setStatus(HttpServletResponse.SC_OK);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "prontuario":
                    //1. Emitir PDF
                    //2. Salvar PDF no BD

                    try {
                        String prontuarioHTML = request.getParameter("prontuario");

                        Connection con = new ConnectionFactory().getConnection();
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");

                        String jasper = request.getContextPath() + "/jasper/prontuario.jasper";
                        String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                        URL jasperURL = new URL(host + jasper);
                        HashMap params = new HashMap();
                        params.put("PRONTUARIO", prontuarioHTML);
                        params.put("CLINICA_NOME", consultaAtual.getClinicaEndereco().getClinica().getNomeFantasia());
                        params.put("PACIENTE_NOME", consultaAtual.getPacienteUsuario().getPaciente().getNome() + " " + consultaAtual.getPacienteUsuario().getPaciente().getSobrenome());
                        params.put("PACIENTE_END", consultaAtual.getPacienteUsuario().getEndereco().getRua() + ", " + consultaAtual.getPacienteUsuario().getEndereco().getNumero() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getBairro() + " - " + consultaAtual.getPacienteUsuario().getEndereco().getCidade().getNome());
                        params.put("CLINICA_NOME_ENDERECO", consultaAtual.getClinicaEndereco().getNome());
                        params.put("CLINICA_ENDERECO", consultaAtual.getClinicaEndereco().getEndereco().getRua() + ", " + consultaAtual.getClinicaEndereco().getEndereco().getNumero() + " " + consultaAtual.getClinicaEndereco().getEndereco().getComplemento() + " - " + consultaAtual.getClinicaEndereco().getEndereco().getBairro());
                        params.put("CLINICA_TELEFONE", "(" + consultaAtual.getClinicaEndereco().getTelefone1().substring(0, 2) + ")" + consultaAtual.getClinicaEndereco().getTelefone1().substring(2, 6) + "-" + consultaAtual.getClinicaEndereco().getTelefone1().substring(6, 10)); //
                        params.put("CLINICA_CNPJ", consultaAtual.getClinicaEndereco().getClinica().getCnpj());
                        ServletContext context = getServletContext();
                        File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                        InputStream fi = new FileInputStream(digital_logo);
                        params.put("DIGITAL_LOGO", fi);

                        byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                        if (bytes != null) {
                            //Coloca arquivo PDF no Banco de Dados
                            Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
                            Prontuario prontuario = new Prontuario();
                            prontuario.setDescricao(blob);
                            prontuario.setConsulta(consultaAtual);
                            Facade.inserirDescricao(prontuario);
                            response.setCharacterEncoding("UTF-8");
                            response.setStatus(HttpServletResponse.SC_OK);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "prontuarioHistorico":
                    //1. Pegar PDF no BD
                    //2. Imprimir na tela
                    try {
                        int valorID = Integer.parseInt(request.getParameter("valorHistorico"));
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");
                        Prontuario prontuario = null;
                        for (Prontuario pront : consultaAtual.getPacienteUsuario().getProntuarios()) {
                            if (pront.getId() == valorID) {
                                prontuario = pront;
                            }
                        }
                        int blobLength = (int) prontuario.getDescricao().length();
                        byte[] bytes = prontuario.getDescricao().getBytes(1, blobLength);
                        if (bytes != null) {
                            response.setContentType("application/pdf");
                            OutputStream ops = response.getOutputStream();
                            ops.write(bytes);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "receitaHistorico":
                    //1. Pegar PDF no BD
                    //2. Imprimir na tela
                    try {
                        int valorID = Integer.parseInt(request.getParameter("valorHistorico"));
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");
                        Prontuario prontuario = null;
                        for (Prontuario pront : consultaAtual.getPacienteUsuario().getProntuarios()) {
                            if (pront.getId() == valorID) {
                                prontuario = pront;
                            }
                        }
                        int blobLength = (int) prontuario.getReceita().length();
                        byte[] bytes = prontuario.getReceita().getBytes(1, blobLength);
                        if (bytes != null) {
                            response.setContentType("application/pdf");
                            OutputStream ops = response.getOutputStream();
                            ops.write(bytes);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "atestadoHistorico":
                    //1. Pegar PDF no BD
                    //2. Imprimir na tela
                    try {
                        int valorID = Integer.parseInt(request.getParameter("valorHistorico"));
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");
                        Prontuario prontuario = null;
                        for (Prontuario pront : consultaAtual.getPacienteUsuario().getProntuarios()) {
                            if (pront.getId() == valorID) {
                                prontuario = pront;
                            }
                        }
                        int blobLength = (int) prontuario.getAtestado().length();
                        byte[] bytes = prontuario.getAtestado().getBytes(1, blobLength);
                        if (bytes != null) {
                            response.setContentType("application/pdf");
                            OutputStream ops = response.getOutputStream();
                            ops.write(bytes);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                case "exameHistorico":
                    //1. Pegar PDF no BD
                    //2. Imprimir na tela
                    try {
                        int valorID = Integer.parseInt(request.getParameter("valorHistorico"));
                        HttpSession session = request.getSession();
                        Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");
                        Prontuario prontuario = null;
                        for (Prontuario pront : consultaAtual.getPacienteUsuario().getProntuarios()) {
                            if (pront.getId() == valorID) {
                                prontuario = pront;
                            }
                        }
                        int blobLength = (int) prontuario.getExame().length();
                        byte[] bytes = prontuario.getExame().getBytes(1, blobLength);
                        if (bytes != null) {
                            response.setContentType("application/pdf");
                            OutputStream ops = response.getOutputStream();
                            ops.write(bytes);
                        }
                    } catch (Exception ex) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write(ex.getMessage());
                    }
                    break;
                default:
                    break;
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
