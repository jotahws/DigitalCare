/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Cidade;
import beans.Clinica;
import beans.ClinicaEndereco;
import beans.Endereco;
import beans.Login;
import facade.Facade;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
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
@WebServlet(name = "ClinicaServlet", urlPatterns = {"/ClinicaServlet"})
public class ClinicaServlet extends HttpServlet {

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
        Facade facade = new Facade();
        String status = "";

        if ("register".equals(action)) {
            try {
                String nomeFantasia = request.getParameter("nomeFantasia");
                String razaoSocial = request.getParameter("razaoSocial");
                String cnpj = request.getParameter("cnpj");
                String site = request.getParameter("site");
                String tel1 = request.getParameter("tel1");
                String tel2 = request.getParameter("tel2");
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String cep = request.getParameter("cep");
                String rua = request.getParameter("rua");
                String numero = request.getParameter("numero");
                String complemento = request.getParameter("compl");
                String bairro = request.getParameter("bairro");
                String cidadeString = request.getParameter("cidade");
                String matriz = "Principal";
                cnpj = cnpj.replace("-", "");
                cnpj = cnpj.replace(".", "");
                cnpj = cnpj.replace("/", "");
                tel1 = tel1.replace("(", "");
                tel1 = tel1.replace(")", "");
                tel1 = tel1.replace(" ", "");
                tel1 = tel1.replace("-", "");
                tel2 = tel2.replace("(", "");
                tel2 = tel2.replace(")", "");
                tel2 = tel2.replace(" ", "");
                tel2 = tel2.replace("-", "");
                cep = cep.replace("-", "");
                cep = cep.replace(".", "");

                Login login = new Login();
                senha = login.criptografa(senha);
                login = new Login(email, senha, 3);
                Clinica clinica = new Clinica(login, cnpj, razaoSocial, nomeFantasia, site);
                Cidade cidade = facade.getCidadePorNome(cidadeString);
                Endereco endereco = new Endereco(cidade, cep, rua, numero, complemento, bairro);
                ClinicaEndereco clinicaEndereco = new ClinicaEndereco(clinica, endereco, tel1, tel2, matriz);
                facade.inserirClinicaEndereco(clinicaEndereco);

                status = "cadastro-ok";
            } catch (ClassNotFoundException | SQLException ex) {
                status = "cadastro-erro";
            } catch (NoSuchAlgorithmException ex) {
                status = "criptografa-erro";
            }
            response.sendRedirect("login.jsp?status=" + status);
        } else if ("alter".equals(action)) {
            try {
                String nomeFantasia = request.getParameter("nomeFantasia");
                String razaoSocial = request.getParameter("razaoSocial");
                String site = request.getParameter("site");
                HttpSession session = request.getSession();
                Clinica clinica = (Clinica) session.getAttribute("usuario");
                clinica.setNomeFantasia(nomeFantasia);
                clinica.setRazaoSocial(razaoSocial);
                clinica.setSite(site);
                Facade.atualizarClinica(clinica);

                status = "alter-ok";
            } catch (ClassNotFoundException | SQLException ex) {
                status = "alter-error";
            }
            response.sendRedirect("ListaClinicaServlet?action=listaConfiguracao&status=" + status);
        } else if ("editEndereco".equals(action)) {
            int superid = 0;
            try {
                String id = request.getParameter("id");
                String cep = request.getParameter("cep");
                String rua = request.getParameter("rua");
                String numero = request.getParameter("numero");
                String compl = request.getParameter("compl");
                String bairro = request.getParameter("bairro");
                String cidadeString = request.getParameter("cidade");
                String tel1 = request.getParameter("tel1");
                String tel2 = request.getParameter("tel2");
                String matriz = request.getParameter("matriz");
                tel1 = tel1.replace("(", "");
                tel1 = tel1.replace(")", "");
                tel1 = tel1.replace(" ", "");
                tel1 = tel1.replace("-", "");
                tel2 = tel2.replace("(", "");
                tel2 = tel2.replace(")", "");
                tel2 = tel2.replace(" ", "");
                tel2 = tel2.replace("-", "");
                cep = cep.replace("-", "");
                cep = cep.replace(".", "");
                int idClinicaEndereco = Integer.parseInt(id);
                superid = idClinicaEndereco;
                HttpSession session = request.getSession();
                Clinica clinica = (Clinica) session.getAttribute("usuario");
                Endereco endereco = new Endereco();

                ClinicaEndereco clinicaEndereco = null;
                for (ClinicaEndereco clinicaEnderecoAux : clinica.getListaEnderecos()) {
                    if (clinicaEnderecoAux.getId() == idClinicaEndereco) {
                        clinicaEndereco = clinicaEnderecoAux;
                        clinicaEndereco.getEndereco().setBairro(bairro);
                        clinicaEndereco.getEndereco().setCep(cep);
                        clinicaEndereco.getEndereco().setComplemento(compl);
                        clinicaEndereco.getEndereco().setNumero(numero);
                        clinicaEndereco.getEndereco().setRua(rua);
                        clinicaEndereco.getEndereco().setId(clinicaEnderecoAux.getEndereco().getId());
                        break;
                    }
                }

                Cidade cidade2 = null;
                if (clinicaEndereco != null) {
                    clinicaEndereco.setClinica(clinica);
                    clinicaEndereco.setTelefone1(tel1);
                    clinicaEndereco.setTelefone2(tel2);
                    clinicaEndereco.setNome(matriz);
                    Facade.atualizarClinicaEndereco(clinicaEndereco);
                    if (!clinicaEndereco.getEndereco().getCidade().getNome().equals(cidadeString)) {
                        cidade2 = facade.getCidadePorNome(cidadeString);
                        endereco.setCidade(cidade2);
                    } else {
                        endereco.setCidade(clinicaEndereco.getEndereco().getCidade());
                    }
                }
                Facade.atualizarEndereco(endereco);
                status = "editEnd-ok";

            } catch (Exception ex) {
                status = "editEnd-erro";
            }
            response.sendRedirect("endereco-clinica.jsp?id=" + superid + "&status=" + status);

        } else if ("alterSenha".equals(action)) {
            HttpSession session = request.getSession();
            Clinica clinica = (Clinica) session.getAttribute("usuario");
            String senha = request.getParameter("senha-antiga");
            String novaSenha = request.getParameter("nova-senha");
            try {
                Login login = new Login();
                senha = login.criptografa(senha);
                novaSenha = login.criptografa(novaSenha);

                if (facade.senhaVerificada(clinica.getLogin().getId(), senha)) {
                    facade.editaSenha(clinica.getLogin().getId(), novaSenha);
                    clinica.getLogin().setSenha(novaSenha);
                    session.setAttribute("usuario", clinica);
                    status = "alterSenha-ok";
                } else {
                    status = "alterSenha-error";
                }
            } catch (ClassNotFoundException | SQLException | NullPointerException ex) {
                status = "alterSenha-error";
            } catch (NoSuchAlgorithmException ex) {
                status = "criptografa-erro";
            }
            response.sendRedirect("ListaClinicaServlet?action=listaConfiguracao&status=" + status + "#tabela");
        } else if ("newEndereco".equals(action)) {
            try {
                String tel1 = request.getParameter("tel1");
                String tel2 = request.getParameter("tel2");
                String cep = request.getParameter("cep");
                String rua = request.getParameter("rua");
                String numero = request.getParameter("numero");
                String complemento = request.getParameter("compl");
                String bairro = request.getParameter("bairro");
                String cidadeString = request.getParameter("cidade");
                String matriz = request.getParameter("matriz");
                tel1 = tel1.replace("(", "");
                tel1 = tel1.replace(")", "");
                tel1 = tel1.replace(" ", "");
                tel1 = tel1.replace("-", "");
                tel2 = tel2.replace("(", "");
                tel2 = tel2.replace(")", "");
                tel2 = tel2.replace(" ", "");
                tel2 = tel2.replace("-", "");
                cep = cep.replace("-", "");
                cep = cep.replace(".", "");
                HttpSession session = request.getSession();
                Clinica clinica = (Clinica) session.getAttribute("usuario");
                Cidade cidade = facade.getCidadePorNome(cidadeString);
                Endereco endereco = new Endereco(cidade, cep, rua, numero, complemento, bairro);
                endereco.setId(Facade.inserirEndereco(endereco));
                ClinicaEndereco clinicaEndereco = new ClinicaEndereco(clinica, endereco, tel1, tel2, matriz);
                clinicaEndereco.setId(facade.novaClinicaEndereco(clinicaEndereco));
                clinica.getListaEnderecos().add(clinicaEndereco);
                session.setAttribute("usuario", clinica);
                status = "newEnd-ok";

            } catch (Exception ex) {
                status = "newEnd-erro";
            }
            response.sendRedirect("endereco-clinica.jsp?status=" + status);
        } else if ("excludeEndereco".equals(action)) {
            try {
                String id = request.getParameter("id");
                int idClinicaEndereco = Integer.parseInt(id);
                HttpSession session = request.getSession();
                Clinica clinica = (Clinica) session.getAttribute("usuario");
                ClinicaEndereco clinicaEndereco = new ClinicaEndereco();
                for (ClinicaEndereco clinicaEnderecoAux : clinica.getListaEnderecos()) {
                    if (clinicaEnderecoAux.getId() == idClinicaEndereco) {
                        clinicaEndereco = clinicaEnderecoAux;
                        break;
                    }
                }
                clinicaEndereco.setClinica(clinica);
                facade.removerClinicaEndereco(clinicaEndereco);
                clinica.getListaEnderecos().remove(clinicaEndereco);
                session.setAttribute("usuario", clinica);
                status = "excludeEnd-ok";

            } catch (ClassNotFoundException | NumberFormatException | SQLException ex) {
                status = "excludeEnd-erro";
            }
            response.sendRedirect("ListaClinicaServlet?action=listaConfiguracao&status=" + status);
        } else if ("vincularMedico".equals(action)) {
            try {
                String idMedicoString = request.getParameter("idMedico");
                String idClinicaString = request.getParameter("idClinicaEndereco");
                int idMedico = Integer.parseInt(idMedicoString);
                int idClinicaEndereco = Integer.parseInt(idClinicaString);
                Facade.vincularMedicoClinica(idMedico, idClinicaEndereco);
                status = "vincula-ok";
            } catch (ClassNotFoundException | NumberFormatException | SQLException ex) {
                status = "vincula-erro";
            }
            response.sendRedirect("ListaMedicoServlet?action=listaMedicos&status=" + status);
        } else if ("excluir".equals(action)){
            HttpSession session = request.getSession();
            Clinica clinica = (Clinica) session.getAttribute("usuario");
            try {
                Facade.deletarLogin(clinica.getLogin().getId());
                Facade.deletarMedicosSemClinica();
                status = "excluir-ok";
                session = request.getSession(false);

                    if (session != null) {
                        session.invalidate();
                        response.sendRedirect("index.jsp?status=" + status);
                    }
            }  catch (ClassNotFoundException | SQLException ex) {
                    status = "erro-deleta";
                    response.sendRedirect("configuracoes-medico" + status);
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
