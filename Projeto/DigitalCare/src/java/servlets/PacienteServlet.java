/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Cidade;
import beans.Convenio;
import beans.ConvenioPaciente;
import beans.Endereco;
import beans.Login;
import beans.Medico;
import beans.Paciente;
import beans.PacienteUsuario;
import facade.Facade;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author JotaWind
 */
@WebServlet(name = "PacienteServlet", urlPatterns = {"/PacienteServlet"})
public class PacienteServlet extends HttpServlet {

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

        HttpSession verSession = request.getSession();
        if (verSession != null) {

            String action = request.getParameter("action");
            Facade facade = new Facade();
            String status = "";

            if ("register".equals(action)) {
                try {
                    String nome = request.getParameter("nome");
                    String sobrenome = request.getParameter("sobrenome");
                    String cpf = request.getParameter("cpf");
                    cpf = cpf.replace("-", "");
                    cpf = cpf.replace(".", "");
                    String dtnsc = request.getParameter("dtnsc");
                    String sexo = request.getParameter("sexo");
                    String tel1 = request.getParameter("tel1");
                    tel1 = tel1.replace("(", "");
                    tel1 = tel1.replace(")", "");
                    tel1 = tel1.replace(" ", "");
                    tel1 = tel1.replace("-", "");
                    String tel2 = request.getParameter("tel2");
                    tel2 = tel2.replace("(", "");
                    tel2 = tel2.replace(")", "");
                    tel2 = tel2.replace(" ", "");
                    tel2 = tel2.replace("-", "");
                    String email = request.getParameter("email");
                    String pssw = request.getParameter("pssw");
                    String cep = request.getParameter("cep");
                    cep = cep.replace("-", "");
                    cep = cep.replace(".", "");
                    String rua = request.getParameter("rua");
                    String numero = request.getParameter("numero");
                    String compl = request.getParameter("compl");
                    String bairro = request.getParameter("bairro");
                    String cidadeString = request.getParameter("cidade");
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");;
                    Date dataNasc = formatter.parse(dtnsc);
                    Login login = new Login();
                    pssw = login.criptografa(pssw);
                    Paciente paciente = new Paciente(cpf, nome, sobrenome, dataNasc, sexo);
                    Cidade cidade = facade.getCidadePorNome(cidadeString);
                    login = new Login(email, pssw, 1);
                    Endereco endereco = new Endereco(cidade, cep, rua, numero, compl, bairro);
                    PacienteUsuario pacienteUsuario = new PacienteUsuario(paciente, login, endereco, tel1, tel2);
                    facade.inserirPacienteUsuario(pacienteUsuario);

                    status = "cadastro-ok";
                } catch (ClassNotFoundException | SQLException | ParseException ex) {
                    status = "cadastro-erro";
                } catch (NoSuchAlgorithmException ex) {
                    status = "criptografa-erro";
                }
                response.sendRedirect("login.jsp?status=" + status);
            } else if ("meuPerfil".equals(action)) {
                try {
                    HttpSession session = request.getSession();
                    PacienteUsuario pacienteUsuario = (PacienteUsuario) session.getAttribute("usuario");
                    List<Convenio> convenios = Facade.getListaConvenios();
                    List<ConvenioPaciente> conveniosPaciente = Facade.getListaConveniosPaciente(pacienteUsuario.getPaciente().getId());
                    request.setAttribute("convenios", convenios);
                    request.setAttribute("conveniosPaciente", conveniosPaciente);
                    request.setAttribute("paciente", pacienteUsuario);
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "erro";
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/configuracoes-paciente.jsp");
                rd.forward(request, response);
            } else if ("alteraPerfil".equals(action)) {
                try {
                    //Pega dos input dados informados
                    int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
                    String nome = request.getParameter("nome");
                    String sobrenome = request.getParameter("sobrenome");
                    String cpf = request.getParameter("cpf");
                    cpf = cpf.replace("-", "");
                    cpf = cpf.replace(".", "");
                    String dtnsc = request.getParameter("dtnsc");
                    String sexo = request.getParameter("sexo");
                    String tel1 = request.getParameter("tel1");
                    tel1 = tel1.replace("(", "");
                    tel1 = tel1.replace(")", "");
                    tel1 = tel1.replace(" ", "");
                    tel1 = tel1.replace("-", "");
                    String tel2 = request.getParameter("tel2");
                    tel2 = tel2.replace("(", "");
                    tel2 = tel2.replace(")", "");
                    tel2 = tel2.replace(" ", "");
                    tel2 = tel2.replace("-", "");
                    String email = request.getParameter("email");
                    String cep = request.getParameter("cep");
                    cep = cep.replace("-", "");
                    cep = cep.replace(".", "");
                    String rua = request.getParameter("rua");
                    String numero = request.getParameter("numero");
                    String compl = request.getParameter("compl");
                    String bairro = request.getParameter("bairro");
                    String cidadeString = request.getParameter("cidade");
                    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                    Date dataNasc = formatter.parse(dtnsc);
                    //Instancia os objetos
                    Paciente paciente = new Paciente(idPaciente, cpf, nome, sobrenome, dataNasc, sexo);
                    Cidade cidade = facade.getCidadePorNome(cidadeString);
                    Login login = new Login(email);
                    Endereco endereco = new Endereco(cidade, cep, rua, numero, compl, bairro);

                    List<ConvenioPaciente> listaConveniosPaciente = new ArrayList();

                    //Coletando os id's das especialidades selecionadas
                    if (!"0".equals(request.getParameter("idconvenio1"))) {
                        Convenio convenio = Facade.buscarConvenioPorId(Integer.parseInt(request.getParameter("idconvenio1")));
                        String numeroConvenio = request.getParameter("nconvenio1");
                        String validadeConvenio = request.getParameter("vconvenio1");
                        Date dataConvenio = formatter.parse(validadeConvenio);
                        ConvenioPaciente convenioPaciente = new ConvenioPaciente(paciente, convenio, numeroConvenio, dataConvenio);
                        listaConveniosPaciente.add(convenioPaciente);
                    }
                    if (!"0".equals(request.getParameter("idconvenio2"))) {
                        Convenio convenio = Facade.buscarConvenioPorId(Integer.parseInt(request.getParameter("idconvenio2")));
                        String numeroConvenio = request.getParameter("nconvenio2");
                        String validadeConvenio = request.getParameter("vconvenio2");
                        Date dataConvenio = formatter.parse(validadeConvenio);
                        ConvenioPaciente convenioPaciente = new ConvenioPaciente(paciente, convenio, numeroConvenio, dataConvenio);
                        listaConveniosPaciente.add(convenioPaciente);
                    }

//                    if (!"0".equals(request.getParameter("idconvenio3"))) {
//                        Convenio convenio = Facade.buscarConvenioPorId(Integer.parseInt(request.getParameter("idconvenio3")));
//                        String numeroConvenio = request.getParameter("nconvenio3");
//                        String validadeConvenio = request.getParameter("vconvenio3");
//                        Date dataConvenio = formatter.parse(validadeConvenio);
//                        ConvenioPaciente convenioPaciente = new ConvenioPaciente(paciente, convenio, numeroConvenio, dataConvenio);
//                        listaConveniosPaciente.add(convenioPaciente);
//                    }
//
//                    if (!"0".equals(request.getParameter("idconvenio4"))) {
//                        Convenio convenio = Facade.buscarConvenioPorId(Integer.parseInt(request.getParameter("idconvenio4")));
//                        String numeroConvenio = request.getParameter("nconvenio4");
//                        String validadeConvenio = request.getParameter("vconvenio4");
//                        Date dataConvenio = formatter.parse(validadeConvenio);
//                        ConvenioPaciente convenioPaciente = new ConvenioPaciente(paciente, convenio, numeroConvenio, dataConvenio);
//                        listaConveniosPaciente.add(convenioPaciente);
//                    }
                    //Deletando todas as especialidades do médico
                    Facade.deletarConveniosPaciente(paciente.getId());

                    //Inserindo as especialidades selecionadas
                    for (ConvenioPaciente convenio : listaConveniosPaciente) {
                        Facade.inserirConvenioPaciente(convenio);
                    }

                    paciente.setListaConvenios(listaConveniosPaciente);

                    PacienteUsuario pacienteUsuario = new PacienteUsuario(paciente, login, endereco, tel1, tel2);
                    facade.alteraPacienteUsuario(pacienteUsuario);
                    //Atualiza a sessao com os dados do bens modificados
                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", pacienteUsuario);

                    status = "altera-ok";
                } catch (ParseException | SQLException | ClassNotFoundException ex) {
                    status = "altera-erro";
                }
                response.sendRedirect("PacienteServlet?status=" + status + "&action=meuPerfil");
            } else if ("alteraSenha".equals(action)) {
                HttpSession session = request.getSession();
                PacienteUsuario pacienteUsuario = (PacienteUsuario) session.getAttribute("usuario");
                String senha = request.getParameter("senha-antiga");
                String novaSenha = request.getParameter("nova-senha");
                try {
                    Login login = new Login();
                    senha = login.criptografa(senha);
                    novaSenha = login.criptografa(novaSenha);

                    if (facade.verificaSenhaPacienteUsuario(pacienteUsuario.getLogin().getId(), senha)) {
                        facade.editaSenhaPacienteUsuario(pacienteUsuario, novaSenha);
                        pacienteUsuario.getLogin().setSenha(novaSenha);
                        session.setAttribute("usuario", pacienteUsuario);
                        status = "alterar-senha-ok";
                    } else {
                        status = "error-senha";
                    }
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "error-senha";
                } catch (NoSuchAlgorithmException ex) {
                    status = "error-criptografa";
                }
                response.sendRedirect("PacienteServlet?action=meuPerfil&status=" + status + "#bairro");
            } else if ("deletaUsuario".equals(action)) {
                HttpSession session = request.getSession();
                PacienteUsuario pacienteUsuario = (PacienteUsuario) session.getAttribute("usuario");
                try {
                    facade.desativaConta(pacienteUsuario);
                    session = request.getSession(false);

                    if (session != null) {
                        session.invalidate();
                        response.sendRedirect("index.jsp?status=" + status);
                    }
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "erro-deleta";
                    response.sendRedirect("configuracoes-paciente" + status);
                }
            } else if ("perfilPacienteMedico".equals(action)) {
                HttpSession session = request.getSession();
                Medico medID = (Medico) session.getAttribute("usuario");
                int idPaciente = Integer.parseInt(request.getParameter("idPaciente"));
                try {
                    PacienteUsuario pacienteUsuario;
                    pacienteUsuario = facade.carregaPerfilPaciente(medID.getId(), idPaciente);
                    request.setAttribute("perfilPaciente", pacienteUsuario);
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "errorList";
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/perfil-paciente.jsp");
                rd.forward(request, response);

            }
        } else {
            response.sendRedirect("login.jsp");
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
