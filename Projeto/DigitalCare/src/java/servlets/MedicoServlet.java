/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Clinica;
import beans.Convenio;
import beans.Especialidade;
import beans.Estado;
import beans.Login;
import beans.Medico;
import facade.Facade;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Gabriel
 */
@WebServlet(name = "MedicoServlet", urlPatterns = {"/MedicoServlet"})
public class MedicoServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String status = "";

        if ("register".equals(action)) {
            try {
                String nome = request.getParameter("nome");
                String sobrenome = request.getParameter("sobrenome");
                String email = request.getParameter("email");
                String cpf = request.getParameter("cpf");
                String numeroCrm = request.getParameter("numeroCrm");
                String dataNascimento = request.getParameter("dtnsc");
                String estadoCrm = request.getParameter("expedicao");
                String senha = request.getParameter("senha1");
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                Date dataNasc = formatter.parse(dataNascimento);
                cpf = cpf.replace("-", "");
                cpf = cpf.replace(".", "");

                Login login = new Login();
                senha = login.criptografa(senha);
                login = new Login(email, senha, 2);
                Estado estado = Facade.buscarEstadoPorId(Integer.parseInt(estadoCrm));
                Medico medico = new Medico(login, estado, numeroCrm, nome, sobrenome, cpf, dataNasc);
                Facade.inserirMedico(medico);

                status = "cadastro-ok";
            } catch (ClassNotFoundException | SQLException | ParseException ex) {
                status = "cadastro-erro";
            } catch (NoSuchAlgorithmException ex) {
                status = "error-criptografa";
            }
            response.sendRedirect("novo-medico.jsp?status=" + status);
        } else if ("edit".equals(action)) {
            try {
                String nome = request.getParameter("nome");
                String sobrenome = request.getParameter("sobrenome");
                String dataNascimento = request.getParameter("dtnsc");
                String precoConsulta = request.getParameter("precoConsulta");
                String telefone1 = request.getParameter("telefone1");
                String telefone2 = request.getParameter("telefone2");
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                Date dataNasc = formatter.parse(dataNascimento);
                telefone1 = telefone1.replace("(", "");
                telefone1 = telefone1.replace(")", "");
                telefone1 = telefone1.replace(" ", "");
                telefone1 = telefone1.replace("-", "");
                telefone2 = telefone2.replace("(", "");
                telefone2 = telefone2.replace(")", "");
                telefone2 = telefone2.replace(" ", "");
                telefone2 = telefone2.replace("-", "");
                HttpSession session = request.getSession();
                Medico medico = (Medico) session.getAttribute("usuario");
                medico.setNome(nome);
                medico.setSobrenome(sobrenome);
                medico.setDataNascimento(dataNasc);
                medico.setPrecoConsulta(Double.parseDouble(precoConsulta));
                medico.setTelefone1(telefone1);
                medico.setTelefone2(telefone2);
                Facade.atualizarMedico(medico);
                List<Integer> listaIdEspecialidade = new ArrayList();

                //Coletando os id's das especialidades selecionadas
                if (!"0".equals(request.getParameter("especialidade1"))) {
                    listaIdEspecialidade.add(Integer.parseInt(request.getParameter("especialidade1")));
                }
                if (!"0".equals(request.getParameter("especialidade2"))) {
                    listaIdEspecialidade.add(Integer.parseInt(request.getParameter("especialidade2")));
                }
                if (!"0".equals(request.getParameter("especialidade3"))) {
                    listaIdEspecialidade.add(Integer.parseInt(request.getParameter("especialidade3")));
                }
                if (!"0".equals(request.getParameter("especialidade4"))) {
                    listaIdEspecialidade.add(Integer.parseInt(request.getParameter("especialidade4")));
                }

                //Deletando todas as especialidades do médico
                Facade.deletarEspecialidadesMedico(medico.getId());

                List<Especialidade> listaEspecialidadesMedico = new ArrayList();

                //Inserindo as especialidades selecionadas
                for (int idEspecialidade : listaIdEspecialidade) {
                    listaEspecialidadesMedico.add(Facade.buscarEspecialidadePorId(idEspecialidade));
                    Facade.inserirEspecialidadeMedico(medico.getId(), idEspecialidade);
                }
                medico.setListaEspecialidades(listaEspecialidadesMedico);

                List<Integer> listaIdConvenios = new ArrayList();

                //Coletando os id's das especialidades selecionadas
                if (!("0".equals(request.getParameter("convenio1")))) {
                    listaIdConvenios.add(Integer.parseInt(request.getParameter("convenio1")));
                }
                if (!"0".equals(request.getParameter("convenio2"))) {
                    listaIdConvenios.add(Integer.parseInt(request.getParameter("convenio2")));
                }
                if (!"0".equals(request.getParameter("convenio3"))) {
                    listaIdConvenios.add(Integer.parseInt(request.getParameter("convenio3")));
                }
                if (!"0".equals(request.getParameter("convenio4"))) {
                    listaIdConvenios.add(Integer.parseInt(request.getParameter("convenio4")));
                }

                //Deletando todas as especialidades do médico
                Facade.deletarConveniosMedico(medico.getId());

                List<Convenio> listaConveniosMedico = new ArrayList();

                //Inserindo as especialidades selecionadas
                for (int idConvenio : listaIdConvenios) {
                    listaConveniosMedico.add(Facade.buscarConvenioPorId(idConvenio));
                    Facade.inserirConvenioMedico(medico.getId(), idConvenio);
                }
                medico.setListaConvenios(listaConveniosMedico);

                session.setAttribute("usuario", medico);
                status = "edit-ok";
            } catch (ClassNotFoundException | SQLException | ParseException ex) {
                status = "edit-erro";
            }
            response.sendRedirect("ListaMedicoServlet?action=listaConfigMedico&status=" + status);
        } else if ("alterSenha".equals(action)) {
            Facade facade = new Facade();
            HttpSession session = request.getSession();
            Medico medico = (Medico) session.getAttribute("usuario");
            String senha = request.getParameter("senha-antiga");
            String novaSenha = request.getParameter("nova-senha");
            try {
                Login login = new Login();
                senha = login.criptografa(senha);
                novaSenha = login.criptografa(novaSenha);
                if (facade.senhaVerificada(medico.getLogin().getId(), senha)) {
                    facade.editaSenha(medico.getLogin().getId(), novaSenha);
                    medico.getLogin().setSenha(novaSenha);
                    session.setAttribute("usuario", medico);
                    status = "alterSenha-ok";
                } else {
                    status = "alterSenha-error";
                }
            } catch (ClassNotFoundException | SQLException | NullPointerException ex) {
                status = "alterSenha-error";
            } catch (NoSuchAlgorithmException ex) {
                status = "error-criptografa";
            }
            response.sendRedirect("ListaMedicoServlet?action=listaConfigMedico&status=" + status + "#convenios1");

        } else if ("desvinculaMedico".equals(action)) {
            Facade facade = new Facade();
            int idMedico = Integer.parseInt(request.getParameter("idMedico"));
            int idClinica = Integer.parseInt(request.getParameter("idClinica"));
            HttpSession session = request.getSession();
            Clinica clinica = (Clinica) session.getAttribute("usuario");
            try {
                facade.desvinculaMedicoClinica(idMedico, idClinica);
                status = "desvincular-ok";
            } catch (ClassNotFoundException | SQLException ex) {
                status = "desvincular-error";
            }
            response.sendRedirect("ListaMedicoServlet?action=listaMedicos&status=" + status);
        } else if ("excluir".equals(action)){
            HttpSession session = request.getSession();
            Medico medico = (Medico) session.getAttribute("usuario");
            try {
                Facade.deletarLogin(medico.getLogin().getId());
                status = "excluir-ok";
                session = request.getSession(false);

                    if (session != null) {
                        session.invalidate();
                        response.sendRedirect("index.jsp?status=" + status);
                    }
            }  catch (ClassNotFoundException | SQLException ex) {
                status = "excluir-erro";
            }
            response.sendRedirect("index.jsp?status=" + status);
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
